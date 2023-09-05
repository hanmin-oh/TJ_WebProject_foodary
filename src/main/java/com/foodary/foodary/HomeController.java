package com.foodary.foodary;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.foodary.dao.FreeboardDAO;
import com.foodary.vo.FreeboardList;
import com.foodary.vo.FreeboardVO;
import com.foodary.vo.UserRegisterVO;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/")
	public String login(HttpServletRequest request, Model model) {
		int currentPage = 1;
		int pageSize = 11;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) { }
		
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		 int totalCount = mapper.freeboardSelectCount();
	      
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		FreeboardList freeboardList = ctx.getBean("freeboardList", FreeboardList.class);
		freeboardList.initFreeboardList(pageSize, totalCount, currentPage);
		 
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", freeboardList.getStartNo());
		hmap.put("endNo", freeboardList.getEndNo());
		freeboardList.setList(mapper.freeboardSelectList(hmap));
		
//		모든 공지글을 얻어온다.
		ArrayList<FreeboardVO> notice = mapper.freeboardSelectNotice();

//		공지글과 메인글의 댓글 개수를 얻어와서 FreeboardVO 클래스의 commentCount에 저장한다.
		for (FreeboardVO vo : notice) {
			vo.setCommentCount(mapper.commentCount(vo.getIdx()));
		}
		for (FreeboardVO vo : freeboardList.getList()) {
			vo.setCommentCount(mapper.commentCount(vo.getIdx()));
		}

//		공지글과 메인글의 목록을 request 영역에 저장해서 메인글을 화면에 표시하는 페이지(listView.jsp)로 넘겨준다.
		model.addAttribute("notice", notice);
		model.addAttribute("freeboardList", freeboardList);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("msg", request.getParameter("msg"));
		return "main/foodaryMainPageBefore";
	}

	@RequestMapping("/main/foodaryMainPageAfter")
	public String foodaryMainPageAfter(HttpServletRequest request, Model model, UserRegisterVO userRegisterVO) {
		
		int currentPage = 1;
		int pageSize = 11;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) { }
		
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		int totalCount = mapper.freeboardSelectCount();
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		FreeboardList freeboardList = ctx.getBean("freeboardList", FreeboardList.class);
		freeboardList.initFreeboardList(pageSize, totalCount, currentPage);
		
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", freeboardList.getStartNo());
		hmap.put("endNo", freeboardList.getEndNo());
		freeboardList.setList(mapper.freeboardSelectList(hmap));
		
//		모든 공지글을 얻어온다.
		ArrayList<FreeboardVO> notice = mapper.freeboardSelectNotice();
		
//		공지글과 메인글의 댓글 개수를 얻어와서 FreeboardVO 클래스의 commentCount에 저장한다.
		for (FreeboardVO vo : notice) {
			vo.setCommentCount(mapper.commentCount(vo.getIdx()));
		}
		for (FreeboardVO vo : freeboardList.getList()) {
			vo.setCommentCount(mapper.commentCount(vo.getIdx()));
		}
		
//		공지글과 메인글의 목록을 request 영역에 저장해서 메인글을 화면에 표시하는 페이지(listView.jsp)로 넘겨준다.
		model.addAttribute("notice", notice);
		model.addAttribute("freeboardList", freeboardList);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("msg", request.getParameter("msg"));
		return "main/foodaryMainPageAfter";
	}
}
