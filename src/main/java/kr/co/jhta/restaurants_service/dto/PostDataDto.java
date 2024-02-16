package kr.co.jhta.restaurants_service.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import kr.co.jhta.restaurants_service.vo.post.PostData;
import kr.co.jhta.restaurants_service.vo.store.Bookmark;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@Alias("PostDataDto")@ToString
public class PostDataDto {
	private PostData postData;
	private Integer postId;
	private Integer cutomerId;
	private Date createDate;
	private String content;
	private String pictureFile;
	private Bookmark bookmark;
	private Double averageRating;
	private String storeName; 
	private Integer storeId;
	private String storeAddress;
}
