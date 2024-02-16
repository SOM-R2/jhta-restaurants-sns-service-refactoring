package kr.co.jhta.restaurants_service.mapper;

import java.util.List;  
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jhta.restaurants_service.controller.command.SearchParamCommand;
import kr.co.jhta.restaurants_service.dto.PostContentsDto;
import kr.co.jhta.restaurants_service.security.domain.SecurityUser;
import kr.co.jhta.restaurants_service.vo.post.Post;
import kr.co.jhta.restaurants_service.vo.post.PostData;

import org.apache.ibatis.annotations.Param;

@Mapper
public interface PostMapper {
	void insertPost(Post post);
	
	void updatePost(int postId);
	
	int deletePost(int postId);
	
	Post getPostById(int postId);
	
	int getTotalRows(Map<String,Object> param);
	List<PostContentsDto> getAllPosts(@Param("start") int start, @Param("limit") int limit);
    List<PostContentsDto> getPostsPaginatedOfFollowersByFollowed(@Param("start") int start, @Param("limit") int limit, @Param("followedId") int followedId);
    
    List<PostContentsDto> getRecentPostsThree();
    List<PostContentsDto> getRecentPostsThreeOfFollowersByFollowed(int followedId);
    List<PostContentsDto> getPostsByStoreSearch(Map<String, Object> paramMap);

}
