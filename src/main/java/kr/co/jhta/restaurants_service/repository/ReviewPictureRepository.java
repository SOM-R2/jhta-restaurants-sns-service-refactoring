package kr.co.jhta.restaurants_service.repository;

import kr.co.jhta.restaurants_service.vo.review.ReviewPicture;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReviewPictureRepository extends JpaRepository<ReviewPicture, Integer> {

    Page<ReviewPicture> findByUserIdOrderByCreateDateDesc(int userId, Pageable pageable);
}
