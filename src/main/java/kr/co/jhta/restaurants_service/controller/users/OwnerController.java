package kr.co.jhta.restaurants_service.controller.users;

import kr.co.jhta.restaurants_service.controller.command.FoodCommand;
import kr.co.jhta.restaurants_service.controller.command.StoreCommand;
import kr.co.jhta.restaurants_service.controller.command.StoreOpenTimeCommand;
import kr.co.jhta.restaurants_service.controller.command.UserCommand;
import kr.co.jhta.restaurants_service.dto.StoreDetailDto;
import kr.co.jhta.restaurants_service.security.domain.SecurityUser;
import kr.co.jhta.restaurants_service.security.service.UserService;
import kr.co.jhta.restaurants_service.service.StoreService;
import kr.co.jhta.restaurants_service.vo.store.Store;
import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/owner")
public class OwnerController {

    @Value("${data.go.kr.service-key}")
    private String serviceKey;
    private final Logger logger = Logger.getLogger(UserController.class);
    private final UserService userService;
    private final StoreService storeService;

    public OwnerController(UserService userService, StoreService storeService) {
        this.userService = userService;
        this.storeService = storeService;
    }

    @ResponseBody
    @GetMapping("/store-categories")
    private ResponseEntity<List<String>> categories() {

        List<String> categoryNames = Arrays.stream(Store.CATEGORY.values()).map(Enum::name).collect(Collectors.toList());

        return ResponseEntity.ok(categoryNames);
    }

    @PostMapping("/register-hour")
    private ResponseEntity<List<StoreOpenTimeCommand>> registerHour(@RequestBody StoreOpenTimeCommand storeOpenTimeCommand, HttpSession httpSession) {

        List<String> clickedDays = Optional.ofNullable((List<String>) httpSession.getAttribute("clickedDays")).orElse(new ArrayList<>());
        List<String> registeredDays = Optional.ofNullable((List<String>) httpSession.getAttribute("registeredDays")).orElse(new ArrayList<>());

        // filter out non-ongoing days
        List<String> toBeRegistered = clickedDays.stream().filter(day -> !registeredDays.contains(day)).collect(Collectors.toList());

        registeredDays.addAll(toBeRegistered);

        // for flushing resource server
        List<StoreOpenTimeCommand> registeredStoreOpenTimes = registeredDays.stream().map(day -> {
            return new StoreOpenTimeCommand(day, storeOpenTimeCommand.getOpeningTime(), storeOpenTimeCommand.getClosingTime());
        }).collect(Collectors.toList());

        httpSession.setAttribute("registeredStoreOpenTimes", registeredStoreOpenTimes);
        httpSession.setAttribute("registeredDays", registeredDays);

        // for flushing client representation
        List<StoreOpenTimeCommand> toBeRegisteredStoreOpenTimeCommands = toBeRegistered.stream().map(day -> {
            return new StoreOpenTimeCommand(day, storeOpenTimeCommand.getOpeningTime(), storeOpenTimeCommand.getClosingTime());
        }).collect(Collectors.toList());

        return new ResponseEntity<>(toBeRegisteredStoreOpenTimeCommands, HttpStatus.OK);
    }

    @GetMapping("/unique-day")
    private ResponseEntity uniqueDay(@RequestParam("dayName") String toBeChecked, HttpSession httpSession) {

        List<String> clickedDays = Optional.ofNullable((List<String>) httpSession.getAttribute("clickedDays")).orElse(new ArrayList<>());

        return clickedDays
                .stream()
                .anyMatch(dayName -> toBeChecked.equals(dayName)) ?
                ResponseEntity.badRequest().body("Already added day!") :
                ResponseEntity.ok().body("Unique day!");
    }

    @PostMapping("/remove-day")
    public ResponseEntity removeDay(@RequestParam("dayName") String toBeRemoved, HttpSession httpSession) {

        List<String> clickedDays = Optional.ofNullable((List<String>) httpSession.getAttribute("clickedDays")).orElse(new ArrayList<>());
        List<String> registeredDays = Optional.ofNullable((List<String>) httpSession.getAttribute("registeredDays")).orElse(new ArrayList<>());
        List<StoreOpenTimeCommand> registeredStoreOpenTimes = Optional.ofNullable((List<StoreOpenTimeCommand>) httpSession.getAttribute("registeredStoreOpenTimes")).orElse(new ArrayList<>());

        clickedDays = clickedDays.stream().filter(day -> !toBeRemoved.equals(day)).collect(Collectors.toList());
        httpSession.setAttribute("clickedDays", clickedDays);

        registeredDays = registeredDays.stream().filter(day -> !toBeRemoved.equals(day)).collect(Collectors.toList());
        httpSession.setAttribute("registeredDays", registeredDays);

        registeredStoreOpenTimes = registeredStoreOpenTimes.stream().filter(openTime -> !toBeRemoved.equals(openTime.getDay())).collect(Collectors.toList());

        httpSession.setAttribute("registeredStoreOpenTimes", registeredStoreOpenTimes);

        return ResponseEntity.ok().body("Successfully removed.");
    }

    @PostMapping("/register-day")
    public ResponseEntity registerDay(@RequestParam("dayName") String dayName, HttpSession httpSession) {

        List<String> clickedDays = Optional.ofNullable((List<String>) httpSession.getAttribute("clickedDays")).orElse(new ArrayList<>());

        clickedDays.add(dayName);
        httpSession.setAttribute("clickedDays", clickedDays);

        return ResponseEntity.ok().body("Successfully added.");
    }

    @GetMapping("/unique-food")
    public ResponseEntity uniqueFood(@RequestParam("foodName") String toBeChecked, HttpSession httpSession) {

        List<FoodCommand> foods = Optional.ofNullable((List<FoodCommand>) httpSession.getAttribute("foods")).orElse(new ArrayList<>());

        return foods.stream()
                .map(FoodCommand::getFoodName)
                .anyMatch(foodName -> toBeChecked.equals(foodName)) ?
                ResponseEntity.badRequest().body("Already exists :(") :
                ResponseEntity.ok().body("Unique food name!");
    }

    @PostMapping("/remove-food")
    public ResponseEntity removeFood(@RequestParam("foodName") String toBeRemoved, HttpSession httpSession) {

        List<FoodCommand> foods = Optional.ofNullable((List<FoodCommand>) httpSession.getAttribute("foods")).orElse(new ArrayList<>());

        foods = foods.stream().filter(food -> !toBeRemoved.equals(food.getFoodName())).collect(Collectors.toList());

        httpSession.setAttribute("foods", foods);

        return ResponseEntity.ok().body("Successfully removed.");
    }

    @PostMapping("/register-food")
    public ResponseEntity<FoodCommand> registerFood(@RequestBody FoodCommand foodCommand, HttpSession httpSession) {

        List<FoodCommand> foods = Optional.ofNullable((List<FoodCommand>) httpSession.getAttribute("foods")).orElse(new ArrayList<>());

        foods.add(foodCommand);
        httpSession.setAttribute("foods", foods);

        return new ResponseEntity<>(foodCommand, HttpStatus.OK);
    }

    @PostMapping("/register")
    public ResponseEntity registerStore(@RequestBody StoreCommand storeCommand,
                                        @AuthenticationPrincipal SecurityUser securityUser,
                                        HttpSession httpSession) {

        List<FoodCommand> foods = Optional.ofNullable((List<FoodCommand>) httpSession.getAttribute("foods")).orElse(new ArrayList<>());
        List<StoreOpenTimeCommand> storeOpenTimes = Optional.ofNullable((List<StoreOpenTimeCommand>) httpSession.getAttribute("registeredStoreOpenTimes")).orElse(new ArrayList<>());

        storeService.insertStore(storeCommand, foods, storeOpenTimes, securityUser);

        httpSession.setAttribute("foods", null);
        httpSession.setAttribute("registeredStoreOpenTimes", null);
        httpSession.setAttribute("registeredDays", null);
        httpSession.setAttribute("clickedDays", null);

        return ResponseEntity.ok().body("Successfully registered!");
    }

    @GetMapping("/register")
    public String registerPage(@AuthenticationPrincipal SecurityUser securityUser) {

        return "/user/owner/store-register-form";
    }


    @GetMapping("/business-validation-service-key")
    public ResponseEntity businessValidationServiceKey() {

        return ResponseEntity.ok().body(serviceKey);
    }

    @ResponseBody
    @PostMapping(value = "/signup", consumes = "application/json")
    public ResponseEntity signup(@RequestBody UserCommand userCommand) {

        userService.insertOwner(userCommand);
        return ResponseEntity.ok("Successfully signed up!");
    }

    @GetMapping("/signup")
    public String signupForm(Model model) {
        model.addAttribute("userCommand", new UserCommand());
        return "user/owner/signup-form";
    }

    @GetMapping("/my-page")
    public String myPage(@AuthenticationPrincipal SecurityUser securityUser, Model model) {

        List<Store> stores = storeService.getStoresByUserId(securityUser.getUser().getId());

        model.addAttribute("owner", securityUser.getUser());
        model.addAttribute("stores", stores);

        return "user/owner/my-page";
    }

    @GetMapping("/stores")
    public ResponseEntity<List<StoreDetailDto>> stores(@AuthenticationPrincipal SecurityUser securityUser,
                                                       @RequestParam("page") Optional<Integer> page,
                                                       @RequestParam("limit") Optional<Integer> limit,
                                                       @RequestParam("id") Optional<Integer> othersId) {

        List<StoreDetailDto> stores = storeService.getPaginatedStoresByUserId(
                othersId.orElse(securityUser.getUser().getId()),
                page.orElse(0),
                limit.orElse(3)
        );

        return ResponseEntity.ok(stores);
    }

    public static String[] PUBLIC_URLS = { "/owner/signup" };
}
