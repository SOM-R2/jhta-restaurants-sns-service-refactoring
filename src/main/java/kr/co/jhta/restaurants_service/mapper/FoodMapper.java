package kr.co.jhta.restaurants_service.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jhta.restaurants_service.vo.store.Food;

@Mapper
public interface FoodMapper {

	List<Food> getFoodsByStoreId(int storeId);
}