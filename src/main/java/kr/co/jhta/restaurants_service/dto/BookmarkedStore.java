package kr.co.jhta.restaurants_service.dto;

import org.apache.ibatis.type.Alias;

import kr.co.jhta.restaurants_service.vo.user.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@Alias("BookmarkedStore")
public class BookmarkedStore {
	private int id;
	private String name;
	private double reviewAvg;
	private String category;
	private User customer;
	private String pictureName;

}
