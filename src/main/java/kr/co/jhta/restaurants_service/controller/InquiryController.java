package kr.co.jhta.restaurants_service.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.jhta.restaurants_service.dto.InquiryList;
import kr.co.jhta.restaurants_service.service.inquiryService;
import kr.co.jhta.restaurants_service.vo.inquiry.Inquiry;
import kr.co.jhta.restaurants_service.vo.user.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/inquiry")
@RequiredArgsConstructor
@Slf4j
public class InquiryController {
	
	private final inquiryService inquiryService;
	
	@GetMapping("/list")
	public String boardForm(
			@RequestParam(name="rows", required = false, defaultValue = "10") int rows,
			@RequestParam(name = "page", required = false, defaultValue = "1") int page,
			Model model ) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("rows", rows);
		param.put("page", page);
		InquiryList inquiryList = inquiryService.getBoards(param);
		model.addAttribute("result", inquiryList);
		
		return "/inquiry/list";
	}
	
	@GetMapping("/post")
	public String postNew() {
		return "inquiry/form";
	}
	
	@GetMapping("/detail")
	public String detail() {
		
		return "inquiry/detail";
	}
	
	@PostMapping("/post")
	public String register(String title, String content, Model model,@AuthenticationPrincipal User user) {
		Inquiry inquiry = Inquiry.builder()
							.title(title)
							.content(content)
							.user(user)
							.build();
		inquiryService.createBoard(inquiry);
		
		System.out.println("user :" + user);
		
		model.addAttribute("title",title);
		model.addAttribute("content",content);
		model.addAttribute("username",user.getUsername());
		
		return "redirect:/inquiry/list";

	}
//	
//	@GetMapping("/modify")
//	public String modifyForm(int no, Model model) {
//		model.addAttribute("no", no);
//		return "/board/modifyform";
//	}
//	
//	@PostMapping("/modify")
//	public String modify(String title, String content, @RequestParam("no") int no) {
//		Board board = boardService.getBoardByNo(no);
//		board.setTitle(title);
//		board.setContent(content);
//		boardService.updateBoard(board);
//		
//		return "redirect:/board/list";
//	}
//	
	@GetMapping("/delete")
	public String delete(int no) {
		
		Inquiry inquiry = inquiryService.getBoardByNo(no);
		inquiry.setDisabled("y");
		inquiryService.updateBoard(inquiry);
		return "redirect:/board/list";

	}

}
