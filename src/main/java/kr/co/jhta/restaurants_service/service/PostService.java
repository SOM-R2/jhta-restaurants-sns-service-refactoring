package kr.co.jhta.restaurants_service.service;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import kr.co.jhta.restaurants_service.controller.command.PostCommentCommand;
import kr.co.jhta.restaurants_service.controller.command.PostDataCommand;
import kr.co.jhta.restaurants_service.controller.command.SearchParamCommand;
import kr.co.jhta.restaurants_service.dto.HomePostDto;
import kr.co.jhta.restaurants_service.dto.PostContentsDto;
import kr.co.jhta.restaurants_service.dto.PostDataDto;
import kr.co.jhta.restaurants_service.dto.PostDto;
import kr.co.jhta.restaurants_service.dto.PostLikeDto;
import kr.co.jhta.restaurants_service.projection.Projection;
import kr.co.jhta.restaurants_service.repository.FollowsRepository;
import kr.co.jhta.restaurants_service.repository.PostDataRepository;
import kr.co.jhta.restaurants_service.repository.PostRepository;
import kr.co.jhta.restaurants_service.security.domain.SecurityUser;

import org.jboss.logging.Logger;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import kr.co.jhta.restaurants_service.mapper.PostMapper;
import kr.co.jhta.restaurants_service.mapper.StoreMapper;
import kr.co.jhta.restaurants_service.mapper.BookmarkMapper;
import kr.co.jhta.restaurants_service.mapper.HomeMapper;
import kr.co.jhta.restaurants_service.mapper.PostCommentMapper;
import kr.co.jhta.restaurants_service.mapper.PostDataMapper;
import kr.co.jhta.restaurants_service.mapper.PostLikeMapper;
import kr.co.jhta.restaurants_service.vo.post.Post;
import kr.co.jhta.restaurants_service.vo.post.PostComment;
import kr.co.jhta.restaurants_service.vo.post.PostData;
import kr.co.jhta.restaurants_service.vo.post.PostLikes;
import kr.co.jhta.restaurants_service.vo.store.Bookmark;
import kr.co.jhta.restaurants_service.vo.store.Store;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PostService {

	private final Logger logger = Logger.getLogger(PostService.class);

	private final PostMapper postmapper;
	private final StoreMapper storeMapper;
	private final HomeMapper homeMapper; 
	private final PostDataMapper postDataMapper;
	private final PostCommentMapper postCommentMapper;
	private final BookmarkMapper bookmarkMapper;
	private final PostRepository postRepository;
	private final FollowsRepository followsRepository;
	private final PostDataRepository postDataRepository;
	private final PostLikeMapper postLikeMapper;
	
	public List<PostContentsDto> getThreeRecentPosts(){
		List<PostContentsDto> posts = postmapper.getRecentPostsThree();
		
		return posts;
	}
	
	public List<HomePostDto> getPostsOrderByLike(){
		List<HomePostDto> posts = homeMapper.getPostsOrderByLike();
		return posts;
	}
	
	
	
	public List<PostContentsDto> getRecentPostsThreeOfFollowersByFollowed(SecurityUser securityUser){
		List<PostContentsDto> posts = postmapper.getRecentPostsThreeOfFollowersByFollowed(securityUser.getUser().getId());
		return posts;
	}
	
	
	
	public List<Store> getStoresByKeyword(String keyword) {

		return storeMapper.getStoreByName(keyword);
    }

	public void insertPost(SecurityUser securityUser, Post post, List<PostDataCommand> postDataCommands) throws IOException {

		postmapper.insertPost(post);

		postDataCommands.stream()
				.map(postDataCommand -> {
					Store store = storeMapper.getStoreById(postDataCommand.getStoreId());
          
					return new PostData(post, store, postDataCommand.getContent(), postDataCommand.getUuidPrefixedFileName());
				})
				.forEach(postData -> {
					postData.setUser(securityUser.getUser());
					postData.setCreateDate(new Date());
					postDataMapper.insertPostData(postData);
				});
    }

	public PostDto selectPost(int postId, SecurityUser securityUser) {
		PostDto dto = new PostDto();

		Post post = postmapper.getPostById(postId);
		
		List<PostDataDto> postDatas = postDataMapper.getPostDataByPostId(postId);
		logger.info(postDatas.toString());
		
		if(securityUser != null) {
			for(PostDataDto postData : postDatas) {
				Bookmark bookmarks = bookmarkMapper.getBookmarkByStoreIdAndCustomerId(postData.getStoreId() ,securityUser.getUser().getId());
				postData.setBookmark(bookmarks);
			}
			PostLikeDto likeDto = postLikeMapper.selectPostLikeByPostIdAndCustomerId(postId, securityUser.getUser().getId());
			dto.setPostLikeDto(likeDto);
		}
		List<PostComment> postComments = postCommentMapper.getCommentsByPostId(postId);

		dto.setPost(post);
		dto.setPostDatas(postDatas);
		dto.setPostComments(postComments);

		return dto;
	}
	
	public boolean deletePost(int postId, SecurityUser securityUser) {
		Post post = postmapper.getPostById(postId);
		
		if (post == null) {
			return false;
		}
		
		if (post.getCustomer().getId() != securityUser.getUser().getId()) {
			return false;
		}
		
		postLikeMapper.deletePostLikeByPostId(postId);
		postCommentMapper.deleteCommentsByPostId(postId);
		postDataMapper.deletePostDataByPostId(postId);
	    
	    postmapper.deletePost(postId);
	    
	    return true;
		
	}
	
	public Object changeBookmark(int storeId, String job, SecurityUser securityUser) {
		
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("storeId", storeId);
	    paramMap.put("customerId", securityUser.getUser().getId());

	    if ("Y".equals(job)) {
	        // 북마크 추가 로직
	        storeMapper.insertBookmark(paramMap);
	    } else if ("N".equals(job)) {
	        // 북마크 삭제 로직
	        storeMapper.deleteBookmark(paramMap);
	    }

	    // 변경된 북마크 상태를 반환
	    return getUpdatedBookmarkStatus(storeId, securityUser);
	}
	
	private Object getUpdatedBookmarkStatus(int storeId, SecurityUser securityUser) {
		return null;
	}

	public void updatePost(String title, String content, String pictureName) {

	}

    public Page<Projection.Post> getNonBlockedPostsByCustomerIdOrderByCreateDate(int id, Post.BLOCKED no, Integer page, Integer limit) {

		Page<Projection.Post> postsPaginated = postRepository.findPostsByCustomerIdAndBlockedOrderByCreateDateDesc(id, no, PageRequest.of(page, limit));

		return postsPaginated;
    }


	public void insertPostComment(PostCommentCommand form, SecurityUser securityUser) throws IOException{
		
		PostComment postComment = new PostComment();
		postComment.setContent(form.getContent());
		
		Post post = postmapper.getPostById(form.getPostId());
		postComment.setPost(post);
		postComment.setCustomer(securityUser.getUser());
		
		postCommentMapper.insertComment(postComment);
		
	}
	
	public boolean deletePostComment(int postId) {
		
		postCommentMapper.deleteComment(postId);
		
		return true;
	}

    public long getPostsCountByCustomerId(Integer customerId) {
		return postRepository.countByCustomerId(customerId);
    }
    
    public List<PostContentsDto> getAllPosts(int page, int limit){

    	int start = (page - 1) * limit;
    	
    	return postmapper.getAllPosts(start, limit);
    }

    public List<PostContentsDto> getPostsPaginatedOfFollowersByFollowed(int page, int limit, SecurityUser securityUser) {

		int start = (page - 1) * limit;

		return postmapper.getPostsPaginatedOfFollowersByFollowed(start, limit, securityUser.getUser().getId());
    }

	public Page<PostData> getPostDataByCustomerIdOrderByCreateDateDesc(int id, Integer page, Integer limit) {

		return postDataRepository.findByUserIdOrderByCreateDateDesc(id, PageRequest.of(page, limit));
	}


	public void insertLike(int customerId, int postId) {
		postLikeMapper.insertLike(customerId,postId);
		postLikeMapper.addLike(postId);
	}

	public void deleteLike(int customerId, int postId) {
		postLikeMapper.deleteLike(customerId,postId);
		postLikeMapper.cancelLike(postId);
	}
	
	public List<PostContentsDto> getPostsByStoreSearch(SearchParamCommand searchParam) {
		
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("category", searchParam.getCategory());
	    paramMap.put("keyword", searchParam.getKeyword());
	    paramMap.put("xStart", searchParam.getXStart());
	    paramMap.put("xEnd", searchParam.getXEnd());
	    paramMap.put("yStart", searchParam.getYStart());
	    paramMap.put("yEnd", searchParam.getYEnd());
		
		return postmapper.getPostsByStoreSearch(paramMap);

	}
	
}
