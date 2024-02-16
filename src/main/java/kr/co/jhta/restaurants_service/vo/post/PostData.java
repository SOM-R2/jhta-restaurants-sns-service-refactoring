package kr.co.jhta.restaurants_service.vo.post;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.co.jhta.restaurants_service.vo.store.Bookmark;
import kr.co.jhta.restaurants_service.vo.store.Store;
import kr.co.jhta.restaurants_service.vo.user.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.apache.ibatis.type.Alias;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@Alias("PostData")
@Entity @Table(name = "POST_DATA")
public class PostData {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JsonIgnore
	@JoinColumn(name = "post_id")
	private Post post;

	@OneToOne
	@JoinColumn(name = "store_id")
	private Store store;
	
	@OneToOne
	@JoinColumn(name = "customer_id")
	private User user;

	@CreationTimestamp
	private Date createDate;

	private String content;
	
	@Column(name = "picture_file")
	private String pictureFile;

	public PostData(Post post, Store store, String content, String pictureFile) {
		this.post = post;
		this.store = store;
		this.content = content;
		this.pictureFile = pictureFile;//
	}
}