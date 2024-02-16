package kr.co.jhta.restaurants_service.controller;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import kr.co.jhta.restaurants_service.controller.command.SearchParamCommand;
import kr.co.jhta.restaurants_service.dto.*;
import kr.co.jhta.restaurants_service.mapper.BookmarkMapper;
import kr.co.jhta.restaurants_service.vo.post.Post;
import kr.co.jhta.restaurants_service.vo.review.Review;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

//import kr.co.jhta.restaurants_service.dto.ReviewDetailDto;
//import kr.co.jhta.restaurants_service.dto.ReviewDto;
import kr.co.jhta.restaurants_service.security.domain.SecurityUser;
import kr.co.jhta.restaurants_service.service.BookmarkService;
import kr.co.jhta.restaurants_service.service.PostService;
import kr.co.jhta.restaurants_service.service.ReviewService;
import kr.co.jhta.restaurants_service.service.StoreService;
import kr.co.jhta.restaurants_service.vo.store.Bookmark;
import kr.co.jhta.restaurants_service.vo.store.Store;
import kr.co.jhta.restaurants_service.vo.store.StoreOpenTime;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/store")
@Slf4j
public class StoreController {

	public static final String SEARCH = "/store/search";
	private final StoreService storeService;
	private final ReviewService reviewService;
	private final PostService postService;

	public static String[] PUBLIC_URLS = {
			"/store/detail",
			"/store/stores",
			"/store/search",
			"/store/posts",
			"/store/history",
			"/store/open-times",
			"/store/detail/reviews"
	};
	
	@GetMapping("/stores")
	@ResponseBody
	public PagedStores searchResult(
							   @RequestParam(name="sort", required = false, defaultValue="rating") String sort,
							   @RequestParam(name="page", required = false, defaultValue="1") int page,
							   SearchParamCommand searchParam) {
		log.info("sort='{}', page='{}', category='{}', keyword='{}'", sort, page, searchParam.getCategory(), searchParam.getKeyword());
		log.info("xStart='{}', xEnd='{}', yStart='{}', yEnd='{}'", searchParam.getXStart(), searchParam.getXEnd(), searchParam.getYStart(), searchParam.getYEnd());

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("sort", sort);
		param.put("page", page);
		
		if(searchParam.getXStart()!= null) {
			param.put("xStart", searchParam.getXStart());
			param.put("xEnd", searchParam.getXEnd());
			param.put("yStart", searchParam.getYStart());
			param.put("yEnd", searchParam.getYEnd());
		}
		if (StringUtils.hasText(searchParam.getKeyword())) {
			param.put("keyword", searchParam.getKeyword());
		}
		if (StringUtils.hasText(searchParam.getCategory())) {
			param.put("category", searchParam.getCategory());
		}
		
		return storeService.getStores(param);
	}

	@GetMapping("/search")
	public String search(@RequestParam(name="keyword", required = false, defaultValue="") String keyword, Model model) {
		model.addAttribute("keyword",keyword);
		return "search";
	}
	
	@GetMapping("/posts")
	@ResponseBody
	public List<PostContentsDto> search(SearchParamCommand searchParam) {
		
		return postService.getPostsByStoreSearch(searchParam);
	}
	
	@GetMapping("/bookmark")
	@ResponseBody
	public List<BookmarkedStore> searchBookmark(@AuthenticationPrincipal SecurityUser user) {
		List<BookmarkedStore> stores = storeService.getBookmarkedStore(user.getUser().getId());
		log.info("----------------searchBookmark");
		log.info("----------------searchBookmark" + stores );
		
		return stores;
	}
	
	@GetMapping("/history")
	@ResponseBody
	public List<VisitedStore> searchHistory(@RequestParam("id") List<Integer> storeIds, @AuthenticationPrincipal SecurityUser user){
		if (user != null) {
			Map<String,Object> param = new HashMap<>();
			
			param.put("storeIds", storeIds);
			log.info("param.put(\"storeIds\", storeIds)");
			
			param.put("customerId", user.getUser().getId());
			log.info("customerId\", user.getUser().getId()");
			
			List<VisitedStore> stores = storeService.getVisitedStore(param);

			log.info("-----------------------------컨트롤러 history stores='{}'", stores);
			return stores;
			
		} else {
			Map<String,Object> param = new HashMap<>();
			
			param.put("storeIds", storeIds);
			
			List<VisitedStore> stores = storeService.getVisitedStore(param);
			
			return stores;
		}
	}
	
	@GetMapping("/detail")
    public String detail(@RequestParam("id") int storeId, Model model, @AuthenticationPrincipal SecurityUser user) {
		
		int customerId = 0;
		if (user != null) {
	        customerId = user.getUser().getId();
	        Bookmark bookmark  = storeService.getBookmark(storeId, customerId);
	        model.addAttribute("bookmark", bookmark);
	    }
		
		storeService.updateReadCount(storeId);
		reviewService.getAllReviewRatingByStoreId(storeId);

		
		StoreDetailDto dto = null;
		if (user == null) {
			dto = storeService.getStoreDetail(storeId, 0);			
		} else {
			dto = storeService.getStoreDetail(storeId, user.getUser().getId());
		}
        
        ReviewDetailDto reviewDetailDto = reviewService.getRatingAvgByStoreId(storeId);
        List<ReviewDto> recentReviews = reviewService.getReviewsPaginatedByStoreId(1, 5, storeId, "all", customerId);

        // 모델에 가게 정보를 추가합니다.
        model.addAttribute("reviewCount", reviewDetailDto.getReviewCount());
        model.addAttribute("bookmarkCount", reviewDetailDto.getBookmarkCount());
        model.addAttribute("store", dto.getStore());
        model.addAttribute("foods", dto.getFoods());
        model.addAttribute("storeOpenTimes", dto.getOpenTimes());
        model.addAttribute("storeAvg", reviewDetailDto);
        model.addAttribute("follows", dto.getFollowers());
        model.addAttribute("closestStores", dto.getClosestStores());
		model.addAttribute("recentReviews", recentReviews);
        // 모델에 리뷰 정보를 추가합니다.
        model.addAttribute("reviewSummary", reviewService.getAllReviewRatingByStoreId(storeId));
        return "storeDetail";
    }
	
	@GetMapping("/open-times")
	@ResponseBody
	public List<StoreOpenTime> days(@RequestParam("id") int storeId) {
		
		return storeService.getStoreOpenTimesById(storeId);
	}

	// store/detail/reviews?id=\${storeId}
	@GetMapping("/detail/reviews")
	@ResponseBody
	public List<ReviewDto> reviews(@RequestParam("id") int storeId, 
			@RequestParam("page") int page, 
			@RequestParam("limit") int limit, 
			@RequestParam("option") String option,
			@AuthenticationPrincipal SecurityUser user) throws InterruptedException {

		try {
			TimeUnit.SECONDS.sleep(1);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		int customerId = 0;
		if (user != null) {
	        customerId = user.getUser().getId();
	    }

		return reviewService.getReviewsPaginatedByStoreId(page, limit, storeId, option, customerId);
	}
	
	@PostMapping("/bookmark")
	@ResponseBody
	public String bookmark(int storeId, String job, @AuthenticationPrincipal SecurityUser securityUser) {
		storeService.changeBookmark(storeId, job, securityUser);

		return "success";
	} 
	
	/*
	 * @GetMapping("/review") public String reviewPage(@RequestParam("storeId") int
	 * storeId, Model model) { Store store = storeService.getStoreById(storeId);
	 * model.addAttribute("storeName", store.getName());
	 * 
	 * // 다른 필요한 정보도 모델에 추가 가능
	 * 
	 * return "review"; }
	 */

	@ResponseBody
	@PostMapping("/delete")
	public ResponseEntity deleteStore(@RequestParam("id") int storeId) {

		if (storeService.deleteStoreById(storeId)) {
			return ResponseEntity.ok().build();
		}

		return ResponseEntity.badRequest().build();
	}

}
