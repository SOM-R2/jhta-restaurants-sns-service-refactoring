package kr.co.jhta.restaurants_service.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jhta.restaurants_service.vo.store.StoreOpenTime;

@Mapper
public interface StoreOpenTimeMapper {

	List<StoreOpenTime> getStoreOpenTimesByStoreId(int storeId);
}
