package kr.co.jhta.restaurants_service.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jhta.restaurants_service.vo.review.ReviewPicture;
import org.apache.ibatis.annotations.Param;


@Mapper
public interface ReviewPictureMapper {

	void insertReveiwPicture(ReviewPicture reviewPicture);
	void deleteReviewPictures(int reviewId);
	List<ReviewPicture> getReviewPicturesByReviewId(int reviewId);
}
