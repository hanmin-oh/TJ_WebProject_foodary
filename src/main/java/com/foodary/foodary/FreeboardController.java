package com.foodary.foodary;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.foodary.dao.DietDAO;
import com.foodary.dao.FreeboardDAO;
import com.foodary.vo.DietList;
import com.foodary.vo.DietVO;
import com.foodary.vo.FreeboardCommentList;
import com.foodary.vo.FreeboardCommentVO;
import com.foodary.vo.FreeboardList;
import com.foodary.vo.FreeboardVO;
import com.foodary.vo.ShareDietList;
import com.foodary.vo.ShareDietVO;
import com.foodary.vo.UserFoodList;
import com.foodary.vo.UserFoodVO;
import com.foodary.vo.UserRegisterVO;

@Controller
public class FreeboardController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private SqlSession sqlSession; 
	
	@RequestMapping("/freeboard/insert")
	public String insert(HttpServletRequest request, Model model, UserRegisterVO userRegisterVO) {
		logger.info("insert() 메소드 실행");
//	      공유한 식단이 있으면 불러오기
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		ArrayList<ShareDietVO> shareDietList = mapper.setShareFree(0);
		model.addAttribute("shareDietList", shareDietList);
		return "freeboard/insert";
	}
	   
	   @RequestMapping("/freeboard/dietListView")
		public String dietListView(HttpServletRequest request, Model model) {
			DietDAO mapper = sqlSession.getMapper(DietDAO.class);
			String dietWriteDate = request.getParameter("dietWriteDate");
			String id = request.getParameter("id");
			logger.info("#####################" + id + "########################");

			AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
			DietList dietList = ctx.getBean("dietList", DietList.class);

			HashMap<String, String> hmap = new HashMap<String, String>();
			hmap.put("dietWriteDate", dietWriteDate);
			hmap.put("id", id);
			dietList.setList(mapper.selectDietList(hmap));
			UserFoodList userFoodList = ctx.getBean("userFoodList", UserFoodList.class);

			logger.info("{}", dietList.getList());
			for (int i = 0; i < dietList.getList().size(); i++) {
				DietVO dietVO = dietList.getList().get(i);
				ArrayList<UserFoodVO> userFoodGup = mapper.userFoodListGup(dietVO.getGup());

				userFoodList.getList().addAll(userFoodGup);
			}

			logger.info("{}", userFoodList);
			model.addAttribute("dietList", dietList);
			model.addAttribute("userFoodList", userFoodList);
			model.addAttribute("dietWriteDate", dietWriteDate);
			return "freeboard/dietListView";
		}
	   
	   @RequestMapping("/freeboard/boardDiet")
		public String boardDiet(HttpServletRequest request, Model model, @RequestParam("dietWriteDate") String dietWriteDate,HttpSession session) {
			logger.info("freeboard의 boardDiet 메소드 실행");
			DietDAO mapper = sqlSession.getMapper(DietDAO.class);
			System.out.println(dietWriteDate);
			ArrayList<DietVO> dietList = mapper.dateGetDiet(dietWriteDate);
			System.out.println(dietList.get(0).getGup());
			System.out.println(dietList);
			
			// gupList 배열 선언
			int[] gupList = new int[dietList.size()];

			// 반복문을 사용하여 dietList의 각 요소의 getGup() 값을 gupList 배열에 넣기
			for (int i = 0; i < dietList.size(); i++) {
				int gup = dietList.get(i).getGup(); // 리스트에서 Diet 객체 가져오기
			    gupList[i] = gup; // gup 값을 배열에 저장
			}
			System.out.println(Arrays.toString(gupList));
			ArrayList<UserFoodVO> userFoodList = mapper.getFoodListGup(gupList);
			
			//새로운 테이블에 음식 이름, 칼,탄,단,지,시간 넣기
			//shareList 배열 생성
			ArrayList<ShareDietVO> shareDietList = new ArrayList<>();
			for (UserFoodVO userFood : userFoodList) {
			    ShareDietVO shareDietVO = new ShareDietVO();
			    shareDietVO.setIdx(1); // idx를 1로 고정
			    shareDietVO.setFoodName(userFood.getFoodName());
			    shareDietVO.setKcal(userFood.getKcal());
			    shareDietVO.setCarbs(userFood.getCarbs());
			    shareDietVO.setProtein(userFood.getProtein());
			    shareDietVO.setFat(userFood.getFat());
			    shareDietVO.setDietDate(dietWriteDate);
			    
			    // userFoodVO의 gup을 기준으로 해당 dietVO를 찾음
			    DietVO matchingDiet = null;
			    for (DietVO diet : dietList) {
			        if (diet.getGup() == userFood.getGup()) {
			            matchingDiet = diet;
			            break; // 일치하는 dietVO를 찾았으므로 루프 종료
			        }
			    }
			    
			    // matchingDiet에서 dietWriteTime을 가져와 설정
			    if (matchingDiet != null) {
			        shareDietVO.setDietTime(matchingDiet.getDietWriteTime());
			    } else {
			        // 일치하는 dietVO를 찾지 못한 경우에 대한 처리 (선택적)
			        // 예: 기본값 설정 또는 예외 처리
			        shareDietVO.setDietTime("기본값"); // 또는 예외 처리 등
			    }
			    
			    shareDietList.add(shareDietVO);
			    System.out.println("shaerInsert에 들어갈 정보: " + shareDietList);
			    mapper.insertShare(shareDietVO);
			}
			/*
			----- 다중 인서트문을 이용해서 insert하기
			// HashMap을 생성하고 shareDietList를 "shareDietVOList"라는 키로 추가합니다.
			HashMap<String, Object> paramMap = new HashMap<>();
			paramMap.put("shareDietVOList", shareDietList);
			System.out.println(paramMap);
			// MyBatis 매퍼에 HashMap을 전달합니다.
			mapper.insertShare(paramMap);
			 */
			return "freeboard/insert";
//			return null;
			
		}
	   
	   @RequestMapping("/freeboard/insertOK")
	   public String insertOK(MultipartHttpServletRequest request, Model model, FreeboardVO freeboardVO, UserRegisterVO userRegisterVO) {
	      logger.info("insertOK() 메소드 실행 -  커맨드 객체 사용");
	      FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
	      String rootUploadDir = "C:\\upload\\freeboard"; // 업로드 될 파일 경로
	      
	      // 사진 파일명에 날짜를 붙여주기 위해 가져온 Date클래스 객체
	      Date date = new Date();
	      SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
	      
	      MultipartFile multipartFile = request.getFile("fileName");
	      String originalFilename = multipartFile.getOriginalFilename().trim();
	      if (originalFilename.isEmpty())  {
	    	  String picture = "";
	    	  String realFilePath = "";
	    	  freeboardVO.setId(userRegisterVO.getId());
	    	  freeboardVO.setPicture(picture);
	    	  freeboardVO.setRealFilePath(realFilePath);
	    	  logger.info("{}", freeboardVO);
	    	  mapper.freeboardInsert(freeboardVO);
	      }
	      else {
	    		  String picture = sdf.format(date) + "_" + originalFilename; // 업로드해서 실제로 저장될 파일명
	    		  File dir = new File(rootUploadDir, picture);
	    		  String realFilePath = dir.getPath();
	    		  try {
	    			  multipartFile.transferTo(dir);  // 업로드해주는 코드
	    		  } catch (Exception e) { }
	    		  freeboardVO.setId(userRegisterVO.getId());
	    		  freeboardVO.setPicture(picture);
	    		  freeboardVO.setRealFilePath(realFilePath);
	    		  logger.info("{}", freeboardVO);
	    		  mapper.freeboardInsert(freeboardVO);
	      } 
	      
//	      게시판과 식단 공유 테이블을 gup로 연결하기
	      ArrayList<ShareDietVO> shareDietList = mapper.setShareFree(0);
	      System.out.println("식단삽입됐나??" + shareDietList);
	      if(!shareDietList.isEmpty()) {
	    	  System.out.println("식단 삽입되서 넘어옴~~~~~!!");
	    	  mapper.shareTagYes();
	      }
	      FreeboardVO getIdx = mapper.getIdx();
	      System.out.println(getIdx);
	      int idx = getIdx.getIdx();
	      mapper.setFreeboardGup(idx);
	      mapper.setShareDietGup(idx);
	      
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
	      int sharediet_gup = Integer.parseInt(request.getParameter("sharediet_gup"));
	      System.out.println(sharediet_gup);
		   mapper.freeboardIncrement(idx);
		   
		   model.addAttribute("idx", request.getParameter("idx"));
		   model.addAttribute("sharediet_gup", request.getParameter("sharediet_gup"));
		   model.addAttribute("currentPage", request.getParameter("currentPage"));
	      
	      return "redirect:contentView";
	   }
	   
	   @RequestMapping("/freeboard/contentView")
	   public String contentView(HttpServletRequest request, Model model) {
	      logger.info("contentView() 메소드 실행");
	      FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
	      int idx = Integer.parseInt(request.getParameter("idx"));
		   int sharediet_gup = Integer.parseInt(request.getParameter("sharediet_gup"));
	      FreeboardVO freeboardVO = mapper.freeboardSelectByIdx(idx);
	      logger.info("{}", freeboardVO);
	      System.out.println("contentView()의 gup " + sharediet_gup);
	      ArrayList<ShareDietVO> shareDietList = mapper.selectShareDiet(sharediet_gup);
		   System.out.println(shareDietList);
		   model.addAttribute("shareDietList", shareDietList);
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
		   FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
			   String rootUploadDir = "C:\\upload";
				   
			   Date date = new Date();
			   SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
				   
			   MultipartFile multipartFile = request.getFile("fileName");
			   String originalFilename = multipartFile.getOriginalFilename().trim();
			   logger.info("originalFilename이 뭔데;ㅋ :{}", originalFilename);
			if (originalFilename.isEmpty())  {
				if (freeboardVO.getPicture() != null) {
					String picture = freeboardVO.getPicture();
					String realFilePath = freeboardVO.getRealFilePath();
					freeboardVO.setPicture(picture);
					freeboardVO.setRealFilePath(realFilePath);
					logger.info("수정에 파일 없고 원래 사진 있을 때: {}", freeboardVO.getPicture());
					mapper.freeboardUpdate(freeboardVO);
				} else {
					String picture = "";
					String realFilePath = "";
					freeboardVO.setPicture(picture);
					freeboardVO.setRealFilePath(realFilePath);
					logger.info("수정에 사진 없고 올리지도 않을 때: {}", freeboardVO.getPicture(), freeboardVO);
					mapper.freeboardUpdate(freeboardVO);
				}
		   } else {
			   String picture = sdf.format(date) + "_" + originalFilename;
			   File dir = new File(rootUploadDir, picture);
			   String realFilePath = dir.getPath();
			   try {
				   multipartFile.transferTo(dir);
			   } catch (Exception e) { }
			   freeboardVO.setPicture(picture);
			   freeboardVO.setRealFilePath(realFilePath);
			   logger.info("수정에 파일 있을 때: {}", freeboardVO.getPicture());
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
	
	   
	   @RequestMapping("/freeboard/shareInsert")
	   public String shareInsert(HttpServletRequest request, Model model, UserRegisterVO userRegisterVO) {
	      logger.info("shareInsert() 메소드 실행"); 
	      return "freeboard/shareInsert";
	   }
	   
//	   @RequestMapping("/freeboard/shareInsertOK")
//	   public String shareInsertOK(MultipartHttpServletRequest request, Model model, FreeboardVO freeboardVO, UserRegisterVO userRegisterVO) {
//	      logger.info("shareInsertOK() 메소드 실행 -  커맨드 객체 사용");
//	      FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
//	      String rootUploadDir = "C:\\upload\\freeboard"; // 업로드 될 파일 경로
//	      System.out.println("게시판 gup===" + freeboardVO.getUserfood_gup());
//	      // 사진 파일명에 날짜를 붙여주기 위해 가져온 Date클래스 객체
//	      Date date = new Date();
//	      SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
//	      MultipartFile multipartFile = request.getFile("fileName");
//	      String originalFilename = multipartFile.getOriginalFilename().trim();
//	      if (originalFilename.isEmpty())  {
//	    	  String picture = "";
//	    	  String realFilePath = "";
//	    	  freeboardVO.setId(userRegisterVO.getId());
//	    	  freeboardVO.setPicture(picture);
//	    	  freeboardVO.setRealFilePath(realFilePath);
//	    	  logger.info("{}", freeboardVO);
//	    	  mapper.freeboardInsert(freeboardVO);
//	      }
//	      else {
//	    		  String picture = sdf.format(date) + "_" + originalFilename; // 업로드해서 실제로 저장될 파일명
//	    		  File dir = new File(rootUploadDir, picture);
//	    		  String realFilePath = dir.getPath();
//	    		  try {
//	    			  multipartFile.transferTo(dir);  // 업로드해주는 코드
//	    		  } catch (Exception e) { }
//	    		  freeboardVO.setId(userRegisterVO.getId());
//	    		  freeboardVO.setPicture(picture);
//	    		  freeboardVO.setRealFilePath(realFilePath);
//	    		  logger.info("{}", freeboardVO);
//	    		  mapper.freeboardInsert(freeboardVO);
//	      } 
//	      	model.addAttribute("result", "insertOK");
//	    	return "redirect:listView";
//	   }
	   
//	   @RequestMapping("/freeboard/shareView")
//	   public String shareView(HttpServletRequest request, Model model) {
//		   logger.info("shareView() 메소드 실행");
//		   FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
//		   int idx = Integer.parseInt(request.getParameter("idx"));
//		   int gup = Integer.parseInt(request.getParameter("gup"));
//		   FreeboardVO freeboardVO = mapper.freeboardSelectByIdx(idx);
//		   logger.info("{}", freeboardVO);
//		   DietVO dvo = mapper.selectDiet(gup);
//		   ArrayList<UserFoodVO> userFoodList = mapper.selectUserFood(gup);
//		   model.addAttribute("dvo", dvo);
//		   model.addAttribute("userFoodList", userFoodList);
//		   System.out.println(dvo);
//		   System.out.println(userFoodList);
//		   model.addAttribute("vo", freeboardVO);
//		   model.addAttribute("currentPage", request.getParameter("currentPage"));
//		   model.addAttribute("enter", "\r\n");
//		   
//		   AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
//		   FreeboardCommentList freeboardCommentList = ctx.getBean("freeboardCommentList", FreeboardCommentList.class);
//		   freeboardCommentList.setList(mapper.selectCommentList(idx));
//		   model.addAttribute("freeboardCommentList", freeboardCommentList);
//		   return "freeboard/contentView2";
//	   }
	   
	   
}





