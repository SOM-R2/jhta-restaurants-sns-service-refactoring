package kr.co.jhta.restaurants_service.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.jhta.restaurants_service.mapper.BookmarkMapper;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@ToString
@RequiredArgsConstructor
public class BookmarkService {
	private final BookmarkMapper bookmarkMapper;
	
	public void insertBookmark(int customerId, int storeId) {
		bookmarkMapper.insertBookmark(customerId, storeId);
	}

	public void deleteBookmark(int customerId, int storeId) {
		bookmarkMapper.deleteBookmark(customerId, storeId);
	}
	
	
}
