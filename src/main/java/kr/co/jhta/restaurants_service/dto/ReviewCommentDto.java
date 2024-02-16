package kr.co.jhta.restaurants_service.dto;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import kr.co.jhta.restaurants_service.vo.review.ReviewComment;
import kr.co.jhta.restaurants_service.vo.review.ReviewKeyword;
import kr.co.jhta.restaurants_service.vo.review.ReviewPicture;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@Alias("ReviewCommentDto")
public class ReviewCommentDto {
	private int id;
	private String content;
	private Date createDate;
	private Date updateDate;
	private Double reviewAvg;
	private String username;
	private String nickname;
	private String profilePictureName;
	private int userId;
	private int reviewId;
	private long reviewCommentCount;

}
