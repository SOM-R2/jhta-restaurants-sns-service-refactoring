package kr.co.jhta.restaurants_service.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Mapper;

import kr.co.jhta.restaurants_service.controller.command.ReviewCommand;
import kr.co.jhta.restaurants_service.dto.ReviewContentsDto;
import kr.co.jhta.restaurants_service.dto.ReviewDto;
//import kr.co.jhta.restaurants_service.dto.ReviewListDto;
import kr.co.jhta.restaurants_service.dto.ReviewSummaryDto;
import kr.co.jhta.restaurants_service.vo.review.Review;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ReviewMapper {

	void insertReview(Review review);
	void deleteReview(int reviewId);
	Review getReviewById(int id);
	Review getReviewByCustomerId(int customerId);
	Review getReviewByStoreId(int storeId);
	List<Review> getAllReviewsByStoreId(int storeId);
	List<Review> getAllReviewsByCustomerId(int customerId);
	ReviewSummaryDto getAllReviewRatingByStoreId(int storeId);
	List<ReviewDto> getReviewsByStoreId(int storeId);
	List<ReviewDto> getReviewsPaginatedByStoreId(@Param("begin") int begin, @Param("end") int end, @Param("storeId") int storeId, @Param("customerId") int customerId);
	
	
	List<ReviewContentsDto> getThreeRecentReivews();
	List<ReviewContentsDto> getThreeFollowerReivews(@Param("followedId") int followedId);
	
	List<ReviewContentsDto> getAllReivewsPaginated(@Param("begin") int begin, @Param("limit") int limit);
	List<ReviewContentsDto> getFollowerReivewsPaginated(@Param("begin") int begin, @Param("limit") int limit, @Param("followedId") int followedId);

	List<ReviewDto> getReviewsPaginatedByStoreIdAndRating(@Param("begin") int begin,
														  @Param("end") int end,
														  @Param("storeId") int storeId,
														  @Param("rating") int rating,
														  @Param("customerId") int customerId);
}
