package kr.co.jhta.restaurants_service.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.jhta.restaurants_service.dto.PostDataDto;
import kr.co.jhta.restaurants_service.vo.post.PostData;
import kr.co.jhta.restaurants_service.vo.store.Bookmark;

@Mapper
public interface PostDataMapper {
	void insertPostData(PostData postData);
	
	List<PostDataDto> getPostDataByPostId(int postId);
	
	Bookmark getBookmarkByStoreIdAndCustomerId(@Param("storeId") int storeId,
			   									@Param("customerId") int customerId);
	void deletePostDataByPostId(int postId);
}
