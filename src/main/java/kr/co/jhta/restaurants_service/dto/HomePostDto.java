package kr.co.jhta.restaurants_service.dto;

import java.util.Date;
import java.util.List;

import kr.co.jhta.restaurants_service.vo.post.Post;
import kr.co.jhta.restaurants_service.vo.post.PostComment;
import kr.co.jhta.restaurants_service.vo.post.PostData;
import kr.co.jhta.restaurants_service.vo.store.Bookmark;
import kr.co.jhta.restaurants_service.vo.user.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class HomePostDto {
	private int id;
	private String title;
	private String subTitle;
	private Date createDate;
	private Date updateDate;
	private User customer;
	private int reportCount;
	private String username;
	private String disabled;
	private String blocked;
	private String pictureFile;
	private int likedCount;
	

}
