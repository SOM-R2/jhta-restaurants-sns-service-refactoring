package kr.co.jhta.restaurants_service.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.jhta.restaurants_service.dto.BookmarkedStore;
import kr.co.jhta.restaurants_service.dto.SearchedStore;
import kr.co.jhta.restaurants_service.dto.VisitedStore;
import kr.co.jhta.restaurants_service.security.domain.SecurityUser;
import kr.co.jhta.restaurants_service.vo.store.Bookmark;
import kr.co.jhta.restaurants_service.vo.store.Store;
import kr.co.jhta.restaurants_service.vo.user.User;

@Mapper
public interface StoreMapper {

    void insertStore(Store store);

    List<SearchedStore> getStores(Map<String, Object> param);

    Store getStoreById(int storeId);

    List<VisitedStore> getVisitedStoresById(Map<String, Object> param);

    List<BookmarkedStore> getBookmarkedStoresByUserId(int customerId);

    void updateStore(Store store);

    List<Store> getAllStores();

    int getTotalRows(Map<String, Object> param);

    List<Store> getStoreByName(String keyword);

    List<VisitedStore> getVisitedStores(Map<String, Object> param);

    Object changeBookmark(int storeId, String job, SecurityUser securityUser);

    void insertBookmark(Map<String, Object> paramMap);

    void deleteBookmark(Map<String, Object> paramMap);

    int getReviewCountByStoreId(int storeId);

    int getBookmarkCountByStoreId(int storeId);

    Bookmark getBookmarkByStoreIdAndCustomerId(@Param("storeId") int storeId,
											   @Param("customerId") int customerId);

    List<Store> getClosestStores(@Param("latitude") double latitude,
								 @Param("longitude") double longitude,
								 @Param("storeId") int storeId,
								 @Param("limit") int limit);
    
    List<User> getFollowerReviewedByStoreId(@Param("storeId") int storeId,
			   						        @Param("customerId") int customerId);
}
