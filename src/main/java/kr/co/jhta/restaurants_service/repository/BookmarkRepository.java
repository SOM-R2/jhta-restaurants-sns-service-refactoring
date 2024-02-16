package kr.co.jhta.restaurants_service.repository;

import kr.co.jhta.restaurants_service.projection.Projection;
import kr.co.jhta.restaurants_service.vo.store.Bookmark;
import kr.co.jhta.restaurants_service.vo.user.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookmarkRepository extends JpaRepository<Bookmark, Integer> {

    List<Projection.Bookmark> findByStoreId(int storeId);
    void deleteByStoreId(int storeId);
}
