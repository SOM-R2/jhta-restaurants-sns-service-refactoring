package kr.co.jhta.restaurants_service.dto;

import org.apache.ibatis.type.Alias;

import kr.co.jhta.restaurants_service.vo.user.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@Alias("VisitedStore")
public class VisitedStore {
	private int id;
	private String name;
	private String pictureName;
	private double reviewAvg;
	private String category;
	private String isBookmarked;

}
