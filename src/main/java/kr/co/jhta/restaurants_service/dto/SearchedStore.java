package kr.co.jhta.restaurants_service.dto;

import org.apache.ibatis.type.Alias;

import kr.co.jhta.restaurants_service.util.FormatUtils;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Setter
@Getter
@NoArgsConstructor
@Alias("SearchedStore")
public class SearchedStore {
	
	private int id;
	private String name;
	private double reviewAvg;
	private int reviewCnt;
	private int bookmarkCnt;
	private Double combinedScore;
	private String category;
    private double latitude;
    private double longitude;
    private String pictureName;
    private String address;

	
}
