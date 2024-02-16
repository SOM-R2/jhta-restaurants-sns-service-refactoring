package kr.co.jhta.restaurants_service.vo.review;

import java.util.Date;

import kr.co.jhta.restaurants_service.vo.user.User;
import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;

@Getter
@Setter
@Alias("ReviewComment")
public class ReviewComment {

	@Id
	private int id;
	private String content;
	private Date createDate;
	private Date updateDate;
	private DISABLED disabled;
	private Review review;
	private User owner;

	public ReviewComment() {

		this.createDate = new Date(); // default to current time
		this.updateDate = new Date(); // default to current time
		this.disabled = ReviewComment.DISABLED.NO; // default to `NO`
	}

	public enum DISABLED {
		NO, YES
	}
}
