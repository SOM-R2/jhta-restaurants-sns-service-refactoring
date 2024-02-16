package kr.co.jhta.restaurants_service.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ReviewSummaryDto {

	private int bad;
	private int soso;
	private int good;

	public int getTotal() {
		return bad + soso + good;
	}
}
