package kr.co.jhta.restaurants_service.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jhta.restaurants_service.dto.PostLikeDto;
import kr.co.jhta.restaurants_service.vo.post.PostLikes;

@Mapper
public interface PostLikeMapper {

	void insertLike(int customerId, int postId);
	void addLike(int postId);

	void deleteLike(int customerId, int postId);
	void cancelLike(int postId);

	PostLikeDto selectPostLikeByPostIdAndCustomerId(int postId, int customerId);
	
	void deletePostLikeByPostId(int postId);
}
