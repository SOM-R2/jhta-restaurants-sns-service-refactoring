package kr.co.jhta.restaurants_service.mapper;

import java.util.List;

import kr.co.jhta.restaurants_service.vo.user.User;
import org.apache.ibatis.annotations.Mapper;

import kr.co.jhta.restaurants_service.vo.store.Bookmark;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface BookmarkMapper {
	
	void insertBookmark(int customerId, int storeId);

	void deleteBookmark(int customerId, int storeId);
	
	List<Bookmark> getBookmarksByCustomerId(int customerId);

	List<User> getCustomersByStoreId(@Param("storeId") int storeId);
  
	Bookmark getBookmarkByStoreIdAndCustomerId(int storeId, int customerId);

}
