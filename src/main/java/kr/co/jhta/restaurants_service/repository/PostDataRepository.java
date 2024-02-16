package kr.co.jhta.restaurants_service.repository;

import kr.co.jhta.restaurants_service.vo.post.PostData;
import kr.co.jhta.restaurants_service.vo.user.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PostDataRepository extends JpaRepository<PostData, Integer> {

    List<PostData> findByUserId(int userId);
    Page<PostData> findByUserIdOrderByCreateDateDesc(int userId, Pageable pageable);
    List<PostData> findByStoreId(int storeId);
    void deleteByStoreId(int storeId);
}
