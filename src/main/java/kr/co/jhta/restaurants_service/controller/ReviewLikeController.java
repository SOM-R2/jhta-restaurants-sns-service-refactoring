package kr.co.jhta.restaurants_service.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.jhta.restaurants_service.security.domain.SecurityUser;
import kr.co.jhta.restaurants_service.service.BookmarkService;
import kr.co.jhta.restaurants_service.service.ReviewLikeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/like")
@Slf4j
public class ReviewLikeController {
	private final ReviewLikeService reviewLikeService ;
	
	@GetMapping("/insert")
	@ResponseBody
	public int insertLike(@AuthenticationPrincipal SecurityUser user, int reviewId) {
		return reviewLikeService.insertLike(user.getUser().getId(), reviewId);
		
	}
	
	@GetMapping("/delete")
	@ResponseBody
	public int deleteLike(@AuthenticationPrincipal SecurityUser user, int reviewId) {
		return reviewLikeService.deleteLike(user.getUser().getId(), reviewId);
	}

	
}
