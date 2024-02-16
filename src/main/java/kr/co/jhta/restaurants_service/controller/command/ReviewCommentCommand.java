package kr.co.jhta.restaurants_service.controller.command;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewCommentCommand {

	private String content;
	private Integer reviewId;
	private Integer storeId;

}
