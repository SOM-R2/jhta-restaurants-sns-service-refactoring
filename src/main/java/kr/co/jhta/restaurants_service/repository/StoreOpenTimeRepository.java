package kr.co.jhta.restaurants_service.repository;

import kr.co.jhta.restaurants_service.vo.store.StoreOpenTime;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StoreOpenTimeRepository extends JpaRepository<StoreOpenTime, Integer> {

    List<StoreOpenTime> findStoreOpenTimeByStoreId(int storeId);
    void deleteByStoreId(int storeId);
}
