package kr.co.jhta.restaurants_service.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jhta.restaurants_service.dto.ReviewCommentDto;
import kr.co.jhta.restaurants_service.vo.review.ReviewComment;

@Mapper
public interface ReviewCommentMapper {

	void insertReviewComment(ReviewComment reviewComment);
	void deleteReviewComment(int reviewCommentId);
	void deleteReviewCommentByReviewId(int reviewId);
	List<ReviewComment> getReviewCommentByReviewId(int reviewId);
	List<ReviewCommentDto> getReviewCommentAndUserByReviewId(int reviewId);
}
