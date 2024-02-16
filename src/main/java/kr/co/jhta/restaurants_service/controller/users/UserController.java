package kr.co.jhta.restaurants_service.controller.users;

import kr.co.jhta.restaurants_service.dto.FollowRequestDto;
import kr.co.jhta.restaurants_service.projection.Projection;
import kr.co.jhta.restaurants_service.security.domain.SecurityUser;
import kr.co.jhta.restaurants_service.security.service.UserService;
import kr.co.jhta.restaurants_service.service.PostService;
import kr.co.jhta.restaurants_service.service.ReviewService;
import kr.co.jhta.restaurants_service.service.SocialService;
import kr.co.jhta.restaurants_service.vo.user.User;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;


@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;
    private final SocialService socialService;
    private final PostService postService;
    private final ReviewService reviewService;

    public UserController(UserService userService, SocialService socialService, PostService postService, ReviewService reviewService) {
        this.userService = userService;
        this.socialService = socialService;
        this.postService = postService;
        this.reviewService = reviewService;
    }

    public static String[] PUBLIC_URLS = {
            "/user/check-username",
            "/user/check-nickname",
            "/user/check-email",
            "/user/unique-phone",
            "/user/login"
    };

    @ResponseBody
    @GetMapping("/check-username")
    public ResponseEntity isUsernameUnique(@RequestParam("username") String username) {

        if (userService.existsDuplicateUsersByUsername(username)) {
            return ResponseEntity.badRequest().body("User already exists with the given username.");
        } else {
            return ResponseEntity.ok().body("Unique username!");
        }
    }

    @ResponseBody
    @GetMapping("/check-nickname")
    public ResponseEntity isNicknameUnique(@RequestParam("nickname") String nickname) {

        if (userService.existsDuplicateUsersByNickname(nickname)) {
            return ResponseEntity.badRequest().body("User already exists with the given nickname.");
        } else {
            return ResponseEntity.ok().body("Unique nickname!");
        }
    }

    @ResponseBody
    @GetMapping("/check-email")
    public ResponseEntity isEmailUnique(@RequestParam("email") String email) {

        if (userService.existsDuplicateUsersByEmail(email)) {
            return ResponseEntity.badRequest().body("User already exists with the given email.");
        } else {
            return ResponseEntity.ok().body("Unique email!");
        }
    }

    @ResponseBody
    @GetMapping("/unique-phone")
    public ResponseEntity isPhoneUnique(@RequestParam("phone") String phone) {

        if (userService.existsDuplicateUsersByPhone(phone)) {
            return ResponseEntity.badRequest().body("User already exists with the given email.");
        } else {
            return ResponseEntity.ok().body("Unique email!");
        }
    }

    @ResponseBody
    @PostMapping("/follow")
    public ResponseEntity followPost(@RequestParam("recipientId") int recipientId,
                                     @AuthenticationPrincipal SecurityUser securityUser) {

        if (recipientId == securityUser.getUser().getId()) {
            // do nothing
            return ResponseEntity.ok().build();
        }

        if (socialService.handleFollowRequest(securityUser.getUser().getId(), recipientId)) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.badRequest().build();
        }
    }

    @ResponseBody
    @GetMapping("/follow")
    public String follow(@RequestParam("id") int othersId,
                         @AuthenticationPrincipal SecurityUser securityUser) {

        int thisId = securityUser.getUser().getId();

        // if a user visiting her/his own page, or, does the other user follows the current user, return true.
        if (othersId == thisId || socialService.doesThisUserFollowsOtherUser(thisId, othersId)) {
            return "YES";
        } else {
            return "NO";
        }
    }

    @ResponseBody
    @GetMapping("/followers")
    public ResponseEntity<List<Projection.User>> followers(@AuthenticationPrincipal SecurityUser securityUser,
                                                           @RequestParam("page") Optional<Integer> page,
                                                           @RequestParam("limit") Optional<Integer> limit,
                                                           @RequestParam("id") Optional<Integer> othersId) {

        List<Projection.User> followers =
                socialService.getNonDisabledFollowersByCustomerIdOrderByCreateDate(
                        othersId.orElse(securityUser.getUser().getId()),
                        User.DISABLED.NO,
                        page.orElse(0),
                        limit.orElse(7)
                );

        return ResponseEntity.of(Optional.ofNullable(followers));
    }

    @ResponseBody
    @GetMapping("/followings")
    public ResponseEntity<List<Projection.User>> followings(@AuthenticationPrincipal SecurityUser securityUser,
                                                            @RequestParam("page") Optional<Integer> page,
                                                            @RequestParam("limit") Optional<Integer> limit,
                                                            @RequestParam("id") Optional<Integer> othersId) {

        List<Projection.User> followers =
                socialService.getNonDisabledFollowingsByCustomerIdOrderByCreateDate(
                        othersId.orElse(securityUser.getUser().getId()),
                        User.DISABLED.NO,
                        page.orElse(0),
                        limit.orElse(7)
                );

        return ResponseEntity.of(Optional.ofNullable(followers));
    }

    @ResponseBody
    @GetMapping("/followers-count")
    public long followersCount(@AuthenticationPrincipal SecurityUser securityUser,
                               @RequestParam("id") Optional<Integer> othersId) {

        return socialService.getFollowersCountByCustomerId(
                othersId.orElse(securityUser.getUser().getId())
        );
    }

    @ResponseBody
    @GetMapping("/followings-count")
    public long followingsCount(@AuthenticationPrincipal SecurityUser securityUser,
                                @RequestParam("id") Optional<Integer> othersId) {

        return socialService.getFollowingsCountByCustomerId(
                othersId.orElse(securityUser.getUser().getId())
        );
    }

    @ResponseBody
    @GetMapping("/requests")
    public List<FollowRequestDto> followRequests(@AuthenticationPrincipal SecurityUser securityUser,
                                                 @RequestParam("option") String option,
                                                 @RequestParam("page") int page,
                                                 @RequestParam("limit") int limit) {

        Integer customerId = securityUser.getUser().getId();

        if (option.equals("pending")) {
            return socialService.getArrivedRequestsPendingByRecipientId(customerId, page, limit);
        } else if (option.equals("accepted")) {
            return socialService.getArrivedRequestsAcceptedByRecipientId(customerId, page, limit);
        } else if (option.equals("declined")) {
            return socialService.getArrivedRequestsDeniedByRecipientId(customerId, page, limit);
        } else { // ?option=sent
            return socialService.getSentRequestsBySenderId(customerId, page, limit);
        }
    }

    // authenticated
    @ResponseBody
    @PostMapping("/requests-modify")
    public String followRequestsModify(@RequestParam("requestId") int requestId, @AuthenticationPrincipal SecurityUser securityUser) {

        return socialService.updateRequestStatus(requestId, securityUser.getUser().getId());
    }

    @GetMapping("/details")
    public String userDetailsPage(@RequestParam("id") int userId, Model model) {

        User user = userService.getUserById(userId);

        if (user.getType().equals(User.TYPE.CUSTOMER)) {
            long postsCount = postService.getPostsCountByCustomerId(userId);
            long reviewsCount = reviewService.getReviewsCountByCustomerId(userId);

            model.addAttribute("customer", user);
            model.addAttribute("postsCount", postsCount);
            model.addAttribute("reviewsCount", reviewsCount);

            return "/user/customer/user-details";
        } else {
            model.addAttribute("owner", user);

            return "/user/owner/user-details";
        }
    }

    @ResponseBody
    @GetMapping("/visibility")
    public String visibility(@RequestParam("id") Optional<Integer> userId,
                             @AuthenticationPrincipal SecurityUser securityUser) {

        User user = userService.getUserById(userId.orElse(securityUser.getUser().getId()));

        return user.getVisibility().toString();
    }

    @ResponseBody
    @PostMapping("/visibility")
    public void visibility(@AuthenticationPrincipal SecurityUser securityUser) {

        userService.modifyVisibility(securityUser);
    }

    @GetMapping("/login")
    public String loginForm() {
        return "user/login";
    }
}
