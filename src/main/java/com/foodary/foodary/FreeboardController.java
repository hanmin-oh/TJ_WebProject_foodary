package com.foodary.foodary;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.foodary.dao.FreeboardDAO;
import com.foodary.vo.FreeboardCommentList;
import com.foodary.vo.FreeboardCommentVO;
import com.foodary.vo.FreeboardList;
import com.foodary.vo.FreeboardVO;
import com.foodary.vo.UserRegisterVO;

@Controller
public class FreeboardController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private SqlSession sqlSession; 
	
	   @RequestMapping("/freeboard/insert")
	   public String insert(HttpServletRequest request, Model model, UserRegisterVO userRegisterVO) {
	      logger.info("insert() 메소드 실행"); 
	      return "freeboard/insert";
	   }
	   
	   @RequestMapping("/freeboard/insertOK")
	   public String insertOK(MultipartHttpServletRequest request, Model model, FreeboardVO freeboardVO, UserRegisterVO userRegisterVO) {
	      logger.info("insertOK() 메소드 실행 -  커맨드 객체 사용");
	      FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
	      String rootUploadDir = "C:\\start_nsy\\spring\\workspace\\foodary\\src\\main\\webapp\\WEB-INF";
	      File dir = new File(rootUploadDir + File.separator + "upload");
	      if (!dir.exists()) {
	    	  dir.mkdirs();
	      }
	      Iterator<String> iterator = request.getFileNames();
	      String uploadFileName = "";
	      MultipartFile multipartFile = null;
	      String originalName = "";
	      
	      try {
	    	  uploadFileName = iterator.next();
	    	  multipartFile = request.getFile(uploadFileName);
	    	  String picture = multipartFile.getOriginalFilename();
	    	  String realFilePath = dir.getPath();
	    	  freeboardVO.setId(userRegisterVO.getId());
	    	  freeboardVO.setPicture(picture);
	    	  freeboardVO.setRealFilePath(realFilePath);
	    	  logger.info("{}", freeboardVO);
	    	  mapper.freeboardInsert(freeboardVO);
	    	  
	      } catch (Exception e) {
				String picture = "";
				String realFilePath = "";
				freeboardVO.setId(userRegisterVO.getId());
				freeboardVO.setPicture(picture);
				freeboardVO.setRealFilePath(realFilePath);
				logger.info("{}", freeboardVO);
				mapper.freeboardInsert(freeboardVO);
	      } 
	      	model.addAttribute("result", "insertOK");
	    	return "redirect:listView";
	   }
	   
	   @RequestMapping("/freeboard/listView")
	   public String listView(HttpServletRequest request, Model model) {
		   int currentPage = 1;
		   int pageSize = 10;
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
		   
		   ArrayList<FreeboardVO> notice = mapper.freeboardSelectNotice();
		   String messages = "";
		   for (FreeboardVO vo : notice) {
			   vo.setCommentCount(mapper.commentCount(vo.getIdx()));
		   }
		   for (FreeboardVO vo : freeboardList.getList()) {
			   vo.setCommentCount(mapper.commentCount(vo.getIdx()));
		   }
		   try {
			   if (request.getParameter("result").equals("insertOK")) {
				   messages = "<script type='text/javascript'>" +
						   "alert('게시글이 성공적으로 저장되었습니다')</script>";
				   model.addAttribute("result", messages);
			   } else if (request.getParameter("result").equals("deleteOK")) {
				   messages = "<script type='text/javascript'>" +
						   "alert('게시글 삭제 완료')</script>";
				   model.addAttribute("result", messages);
			   }  else if (request.getParameter("result").equals("updateOK")) {
				   messages = "<script type='text/javascript'>" +
						   "alert('게시글 수정 완료')</script>";
				   model.addAttribute("result", messages);
			   }
		   } catch (Exception e) { }
		   
		   model.addAttribute("notice", notice);
		   model.addAttribute("freeboardList", freeboardList);
		   model.addAttribute("currentPage", currentPage);
		   
		   return "freeboard/listView";
	   }
	   
	   @RequestMapping("/freeboard/increment")
	   public String increment(HttpServletRequest request, Model model) {
	      logger.info("increment() 메소드 실행");
	      
	      FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
	      
	      int idx = Integer.parseInt(request.getParameter("idx"));
	      
	      mapper.freeboardIncrement(idx);
	      
	      model.addAttribute("idx", request.getParameter("idx"));
	      model.addAttribute("currentPage", request.getParameter("currentPage"));
	      
	      return "redirect:contentView";
	   }
	   
	   @RequestMapping("/freeboard/contentView")
	   public String contentView(HttpServletRequest request, Model model) {
	      logger.info("contentView() 메소드 실행");
	      FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
	      int idx = Integer.parseInt(request.getParameter("idx"));
		
	      FreeboardVO freeboardVO = mapper.freeboardSelectByIdx(idx);
	      logger.info("{}", freeboardVO);
		
	      model.addAttribute("vo", freeboardVO);
	      model.addAttribute("currentPage", request.getParameter("currentPage"));
	      model.addAttribute("enter", "\r\n");
	      
	      AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
  			FreeboardCommentList freeboardCommentList = ctx.getBean("freeboardCommentList", FreeboardCommentList.class);
  			freeboardCommentList.setList(mapper.selectCommentList(idx));
  			model.addAttribute("freeboardCommentList", freeboardCommentList);
	      return "freeboard/contentView";
	   }
	   
	   @RequestMapping("/freeboard/selectByIdx")
	   public String selectByIdx(HttpServletRequest request, Model model) {
		  FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
	      int idx = Integer.parseInt(request.getParameter("idx"));
	      int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	      String job = request.getParameter("job");
	      
	      FreeboardVO freeboardVO = mapper.freeboardSelectByIdx(idx);
	      model.addAttribute("vo", freeboardVO);
	      model.addAttribute("currentPage", request.getParameter("currentPage"));
	      model.addAttribute("enter", "\r\n");
	      
	  	if (job.equals("contentView")) {
	  		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
	  		FreeboardCommentList freeboardCommentList = ctx.getBean("freeboardCommentList", FreeboardCommentList.class);
	  		freeboardCommentList.setList(mapper.selectCommentList(idx));
			model.addAttribute("freeboardCommentList", freeboardCommentList);
		}
	      
	      return "freeboard/" + job;
	   }
	   
	   @RequestMapping("/freeboard/deleteOK")
	   public String deleteOK(HttpServletRequest request, Model model) {
		   	FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		   	int idx = Integer.parseInt(request.getParameter("idx"));
		   	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		   	
		   	mapper.freeboardDelete(idx);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("result", "deleteOK");
			return "redirect:listView";
	   }
	   
	   @RequestMapping("/freeboard/updateOK")
	   public String updateOK(MultipartHttpServletRequest request, Model model, FreeboardVO freeboardVO) {
	      logger.info("insertOK() 메소드 실행 -  커맨드 객체 사용");
	      FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
	      String rootUploadDir = "C:" + File.separator + "Upload";
	      File dir = new File(rootUploadDir + File.separator + "foodary");
	      if (!dir.exists()) {
	    	  dir.mkdirs();
	      }
	      Iterator<String> iterator = request.getFileNames();
	      String uploadFileName = "";
	      MultipartFile multipartFile = null;
	      String originalName = "";
	      
	      try {
	    	  uploadFileName = iterator.next();
	    	  multipartFile = request.getFile(uploadFileName);
	    	  String picture = multipartFile.getOriginalFilename();
	    	  String realFilePath = dir.getPath();
	    	  freeboardVO.setPicture(picture);
	    	  freeboardVO.setRealFilePath(realFilePath);
	    	  logger.info("{}", freeboardVO);
	    	  mapper.freeboardUpdate(freeboardVO);
	      } catch (Exception e) {
				String picture = "";
				String realFilePath = "";
				freeboardVO.setPicture(picture);
				freeboardVO.setRealFilePath(realFilePath);
				logger.info("{}", freeboardVO);
				mapper.freeboardUpdate(freeboardVO);
	      } 
	      	model.addAttribute("result", "updateOK");
	    	return "redirect:listView";
	   }
	   
	   @RequestMapping("/freeboard/commentOK")
	   public String commentOK(HttpServletRequest request, Model model, FreeboardCommentVO freeboardCommentVO, UserRegisterVO userRegisterVO) {
		   FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		   
		   int mode = Integer.parseInt(request.getParameter("mode"));
		   int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		   switch (mode) {
		   case 1:
			   freeboardCommentVO.setId(userRegisterVO.getId());
			   mapper.insertComment(freeboardCommentVO);
			   break;
		   case 2:
			   mapper.updateComment(freeboardCommentVO);
			   break;
		   case 3:
			   mapper.deleteComment(freeboardCommentVO);
			   break;
		   }
		   model.addAttribute("idx", freeboardCommentVO.getGup());
		   model.addAttribute("currentPage", currentPage);
		   model.addAttribute("job", "contentView");
		   return "redirect:selectByIdx";
	   }
}





