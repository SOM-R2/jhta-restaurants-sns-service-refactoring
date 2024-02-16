package kr.co.jhta.restaurants_service.controller.command;

import java.util.Date;

import kr.co.jhta.restaurants_service.vo.post.Post;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
public class PostCommand {

	private String postTitle;
	private String postSubtitle;
	private Date createDate;
	private Date updateDate;
	
	public PostCommand(String postTitle, String postSubtitle) {
		this.postTitle = postTitle;
		this.postSubtitle = postSubtitle;
		this.createDate = new Date(); /// default to current time
		this.updateDate = new Date(); // default to current time
	}
	
}
