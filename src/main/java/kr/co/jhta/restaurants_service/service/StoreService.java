package kr.co.jhta.restaurants_service.service;

import java.util.HashMap;
import java.util.List;

import java.util.Map;
import java.util.stream.Collectors;

import kr.co.jhta.restaurants_service.controller.command.FoodCommand;
import kr.co.jhta.restaurants_service.controller.command.StoreCommand;
import kr.co.jhta.restaurants_service.controller.command.StoreOpenTimeCommand;
import kr.co.jhta.restaurants_service.mapper.*;
import kr.co.jhta.restaurants_service.projection.Projection;
import kr.co.jhta.restaurants_service.repository.*;
import kr.co.jhta.restaurants_service.security.domain.SecurityUser;
import kr.co.jhta.restaurants_service.vo.post.PostData;
import kr.co.jhta.restaurants_service.vo.review.Review;
import kr.co.jhta.restaurants_service.vo.review.ReviewLikes;
import kr.co.jhta.restaurants_service.vo.user.User;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import kr.co.jhta.restaurants_service.dto.Pagination;
import kr.co.jhta.restaurants_service.dto.SearchedStore;
import kr.co.jhta.restaurants_service.dto.StoreDetailDto;
import kr.co.jhta.restaurants_service.dto.VisitedStore;
import kr.co.jhta.restaurants_service.dto.BookmarkedStore;
import kr.co.jhta.restaurants_service.dto.PagedStores;
import kr.co.jhta.restaurants_service.vo.store.Bookmark;
import kr.co.jhta.restaurants_service.vo.store.Food;
import kr.co.jhta.restaurants_service.vo.store.Store;
import kr.co.jhta.restaurants_service.vo.store.StoreOpenTime;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.annotation.Transactional;

@Service
@Slf4j
@ToString
@Transactional
@RequiredArgsConstructor
public class StoreService {

	private final StoreMapper storeMapper;
	private final FoodMapper foodMapper;
	private final StoreOpenTimeMapper storeOpenTimeMapper;
	private final StoreRepository storeRepository;
	private final FoodRepository foodRepository;
	private final StoreOpenTimeRepository storeOpenTimeRepository;
	private final BookmarkRepository bookmarkRepository;
	private final ReviewRepository reviewRepository;
	private final ReviewLikeMapper reviewLikeMapper;
	private final ReviewKeywordMapper reviewKeywordMapper;
	private final ReviewPictureMapper reviewPictureMapper;
	private final ReviewCommentMapper reviewCommentMapper;
	private final PostDataRepository postDataRepository;

	public Store getStoreById(int storeId) {
		Store store = storeMapper.getStoreById(storeId);
		return store;
	}

	public List<Store> getAllStores() {
		List<Store> stores = storeMapper.getAllStores();
		return stores;
	}

	public PagedStores getStores(Map<String,Object> param){

		int totalRows = storeMapper.getTotalRows(param);
		// 요청한 페이지를 pagination 객체에 저장
		int page = (int)param.get("page");
		Pagination pagination = new Pagination(page, totalRows);
		int begin = pagination.getBegin();
		int end = pagination.getEnd();

		PagedStores result = new PagedStores();
		param.put("begin", begin);
		param.put("end", end);

		List<SearchedStore> stores = storeMapper.getStores(param);
		log.info("서비스 : '{}'",stores);
		result.setPagination(pagination);
		result.setStores(stores);;

		return result;
	}

	public void insertStore(StoreCommand storeCommand, List<FoodCommand> foods, List<StoreOpenTimeCommand> storeOpenTimes, SecurityUser securityUser) {

		Store store = storeCommand.toStore(storeCommand);
		store.setOwner(securityUser.getUser());
		storeRepository.save(store);

		foods.stream()
				.map(FoodCommand::toFood)
				.forEach(food -> {
					food.setStore(store);
					foodRepository.save(food);
				});

		storeOpenTimes.stream()
				.map(StoreOpenTimeCommand::toStoreOpenTime)
				.forEach(storeOpenTime -> {
					storeOpenTime.setStore(store);
					storeOpenTimeRepository.save(storeOpenTime);
				});
	}

	public StoreDetailDto getStoreDetail(int storeId, int userId) {
		StoreDetailDto dto = new StoreDetailDto();

		Store store = storeMapper.getStoreById(storeId);
		dto.setStore(store);

		List<Food> foods = foodMapper.getFoodsByStoreId(storeId);
		dto.setFoods(foods);

		List<StoreOpenTime> openTimes = storeOpenTimeMapper.getStoreOpenTimesByStoreId(storeId);
		dto.setOpenTimes(openTimes);

		List<Store> closestStores = storeMapper.getClosestStores(store.getLatitude(), store.getLongitude(), storeId, 3);
		dto.setClosestStores(closestStores);

		if (userId != 0) {
			List<User> followers = storeMapper.getFollowerReviewedByStoreId(storeId, userId);
			dto.setFollowers(followers);
		}
		return dto;
	}

	public List<Store> getStoresByUserId(int userId) {
		List<Store> stores = storeRepository.findStoresByOwnerId(userId);
		stores.forEach(store -> {
			log.info(store.getName());
		});
		return storeRepository.findStoresByOwnerId(userId);
	}

	public List<BookmarkedStore> getBookmarkedStore(Integer customerId) {
		log.info("가게서비스 getBookmarkedStore : ");
		List<BookmarkedStore> stores = storeMapper.getBookmarkedStoresByUserId(customerId);
		return stores;
	}

	public List<VisitedStore> getVisitedStore(Map<String,Object> param) {
		List<VisitedStore> stores;
		if(param.get("customerId")==null) {
			stores = storeMapper.getVisitedStores(param);
		}else {
			stores = storeMapper.getVisitedStoresById(param);
		}
		return stores;
	}

	public List<StoreOpenTime> getStoreOpenTimesById(int storeId) {

		return storeOpenTimeMapper.getStoreOpenTimesByStoreId(storeId);
	}

	public void updateReadCount(int storeId) {
		Store store = storeMapper.getStoreById(storeId);
		store.setReadCount(store.getReadCount() + 1);

		storeMapper.updateStore(store);

	}

	public Object changeBookmark(int storeId, String job, SecurityUser securityUser) {

		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("storeId", storeId);
		paramMap.put("customerId", securityUser.getUser().getId());

		if ("Y".equals(job)) {
			// 북마크 추가 로직
			storeMapper.insertBookmark(paramMap);
		} else if ("N".equals(job)) {
			// 북마크 삭제 로직
			storeMapper.deleteBookmark(paramMap);
		}

		// 변경된 북마크 상태를 반환
		return getUpdatedBookmarkStatus(storeId, securityUser);
	}

	private Object getUpdatedBookmarkStatus(int storeId, SecurityUser securityUser) {
		return null;
	}

	public List<BookmarkedStore> getBookmarkedStoresByUserId(int id) {
		return null;
	}

	public Bookmark getBookmark(int storeId, int customerId) {
		Bookmark bookmark = storeMapper.getBookmarkByStoreIdAndCustomerId(storeId, customerId);
		return bookmark;
	}


	public List<StoreDetailDto> getPaginatedStoresByUserId(Integer userId, Integer page, Integer limit) {

		Page<Store> stores = storeRepository.findStoreByOwnerId(userId, PageRequest.of(page, limit));

		return stores.stream()
				.map(store -> {
					List<Food> foods = foodRepository.getFoodsByStoreId(store.getId());
					List<StoreOpenTime> storeOpenTimes = storeOpenTimeRepository.findStoreOpenTimeByStoreId(store.getId());
					List<User> wishers = bookmarkRepository
							.findByStoreId(store.getId()).stream()
							.map(bookmark -> bookmark.getCustomer())
							.collect(Collectors.toList());

					return  new StoreDetailDto(store, foods, storeOpenTimes, wishers);
				}).collect(Collectors.toList());
	}

    public boolean deleteStoreById(int storeId) {

		try {
			Store store = storeRepository.findById(storeId).get();

			List<Review> reviews = reviewRepository.findByStoreId(storeId);
			reviews.forEach(review -> {
				reviewLikeMapper.deleteLikeByReviewId(review.getId());
				reviewKeywordMapper.deleteReviewKeywords(review.getId());
				reviewPictureMapper.deleteReviewPictures(review.getId());
				reviewCommentMapper.deleteReviewCommentByReviewId(review.getId());
				reviewRepository.deleteById(review.getId());
			});

			postDataRepository.deleteByStoreId(storeId);
			bookmarkRepository.deleteByStoreId(storeId);
			storeOpenTimeRepository.deleteByStoreId(storeId);
			foodRepository.deleteByStoreId(storeId);

			storeRepository.delete(store);

			return true;
		} catch (Exception e) {
			return false;
		}

    }
}
