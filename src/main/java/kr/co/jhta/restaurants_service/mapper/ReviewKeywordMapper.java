package kr.co.jhta.restaurants_service.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Mapper;

import kr.co.jhta.restaurants_service.vo.review.ReviewKeyword;


@Mapper
public interface ReviewKeywordMapper {

	void insertReveiwKeyword(ReviewKeyword reviewKeyword);
	void deleteReviewKeywords(int reviewId);
	List<ReviewKeyword> getReviewKeywordsByReviewId(int reviewId);
}
