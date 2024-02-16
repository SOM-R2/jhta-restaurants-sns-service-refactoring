package kr.co.jhta.restaurants_service.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.jhta.restaurants_service.dto.HomeAnonymousFeed;
import kr.co.jhta.restaurants_service.dto.HomeFeed;
import kr.co.jhta.restaurants_service.dto.HomePostDto;
import kr.co.jhta.restaurants_service.vo.post.Post;

@Mapper
public interface HomeMapper {

	List<HomeFeed> getMyFeedsByFollowerId(int begin, int limit, int userId);

	List<HomeAnonymousFeed> getAnonymousFeeds(int begin, int limit);
	
	List<HomePostDto> getPostsOrderByLike();

}
