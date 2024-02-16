package kr.co.jhta.restaurants_service.dto;


import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import kr.co.jhta.restaurants_service.vo.post.PostData;
import kr.co.jhta.restaurants_service.vo.review.ReviewPicture;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Alias("HomeFeed")
public class HomeFeed {
	private int id;
	private String username;
	private String userId;
	private String storeName;
	private Integer storeId;
	private String category;
	private String address;
	private String content;
	private List<ReviewPicture> reviewPictures;
	private Date createDate;
	private Integer reviewId;
	private Integer rating;
	private String isBookmarked;
	private String isLiked;
	private Integer likedCount;
	private String isFollowed;
	
}
