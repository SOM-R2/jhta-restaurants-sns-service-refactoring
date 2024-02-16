package kr.co.jhta.restaurants_service.dto;

import kr.co.jhta.restaurants_service.vo.store.Store;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class RecommendedStoreDto {

	private Store store;
    private double reviewAverage;
}
