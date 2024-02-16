package kr.co.jhta.restaurants_service.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jhta.restaurants_service.vo.inquiry.Inquiry;

@Mapper
public interface InquiryMapper {

	void insertInquiry(Inquiry inquiry);

}
