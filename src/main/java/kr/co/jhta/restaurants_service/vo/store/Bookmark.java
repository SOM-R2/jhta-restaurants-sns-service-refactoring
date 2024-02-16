package kr.co.jhta.restaurants_service.vo.store;

import java.util.Date;

import kr.co.jhta.restaurants_service.vo.user.User;
import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;

@Getter
@Setter
@Alias("Bookmark")
@Entity @Table(name= "BOOKMARKS")
public class Bookmark {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne @JoinColumn(name = "store_id")
	private Store store;

	@ManyToOne @JoinColumn(name = "customer_id")
	private User customer;

	@Column(name = "create_date")
	@CreationTimestamp
	private Date createDate;

	public Bookmark() {
		this.createDate = new Date();
	}
}
