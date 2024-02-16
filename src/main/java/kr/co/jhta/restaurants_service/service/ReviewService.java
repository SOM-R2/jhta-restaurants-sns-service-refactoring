package kr.co.jhta.restaurants_service.service;

import java.util.*;
import java.util.stream.Collectors;

// import java.util.stream.Collectors;

import kr.co.jhta.restaurants_service.projection.Projection;
import kr.co.jhta.restaurants_service.repository.ReviewPictureRepository;
import kr.co.jhta.restaurants_service.repository.ReviewRepository;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.jhta.restaurants_service.controller.command.ReviewCommand;
import kr.co.jhta.restaurants_service.controller.command.ReviewCommentCommand;
import kr.co.jhta.restaurants_service.dto.ReviewCommentDto;
import kr.co.jhta.restaurants_service.dto.ReviewContentsDto;
import kr.co.jhta.restaurants_service.controller.command.ReviewReportCommand;
import kr.co.jhta.restaurants_service.dto.ReviewDetailDto;
import kr.co.jhta.restaurants_service.dto.ReviewDto;
//import kr.co.jhta.restaurants_service.dto.ReviewListDto;
import kr.co.jhta.restaurants_service.dto.ReviewSummaryDto;
import kr.co.jhta.restaurants_service.mapper.ReviewCommentMapper;
import kr.co.jhta.restaurants_service.mapper.ReviewKeywordMapper;
import kr.co.jhta.restaurants_service.mapper.ReviewLikeMapper;
import kr.co.jhta.restaurants_service.mapper.ReviewMapper;
import kr.co.jhta.restaurants_service.mapper.ReviewPictureMapper;
import kr.co.jhta.restaurants_service.mapper.ReviewReportMapper;
import kr.co.jhta.restaurants_service.mapper.StoreMapper;
import kr.co.jhta.restaurants_service.repository.UserRepository;
import kr.co.jhta.restaurants_service.security.domain.SecurityUser;
import kr.co.jhta.restaurants_service.vo.review.Review;
import kr.co.jhta.restaurants_service.vo.review.ReviewComment;
import kr.co.jhta.restaurants_service.vo.review.ReviewKeyword;
import kr.co.jhta.restaurants_service.vo.review.ReviewPicture;
import kr.co.jhta.restaurants_service.vo.review.ReviewReport;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewService {

	@Autowired private ReviewMapper reviewMapper;


	@Autowired private ReviewPictureMapper reviewPictureMapper;

	@Autowired private ReviewCommentMapper reviewCommentMapper;

	@Autowired private ReviewKeywordMapper reviewKeywordMapper;

	@Autowired private StoreMapper storeMapper;

	@Autowired private UserRepository userRepository;

	@Autowired private ReviewRepository reviewRepository;

	@Autowired private ReviewPictureRepository reviewPictureRepository;

	@Autowired private ReviewReportMapper reviewReportMapper;
	
	@Autowired private ReviewLikeMapper reviewLikeMapper;

	private final Logger logger = Logger.getLogger(PostService.class);

	// 새 리뷰 등록하기
	public List<String> createReview(ReviewCommand form, SecurityUser securityUser) {

		Review review = new Review();

		review.setRating(form.getRating());
		review.setContent(form.getContent());
		review.setStore(storeMapper.getStoreById(form.getStoreId()));
		review.setCustomer(userRepository.getReferenceById(securityUser.getUser().getId()));
		review.setCreateDate(new Date());

		reviewMapper.insertReview(review);

		if (form.getReviewKeyword() != null) {
			for (String keyword : form.getReviewKeyword()) {
				ReviewKeyword reviewKeyword = new ReviewKeyword();
				reviewKeyword.setKeyword(keyword);
				reviewKeyword.setReview(review);
				reviewKeywordMapper.insertReveiwKeyword(reviewKeyword);
			}
		}

		List<String> uuidPrefixedFileNames = new ArrayList<>();
		if (form.getChooseFile() != null) {
			for (MultipartFile fileName : form.getChooseFile()) {
				ReviewPicture reviewPicture = new ReviewPicture();
				reviewPicture.setPictureName(UUID.randomUUID().toString() + "-" + fileName.getOriginalFilename());
				reviewPicture.setReview(review);
				reviewPicture.setUser(securityUser.getUser());
				reviewPicture.setCreateDate(new Date());

				uuidPrefixedFileNames.add(reviewPicture.getPictureName());

				reviewPictureMapper.insertReveiwPicture(reviewPicture);
			}
		}

		return uuidPrefixedFileNames;
	}

	// 새 리뷰 답글 등록하기
	public void createReviewComment(ReviewCommentCommand form, SecurityUser securityUser) {
		ReviewComment reviewComment = new ReviewComment();

		reviewComment.setContent(form.getContent());

		Review review = reviewMapper.getReviewById(form.getReviewId());
		reviewComment.setReview(review);
		reviewComment.setOwner(securityUser.getUser());

		reviewCommentMapper.insertReviewComment(reviewComment);
	}

	public List<Review> getAllReviews(int customerId) {
		List<Review> reviews = reviewMapper.getAllReviewsByCustomerId(customerId);
		return reviews;
	}

	public ReviewDetailDto selectReview(int ReviewId){
		ReviewDetailDto dto = new ReviewDetailDto();

		Review review = reviewMapper.getReviewById(ReviewId);
		review.setStore(storeMapper.getStoreById(review.getStore().getId()));
		review.setCustomer(userRepository.getReferenceById(review.getCustomer().getId()));

		List<ReviewKeyword> reviewKeyword = reviewKeywordMapper.getReviewKeywordsByReviewId(ReviewId);

		List<Review> allReviewByCustomerId = reviewMapper.getAllReviewsByCustomerId(review.getCustomer().getId());
		Double reviewRatingByCustomerId = allReviewByCustomerId.stream().collect(Collectors.averagingDouble(rating -> rating.getRating()));

		List<ReviewPicture> reviewPictures = reviewPictureMapper.getReviewPicturesByReviewId(ReviewId);

		List<ReviewCommentDto> reviewComments = reviewCommentMapper.getReviewCommentAndUserByReviewId(ReviewId);

		dto.setReview(review);
		dto.setReviewKeywords(reviewKeyword);
		dto.setReviewRatingByCustomerId(reviewRatingByCustomerId);
		dto.setReviewPicturesByReviewId(reviewPictures);
		dto.setReviewCommentsByReviewId(reviewComments);

		return dto;
	}


	public void createReviewReport(ReviewReportCommand form, SecurityUser securityUser) {
		ReviewReport reviewReport = new ReviewReport();

		// 문자열 값을 enum 값으로 변환
		ReviewReport.CATEGORY categoryEnum = ReviewReport.CATEGORY.valueOf(form.getCategory());
		reviewReport.setCategory(categoryEnum);
		reviewReport.setContent(form.getContent());
		reviewReport.setCreateDate(new Date());
		reviewReport.setReporter(securityUser.getUser());
		reviewReport.setReview(reviewMapper.getReviewById(form.getReviewId()));

		reviewReportMapper.insertReveiwReport(reviewReport);

	}

	public Page<Projection.Review> getNonBlockedReviewsByCustomerIdOrderByCreateDate(int customerId, Review.BLOCKED no, Integer page, Integer limit) {

		return reviewRepository.findReviewsByCustomerIdAndBlockedOrderByCreateDateDesc(customerId, no, PageRequest.of(page, limit));
	}


	public long getReviewsCountByCustomerId(Integer customerId) {

		return reviewRepository.countByCustomerId(customerId);
	}


	// 가게별 리뷰 평균 가져오기
	public ReviewDetailDto getRatingAvgByStoreId(int storeId) {
		ReviewDetailDto reviewDetailDto = new ReviewDetailDto();

		int reviewCount = storeMapper.getReviewCountByStoreId(storeId);
		int bookmarkCount = storeMapper.getBookmarkCountByStoreId(storeId);

		List<Review> getAllReviewsByStoreId = reviewMapper.getAllReviewsByStoreId(storeId);
		double storeReviewAvg = getAllReviewsByStoreId.stream().collect(Collectors.averagingDouble(rating -> rating.getRating()));

		reviewDetailDto.setStoreReviewAvg(storeReviewAvg);
		reviewDetailDto.setReviewCount(reviewCount);
		reviewDetailDto.setBookmarkCount(bookmarkCount);

		return reviewDetailDto;
	}


	// 리뷰 rating가져오기
	public ReviewSummaryDto getAllReviewRatingByStoreId(int storeId) {
		ReviewSummaryDto reviewRating = reviewMapper.getAllReviewRatingByStoreId(storeId);
		return reviewRating;
	}

    public List<ReviewDto> getReviewsPaginatedByStoreId(int page, int limit, int storeId, String option, int customerId) {

		int begin = (page - 1) * limit;
		int end = begin + limit;

		if (option.equals("all")) {
			return reviewMapper.getReviewsPaginatedByStoreId(begin, end, storeId, customerId);
		} else if (option.equals("good")) {
			return reviewMapper.getReviewsPaginatedByStoreIdAndRating(begin, end, storeId, 5, customerId);
		} else if (option.equals("soso")) {
			return reviewMapper.getReviewsPaginatedByStoreIdAndRating(begin, end, storeId, 3, customerId);
		} else { // bad
			return reviewMapper.getReviewsPaginatedByStoreIdAndRating(begin, end, storeId, 1, customerId);
		}
    }
    
    public List<ReviewContentsDto> getThreeRecentReview(){
		List<ReviewContentsDto> reviews = reviewMapper.getThreeRecentReivews();
		for(ReviewContentsDto review : reviews) {
			List<ReviewKeyword> reviewKeyword = reviewKeywordMapper.getReviewKeywordsByReviewId(review.getId());
			review.setKeywords(reviewKeyword);
		}
		return reviews;
    }
    
    public List<ReviewContentsDto> getThreeFollowerReview(SecurityUser securityUser){
		List<ReviewContentsDto> reviews = reviewMapper.getThreeFollowerReivews(securityUser.getUser().getId());
		for(ReviewContentsDto review : reviews) {
			List<ReviewKeyword> reviewKeyword = reviewKeywordMapper.getReviewKeywordsByReviewId(review.getId());
			review.setKeywords(reviewKeyword);
		}
		return reviews;
    }
    
    public List<ReviewContentsDto> getAllReviewsPaginated(int page, int limit){
		int start = (page - 1) * limit;

		return reviewMapper.getAllReivewsPaginated(start, limit);
    }
    
    public List<ReviewContentsDto> getFollowerReviewsPaginated(int page, int limit, SecurityUser securityUser){
		int start = (page - 1) * limit;

		return reviewMapper.getFollowerReivewsPaginated(start, limit, securityUser.getUser().getId());
    }
    
    public List<ReviewKeyword> getReviewKeywords(int reviewId){
		return reviewKeywordMapper.getReviewKeywordsByReviewId(reviewId);
    }

    public Page<ReviewPicture> getReviewPicturesByCustomerIdOrderByCreateDateDesc(int customerId, Integer page, Integer limit) {

		return reviewPictureRepository.findByUserIdOrderByCreateDateDesc(customerId, PageRequest.of(page, limit));
    }
    
    public void deletedReview(int reviewId) {

    		reviewCommentMapper.deleteReviewCommentByReviewId(reviewId);
    		reviewKeywordMapper.deleteReviewKeywords(reviewId);
    		reviewPictureMapper.deleteReviewPictures(reviewId);
    		reviewLikeMapper.deleteLikeByReviewId(reviewId);
    		reviewMapper.deleteReview(reviewId);
    	
    }
    
    public void deletedReviewComment(int reviewCommentId) {
    	
    	reviewCommentMapper.deleteReviewComment(reviewCommentId);
    	

    }

	public List<String> getReviewKeywordsByUserId(Integer userId, Integer limit) {

		List<Review> reviews = reviewMapper.getAllReviewsByCustomerId(userId);
		List<ReviewKeyword> reviewKeywords = reviews.stream()
				.flatMap(review -> reviewKeywordMapper.getReviewKeywordsByReviewId(review.getId()).stream())
				.collect(Collectors.toList());

		Map<String, Long> keywordFrequency = reviewKeywords.stream()
				.collect(Collectors.groupingBy(ReviewKeyword::getKeyword, Collectors.counting()));

		List<String> topKeywords = keywordFrequency.entrySet().stream()
				.sorted((entry1, entry2) -> Long.compare(entry2.getValue(), entry1.getValue()))
				.map(Map.Entry::getKey)
				.limit(limit) // Limit to the top three keywords
				.collect(Collectors.toList());

		return topKeywords;
	}
}
