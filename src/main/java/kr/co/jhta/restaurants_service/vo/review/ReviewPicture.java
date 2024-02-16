package kr.co.jhta.restaurants_service.vo.review;

import kr.co.jhta.restaurants_service.vo.user.User;
import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.util.Date;

@Setter @Getter
@NoArgsConstructor
@Alias("ReviewPicture")
@Entity @Table(name = "REVIEW_PICTURES")
public class ReviewPicture {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "picture_name")
	private String pictureName;

//	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "review_id")
	private Review review;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	@CreationTimestamp
	private Date createDate;
}
