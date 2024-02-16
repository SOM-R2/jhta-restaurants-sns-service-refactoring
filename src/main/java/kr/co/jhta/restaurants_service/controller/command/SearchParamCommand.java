package kr.co.jhta.restaurants_service.controller.command;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class SearchParamCommand {

	private String category;
	private String keyword;
	private Double xStart;
	private Double xEnd;
	private Double yStart;
	private Double yEnd;
}
