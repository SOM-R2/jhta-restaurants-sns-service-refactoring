package kr.co.jhta.restaurants_service.vo.post;

import java.util.Date;

import kr.co.jhta.restaurants_service.vo.user.User;
import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;

@Getter
@Setter
@Alias("PostComment")
public class PostComment {

	@Id
	private int id;
	private String content;
	private Date createDate;
	private Date updateDate;
	private Post post;
	private DISABLED disabled;
	private User customer;

	public PostComment() {
		this.createDate = new Date(); // default to current time
		this.updateDate = new Date(); // default to current time
		this.disabled = DISABLED.NO; // default to `NO`
	}

	public enum DISABLED  {
		NO, YES
	}

}
