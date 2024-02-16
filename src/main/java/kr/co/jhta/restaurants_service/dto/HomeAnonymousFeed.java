package kr.co.jhta.restaurants_service.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;

import kr.co.jhta.restaurants_service.vo.review.ReviewPicture;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Alias("HomeAnonymousFeed")
public class HomeAnonymousFeed {
	private int id;
	private String username;
	private String storeName;
	private int userId;
	private Integer storeId;
	private String category;
	private String address;
	private String content;
	private List<ReviewPicture> reviewPictures;
	private String createDate;
	private Integer reviewId;
	private Integer rating;
	private Integer likedCount;
	private String isBookmarked;
	private String isLiked;
}
