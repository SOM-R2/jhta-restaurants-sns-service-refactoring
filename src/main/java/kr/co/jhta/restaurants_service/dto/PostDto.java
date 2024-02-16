package kr.co.jhta.restaurants_service.dto;

import java.util.List;

import kr.co.jhta.restaurants_service.vo.post.Post;
import kr.co.jhta.restaurants_service.vo.post.PostComment;
import kr.co.jhta.restaurants_service.vo.post.PostData;
import kr.co.jhta.restaurants_service.vo.store.Bookmark;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PostDto {
	
	private Post post;
	private List<PostDataDto> postDatas;
	private List<PostComment> postComments;
	private PostLikeDto postLikeDto;
	
	public PostDto(Post post, List<PostDataDto> postDatas, List<PostComment> postComments, PostLikeDto postLikeDto) {
		this.post = post;
		this.postDatas = postDatas;
		this.postComments = postComments;
		this.postLikeDto = postLikeDto;
	}
}
