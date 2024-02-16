package kr.co.jhta.restaurants_service.dto;

import java.util.Date;
import java.util.List;

import kr.co.jhta.restaurants_service.vo.review.ReviewComment;
import kr.co.jhta.restaurants_service.vo.review.ReviewKeyword;
import kr.co.jhta.restaurants_service.vo.review.ReviewPicture;
import kr.co.jhta.restaurants_service.vo.user.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@ToString
@NoArgsConstructor
@Alias("ReviewDto")
public class ReviewDto {
	private int id;
	private int rating;
	private String content;
	private Date createDate;
	private Date updateDate;
	private int likedCount;
	private int reportCount;
	private boolean disabled;
	private boolean blocked;
	private Double reviewAvg;
	private int customerId;
	private String customerName;
	private String nickname;
	private int ownerId;
	private String isLiked;
	private int commentCount;

	private List<ReviewPicture> reviewPictures;
	private List<ReviewKeyword> reviewKeywords;
	private List<ReviewComment> reviewComments;
	
	public String getHtmlContent() {
		if (content == null) {
			return null;
		}
		return content.replace(System.lineSeparator(), "<br />");
	}

	
//	public boolean isTaste() {
//		return reviewKeywords
//				.stream()
//				.map(item -> item.getKeyword())
//				.anyMatch(item -> item.equals("#음식이 맛있어요"));
//	}
//
//	public boolean isParking() {
//		return reviewKeywords.stream().map(item -> item.getKeyword()).anyMatch(item -> item.equals("#주차가 편해요"));
//	}
//
//	public boolean isClean() {
//		return reviewKeywords.stream().map(item -> item.getKeyword()).anyMatch(item -> item.equals("#매장이 청결해요"));
//	}
//
//	public boolean isWide() {
//		return reviewKeywords.stream().map(item -> item.getKeyword()).anyMatch(item -> item.equals("#매장이 넓어요"));
//	}
//
//	public boolean isMood() {
//		return reviewKeywords.stream().map(item -> item.getKeyword()).anyMatch(item -> item.equals("#분위기가 좋아요"));
//	}
//
//	public boolean isKind() {
//		return reviewKeywords.stream().map(item -> item.getKeyword()).anyMatch(item -> item.equals("#친절해요"));
//	}
//
//	public void setReviewPictures(List<ReviewPicture> reviewPictures) {
//	     this.reviewPictures = reviewPictures;
//	}
//
//	public void setReviewKeywords(List<ReviewKeyword> reviewKeywords) {
//		this.reviewKeywords = reviewKeywords;
//	}
//
//	public ReviewDto(int id, int rating, String content, Date createDate, int likedCount, int reportCount, int customerId,  String customerUsername,
//			 boolean disabled, boolean blocked, double reviewAvg, String nickname, int ownerId ) {
//		this.id = id;
//		this.rating = rating;
//		this.content = content;
//		this.createDate = createDate;
//		this.likedCount = likedCount;
//		this.reportCount = reportCount;
//		this.customerId = customerId;
//		this.customerUsername = customerUsername;
//		this.disabled = disabled;
//		this.blocked = blocked;
//		this.reviewAvg = reviewAvg;
//		this.nickname = nickname;
//		this.ownerId = ownerId;
//	}
	
	
}
