package kr.co.jhta.restaurants_service.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jhta.restaurants_service.vo.review.ReviewReport;


@Mapper
public interface ReviewReportMapper {

	void insertReveiwReport(ReviewReport reviewReport);
}
