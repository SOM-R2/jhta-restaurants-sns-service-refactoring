package kr.co.jhta.restaurants_service.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.jhta.restaurants_service.dto.InquiryList;
import kr.co.jhta.restaurants_service.mapper.InquiryMapper;
import kr.co.jhta.restaurants_service.vo.inquiry.Inquiry;
@Service
public class inquiryService {
	@Autowired
	private InquiryMapper inquiryMapper;

	public InquiryList getBoards(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return null;
	}

	public void createBoard(Inquiry inquiry) {
		inquiryMapper.insertInquiry(inquiry);
		
	}

	public Inquiry getBoardByNo(int no) {
		// TODO Auto-generated method stub
		return null;
	}

	public void updateBoard(Inquiry inquiry) {
		// TODO Auto-generated method stub
		
	}

}
