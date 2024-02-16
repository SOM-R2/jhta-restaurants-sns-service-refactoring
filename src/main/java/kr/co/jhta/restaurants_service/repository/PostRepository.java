package kr.co.jhta.restaurants_service.repository;

import kr.co.jhta.restaurants_service.projection.Projection;
import kr.co.jhta.restaurants_service.vo.post.Post;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PostRepository extends JpaRepository<Post, Integer> {

    List<Post> findPostsByCustomerId(int customerId);

    Page<Projection.Post> findPostsByCustomerIdAndBlockedOrderByCreateDateDesc(
            int customerId, Post.BLOCKED blocked, Pageable pageable
    );

    long countByCustomerId(int customerId);
}
