package kr.co.jhta.restaurants_service.controller.command;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class PostCommentCommand {

	private String content;
	private Integer postId;
	private Integer userId;
}
