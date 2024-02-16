package kr.co.jhta.restaurants_service.vo.review;

import java.util.Date;

import kr.co.jhta.restaurants_service.vo.store.Store;
import kr.co.jhta.restaurants_service.vo.user.User;
import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;

@Getter @Setter
@Alias("Review")
@Entity @Table(name = "REVIEWS")
public class Review {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private int rating;
	private String content;

	@CreatedDate
	@Column(name = "create_date")
	private Date createDate;

	@Column(name = "update_date")
	private Date updateDate;

	@Column(name = "liked_count")
	private int likedCount;

	@ManyToOne
	private User customer;

	@OneToOne
	private Store store;

	@Column(name = "report_count")
	private int reportCount;

	@Enumerated(EnumType.STRING)
	private DISABLED disabled;

	@Enumerated(EnumType.STRING)
	private BLOCKED blocked;

	public Review() {
		this.createDate = new Date(); // default to current time
		this.updateDate = new Date(); // default to current time
		this.disabled = DISABLED.NO; // default to `NO`
	}
	
	public String getHtmlContent() {
		if (content == null) {
			return null;
		}
		return content.replace(System.lineSeparator(), "<br />");
	}

	public enum DISABLED {
		NO, YES
	}

	public enum BLOCKED {
		NO, YES
	}
	
}
