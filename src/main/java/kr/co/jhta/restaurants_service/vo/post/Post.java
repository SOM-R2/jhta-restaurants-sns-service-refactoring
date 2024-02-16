package kr.co.jhta.restaurants_service.vo.post;

import java.util.Date;
import java.util.Set;

import kr.co.jhta.restaurants_service.vo.user.User;
import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;

@Getter
@Setter
@Alias("Post")
@Entity
@Table(name = "POSTS")
public class Post {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String title;

	@Column(name = "sub_title")
	private String subTitle;

	@CreatedDate
	@Column(name = "create_date")
	private Date createDate;

	@LastModifiedDate
	@Column(name = "update_date")
	private Date updateDate;

	@ManyToOne
	@JoinColumn(name = "customer_id", nullable = false)
	private User customer;

	@Column(name = "report_count")
	private int reportCount;

	@Column(name = "liked_count")
	private int likedCount;

	@Enumerated(EnumType.STRING)
	private DISABLED disabled;

	@Enumerated(EnumType.STRING)
	private BLOCKED blocked;

	public Post() {

		this.createDate = new Date(); /// default to current time
		this.updateDate = new Date(); // default to current time
		this.disabled = Post.DISABLED.NO; // default to `NO`
		this.blocked = Post.BLOCKED.NO; // default to `NO`
	}

	public Post(String title, String subTitle, Date createDate, Date updateDate, User customer) {
		this.title = title;
		this.subTitle = subTitle;
		this.createDate = new Date(); // default to current time
		this.updateDate = new Date(); // default to current time
		this.customer = customer;
	}

	public enum DISABLED  {
		NO, YES
	}

	public enum BLOCKED {
		NO, YES
	}
}
