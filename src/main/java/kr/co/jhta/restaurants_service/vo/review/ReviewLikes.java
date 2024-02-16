package kr.co.jhta.restaurants_service.vo.review;

import kr.co.jhta.restaurants_service.vo.user.User;
import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@Alias("ReviewLikes")
public class ReviewLikes {

	private User customer;
	private Review review;
}
