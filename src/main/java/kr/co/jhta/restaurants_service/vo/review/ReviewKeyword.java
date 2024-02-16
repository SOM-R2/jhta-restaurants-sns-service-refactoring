package kr.co.jhta.restaurants_service.vo.review;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.Id;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Getter @Setter
@NoArgsConstructor
@Alias("ReviewKeyword")
public class ReviewKeyword {

	@Id
	private int id;
	private String keyword;
	@JsonIgnore
	private Review review;
	
}
