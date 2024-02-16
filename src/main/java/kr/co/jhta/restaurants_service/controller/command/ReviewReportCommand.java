package kr.co.jhta.restaurants_service.controller.command;

import kr.co.jhta.restaurants_service.vo.review.ReviewReport.CATEGORY;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class ReviewReportCommand {

	private String content;
	private String category;
	private Integer reviewId;
}
