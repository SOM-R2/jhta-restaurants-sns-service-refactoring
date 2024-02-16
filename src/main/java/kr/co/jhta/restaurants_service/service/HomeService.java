package kr.co.jhta.restaurants_service.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.co.jhta.restaurants_service.dto.HomeFeed;
import kr.co.jhta.restaurants_service.dto.HomeAnonymousFeed;
import kr.co.jhta.restaurants_service.mapper.HomeMapper;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@ToString
@RequiredArgsConstructor

public class HomeService {
	private final HomeMapper homeMapper;
	
	public List<HomeFeed> getMyFeeds(int page, int limit, int userId) {
		
		int begin = (page - 1) * limit;
		
		List<HomeFeed> result = homeMapper.getMyFeedsByFollowerId(begin, limit, userId);
		
		return result;
	}
	
	public List<HomeAnonymousFeed> getAnonymousFeeds(int page, int limit) {
		
		int begin = (page - 1) * limit;
		
		return homeMapper.getAnonymousFeeds(begin,limit);
	}


}
