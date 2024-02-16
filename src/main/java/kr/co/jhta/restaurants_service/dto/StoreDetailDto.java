package kr.co.jhta.restaurants_service.dto;

import java.util.List;

import kr.co.jhta.restaurants_service.vo.store.Food;
import kr.co.jhta.restaurants_service.vo.store.Store;
import kr.co.jhta.restaurants_service.vo.store.StoreOpenTime;
import kr.co.jhta.restaurants_service.vo.user.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class StoreDetailDto {

	private Store store;
	private List<Food> foods;
	private List<StoreOpenTime> openTimes;
	private List<Store> closestStores;
	private List<User> wishers;
	private List<User> followers;

	public StoreDetailDto(Store store, List<Food> foods, List<StoreOpenTime> openTimes, List<User> wishers) {
		this.store = store;
		this.foods = foods;
		this.openTimes = openTimes;
		this.wishers = wishers;
	}
}
