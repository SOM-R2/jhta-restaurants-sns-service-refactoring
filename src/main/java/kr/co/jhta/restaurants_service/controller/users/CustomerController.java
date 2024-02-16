package kr.co.jhta.restaurants_service.controller.users;

import kr.co.jhta.restaurants_service.controller.command.OtpCommand;
import kr.co.jhta.restaurants_service.controller.command.UserCommand;
import kr.co.jhta.restaurants_service.dto.FollowRequestDto;
import kr.co.jhta.restaurants_service.projection.Projection;
import kr.co.jhta.restaurants_service.security.domain.SecurityUser;
import kr.co.jhta.restaurants_service.security.service.UserService;
import kr.co.jhta.restaurants_service.service.OtpService;
import kr.co.jhta.restaurants_service.service.PostService;
import kr.co.jhta.restaurants_service.service.ReviewService;
import kr.co.jhta.restaurants_service.service.SocialService;
import kr.co.jhta.restaurants_service.vo.post.Post;
import kr.co.jhta.restaurants_service.vo.post.PostData;
import kr.co.jhta.restaurants_service.vo.review.Review;
import kr.co.jhta.restaurants_service.vo.review.ReviewPicture;
import kr.co.jhta.restaurants_service.vo.user.Otp;
import org.jboss.logging.Logger;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Optional;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    public static String[] PUBLIC_URLS = {
            "/customer/signup",
            "/customer/otp",
            "/customer/otp-check",
            "/customer/details"
    };
    private final UserService userService;
    private final OtpService otpService;
    private final PostService postService;
    private final SocialService socialService;
    private final ReviewService reviewService;
    Logger logger = Logger.getLogger(UserController.class);

    public CustomerController(UserService userService, OtpService otpService, PostService postService, SocialService socialService, ReviewService reviewService) {
        this.userService = userService;
        this.otpService = otpService;
        this.postService = postService;
        this.socialService = socialService;
        this.reviewService = reviewService;
    }

    @ResponseBody
    @GetMapping("posts-count")
    public long postsCount(@RequestParam("id") int othersId) {
        return postService.getPostsCountByCustomerId(othersId);
    }

    @ResponseBody
    @GetMapping("reviews-count")
    public long reviewsCount(@RequestParam("id") int othersId) {
        return reviewService.getReviewsCountByCustomerId(othersId);
    }

    @ResponseBody
    @GetMapping("/postData")
    public ResponseEntity<Page<PostData>> pictureData(@AuthenticationPrincipal SecurityUser securityUser,
                                                      @RequestParam("page") Optional<Integer> page,
                                                      @RequestParam("limit") Optional<Integer> limit,
                                                      @RequestParam("id") Optional<Integer> othersId) {

        Page<PostData> postData =
                postService.getPostDataByCustomerIdOrderByCreateDateDesc(
                        othersId.orElse(securityUser.getUser().getId()),
                        page.orElse(0),
                        limit.orElse(9)
                );

        return ResponseEntity.of(Optional.ofNullable(postData));
    }

    @ResponseBody
    @GetMapping("/reviewData")
    public ResponseEntity<Page<ReviewPicture>> reviewData(@AuthenticationPrincipal SecurityUser securityUser,
                                                          @RequestParam("page") Optional<Integer> page,
                                                          @RequestParam("limit") Optional<Integer> limit,
                                                          @RequestParam("id") Optional<Integer> othersId) {

        Page<ReviewPicture> reviewData =
                reviewService.getReviewPicturesByCustomerIdOrderByCreateDateDesc(
                        othersId.orElse(securityUser.getUser().getId()),
                        page.orElse(0),
                        limit.orElse(9)
                );

        return ResponseEntity.of(Optional.ofNullable(reviewData));
    }

    @ResponseBody
    @GetMapping("/reviews")
    public ResponseEntity<Page<Projection.Review>> reviews(@AuthenticationPrincipal SecurityUser securityUser,
                                                           @RequestParam("page") Optional<Integer> page,
                                                           @RequestParam("limit") Optional<Integer> limit,
                                                           @RequestParam("id") Optional<Integer> othersId) {
        Page<Projection.Review> reviews =
                reviewService.getNonBlockedReviewsByCustomerIdOrderByCreateDate(
                        othersId.orElse(securityUser.getUser().getId()),
                        Review.BLOCKED.NO,
                        page.orElse(0),
                        limit.orElse(10)
                );

        return ResponseEntity.of(Optional.ofNullable(reviews));
    }

    @ResponseBody
    @GetMapping("/posts")
    public ResponseEntity<Page<Projection.Post>> posts(@AuthenticationPrincipal SecurityUser securityUser,
                                                       @RequestParam("page") Optional<Integer> page,
                                                       @RequestParam("limit") Optional<Integer> limit,
                                                       @RequestParam("id") Optional<Integer> othersId) {
        Page<Projection.Post> posts =
                postService.getNonBlockedPostsByCustomerIdOrderByCreateDate(
                        othersId.orElse(securityUser.getUser().getId()),
                        Post.BLOCKED.NO,
                        page.orElse(0),
                        limit.orElse(10)
                );

        return ResponseEntity.of(Optional.ofNullable(posts));
    }

    @ResponseBody
    @PostMapping(value = "/otp-check", consumes = "application/json")
    public ResponseEntity otpCheck(@RequestBody OtpCommand otpCommand, HttpSession session) {

        UserCommand userCommand = Optional.ofNullable((UserCommand) session.getAttribute("userCommand")).orElse(null);

        boolean isValid = otpService.validateOtp(otpCommand);

        if (isValid) {
            userService.insertCustomer(userCommand);
            session.setAttribute("userCommand", null);

            return ResponseEntity.ok("Valid otp!");
        } else {
            session.setAttribute("userCommand", null);
            return ResponseEntity.badRequest().body("Invalid otp!");
        }
    }

    @ResponseBody
    @GetMapping("/otp")
    public ResponseEntity otpIssue(@RequestParam("email") String email) {

        Otp otp = otpService.issueOtp(email);

        return ResponseEntity.ok().body("Otp got successfully issued");
    }

    @ResponseBody
    @PostMapping(value = "/signup", consumes = "application/json")
    public ResponseEntity signup(@RequestBody UserCommand userCommand, HttpSession session) {

        session.setAttribute("userCommand", userCommand);

        return null;
    }

    @GetMapping("/signup")
    public String signupForm(HttpSession httpSession) {

        return "user/customer/signup-form";
    }

    @GetMapping("/my-page")
    public String myPage(@AuthenticationPrincipal SecurityUser securityUser, Model model) {

        Integer customerId = securityUser.getUser().getId();

        long postsCount = postService.getPostsCountByCustomerId(customerId);
        long reviewsCount = reviewService.getReviewsCountByCustomerId(customerId);

        model.addAttribute("customer", securityUser.getUser());
        model.addAttribute("postsCount", postsCount);
        model.addAttribute("reviewsCount", reviewsCount);

        return "/user/customer/my-page";
    }
}
