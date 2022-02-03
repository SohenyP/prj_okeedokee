package kr.co.goodee39.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.goodee39.service.ReportService;
import kr.co.goodee39.vo.reportVO;

@Controller
public class ReportController {

	@Autowired
	ReportService service;

	// 신고 게시판 이동
	@GetMapping("/report")
	public String report(
			@RequestParam int bdiv, 
			@RequestParam int num, 
			@ModelAttribute("repVO") reportVO vo,
			HttpServletRequest request, 
			HttpSession session, 
			Model model) {

		String path = "";

		// 로그인 후 신고 가능
		if (session.getAttribute("account") == null) {
			path = "redirect:/member/loginPage";
		} else if (session.getAttribute("account") != null) {
			// 이전 페이지 주소 받아오기
			String boardUrl = request.getHeader("referer");
			System.out.println(boardUrl);

			model.addAttribute("boardUrl", boardUrl);

			// 신고대상 게시글 제목 가져오기
			service.selectTitle(bdiv, num, model);

			path = "d_report";
		}

		return path;
	}

	// 신고 제출
	@PostMapping("/reportResult")
	public String reportResult(@ModelAttribute("repVO") reportVO vo) {

		String path = service.insertReport(vo);

		return "redirect:/" + path;
	}

	// 신고내역 이동
	@GetMapping("/reportList")
	public String reportList(HttpSession session, reportVO vo, Model model) {

		service.selectReportList(session, vo, model);

		return "g_mypage_report";
	}

	// 신고내역 글 읽기
	@GetMapping("/readReport")
	public String readReport(
			@RequestParam int num, 
			HttpSession session, 
			reportVO vo, 
			Model model) {

		service.selectReport(num, vo, session, model);

		return "d_report_read";
	}
	
	//신고내역 수정이동
	@GetMapping("/reviseReport")
	public String reviseReport(
			@RequestParam int num, 
			HttpSession session, 
			reportVO vo, 
			Model model) {
		
		service.selectReport(num, vo, session, model);
		
		return "d_report_revise";
	}
	
	//신고내역 수정제출
	@GetMapping("/reviseReportResult")
	public String reviseReportResult(reportVO vo) {
		
		service.updateReport(vo);
		
		return "redirect:/reportList";
	}

	// 신고내역 삭제
	@GetMapping("/isdeleteReport")
	public String isdeleteReport(@RequestParam int num, reportVO vo) {

		service.deleteReport(num, vo);

		return "redirect:/reportList";
	}

}
