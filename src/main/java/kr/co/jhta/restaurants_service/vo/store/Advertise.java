package kr.co.jhta.restaurants_service.vo.store;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.Id;

@Getter
@Setter
@NoArgsConstructor
@Alias("Advertise")
public class Advertise {

	@Id
	private int id;
	private Store store;
	private String subscribed;
	private String succeeded;
	private Date challengeStartDate;
	private Date challengeEndDate;
	private Date succeededStartDate;
	private Date succeededEndDate;
	private String disabled;
}
