package kr.co.jhta.restaurants_service.vo.post;

import kr.co.jhta.restaurants_service.vo.user.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter @Setter
@NoArgsConstructor
@Alias("PostLikes")
public class PostLikes {

	private User customer;
	private Post post;
}
