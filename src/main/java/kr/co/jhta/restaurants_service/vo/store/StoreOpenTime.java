package kr.co.jhta.restaurants_service.vo.store;

import com.fasterxml.jackson.annotation.JsonIgnore;
import kr.co.jhta.restaurants_service.vo.store.Store;
import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Setter @Getter
@Alias("StoreOpenTime")
@Entity
@Table(name = "STORE_OPEN_TIMES")
public class StoreOpenTime {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String day;

	@Column(name = "open_time")
	private String openTime;

	@Column(name = "close_time")
	private String closeTime;

	@ManyToOne @JsonIgnore
	@JoinColumn(name = "store_id", nullable = false)
	private Store store;

	public StoreOpenTime() {
	}

	public StoreOpenTime(String day, String openTime, String closeTime) {
		this.day = day;
		this.openTime = openTime;
		this.closeTime = closeTime;
	}
}
