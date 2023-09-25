package com.foodary.foodary;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
<<<<<<< HEAD
import java.util.List;
=======
import java.util.Iterator;
>>>>>>> 370244fb95e8ea81ec8105779759cadf1c02ca29

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.foodary.dao.FreeboardDAO;
import com.foodary.vo.FreeboardCommentList;
import com.foodary.vo.FreeboardCommentVO;
import com.foodary.vo.FreeboardList;
import com.foodary.vo.FreeboardVO;
<<<<<<< HEAD
import com.foodary.vo.ShareDietVO;
import com.foodary.vo.UserFoodList;
import com.foodary.vo.UserFoodVO;
=======
>>>>>>> 370244fb95e8ea81ec8105779759cadf1c02ca29
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
	public String insertOK(MultipartHttpServletRequest request, Model model, FreeboardVO freeboardVO,
			UserRegisterVO userRegisterVO) {
		logger.info("insertOK() 메소드 실행 -  커맨드 객체 사용");
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
<<<<<<< HEAD
		String rootUploadDir = "C:\\coding\\Tjoeun\\07_web_project_foodary\\foodary\\src\\main\\webapp\\WEB-INF\\upload\\freeboard"; // 업로드 될 파일 경로
=======
		String rootUploadDir = "C:\\k_digital\\Spring_pj_foodary\\workspace\\foodary\\src\\main\\webapp\\WEB-INF\\upload\\freeboard"; // 업로드 될 파일 경로
>>>>>>> 19796b5b40dcf0c9c3826d143212d00d2633109a

		// 사진 파일명에 날짜를 붙여주기 위해 가져온 Date클래스 객체
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");

		MultipartFile multipartFile = request.getFile("fileName");
		String originalFilename = multipartFile.getOriginalFilename().trim();
		if (originalFilename.isEmpty()) {
			String picture = "";
			String realFilePath = "";
			freeboardVO.setId(userRegisterVO.getId());
			freeboardVO.setPicture(picture);
			freeboardVO.setRealFilePath(realFilePath);
			logger.info("{}", freeboardVO);
			mapper.freeboardInsert(freeboardVO);
		} else {
			String picture = sdf.format(date) + "_" + originalFilename; // 업로드해서 실제로 저장될 파일명
			File dir = new File(rootUploadDir, picture);
			String realFilePath = dir.getPath();
			try {
				multipartFile.transferTo(dir); // 업로드해주는 코드
			} catch (Exception e) {
			}
<<<<<<< HEAD

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
			model.addAttribute("shareDietList" , shareDietList);
			return "freeboard/insert";
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
	      int userfood_gup = Integer.parseInt(request.getParameter("userfood_gup"));
	      System.out.println(userfood_gup);
		   mapper.freeboardIncrement(idx);
		   
		   model.addAttribute("idx", request.getParameter("idx"));
		   model.addAttribute("userfood_gup", request.getParameter("userfood_gup"));
		   model.addAttribute("currentPage", request.getParameter("currentPage"));
	      
	      return "redirect:contentView";
	   }
	   
	   @RequestMapping("/freeboard/contentView")
	   public String contentView(HttpServletRequest request, Model model) {
	      logger.info("contentView() 메소드 실행");
	      FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
	      int idx = Integer.parseInt(request.getParameter("idx"));
		   int userfood_gup = Integer.parseInt(request.getParameter("userfood_gup"));
	      FreeboardVO freeboardVO = mapper.freeboardSelectByIdx(idx);
	      logger.info("{}", freeboardVO);
	      System.out.println("contentView()의 gup " + userfood_gup);
	      DietVO dvo = mapper.selectDiet(userfood_gup);
		   ArrayList<UserFoodVO> userFoodList = mapper.selectUserFood(userfood_gup);
		   System.out.println(dvo);
		   System.out.println(userFoodList);
		   model.addAttribute("dvo", dvo);
		   model.addAttribute("userFoodList", userFoodList);
	      model.addAttribute("vo", freeboardVO);
	      model.addAttribute("currentPage", request.getParameter("currentPage"));
	      model.addAttribute("enter", "\r\n");
	      
	      AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
  			FreeboardCommentList freeboardCommentList = ctx.getBean("freeboardCommentList", FreeboardCommentList.class);
  			freeboardCommentList.setList(mapper.selectCommentList(idx));
  			model.addAttribute("freeboardCommentList", freeboardCommentList);
	      return "freeboard/contentView2";
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
=======
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
		} catch (NumberFormatException e) {
		}

		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		int totalCount = mapper.freeboardSelectCount();

		mapper.deleteGupZero(); 

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
				messages = "<script type='text/javascript'>" + "alert('게시글이 성공적으로 저장되었습니다')</script>";
				model.addAttribute("result", messages);
			} else if (request.getParameter("result").equals("deleteOK")) {
				messages = "<script type='text/javascript'>" + "alert('게시글 삭제 완료')</script>";
				model.addAttribute("result", messages);
			} else if (request.getParameter("result").equals("updateOK")) {
				messages = "<script type='text/javascript'>" + "alert('게시글 수정 완료')</script>";
				model.addAttribute("result", messages);
			}
		} catch (Exception e) {
		}
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
>>>>>>> 370244fb95e8ea81ec8105779759cadf1c02ca29
			model.addAttribute("freeboardCommentList", freeboardCommentList);
		}

		return "freeboard/" + job;
	}

	@RequestMapping("/freeboard/delete")
	public String delete(MultipartHttpServletRequest request, Model model) {
		logger.info("delete() 메소드 실행");
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		logger.info("idx: {}", idx);
		FreeboardVO freeboardVO = mapper.freeboardSelectByIdx(idx);
		logger.info("delete 메소드 - freeboardVO: {}, id: {}", freeboardVO, freeboardVO.getId());
		//////////////////////////////////////////////////////////////////////////////////
		/*
		
		String rootUploadDir = "C:\\k_digital\\Spring_pj_foodary\\workspace\\foodary\\src\\main\\webapp\\WEB-INF\\upload\\freeboard"; // 업로드 될 파일 경로

		// 사진 파일명에 날짜를 붙여주기 위해 가져온 Date클래스 객체
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");

		MultipartFile multipartFile = request.getFile("fileName");
		String originalFilename = multipartFile.getOriginalFilename().trim();
		if (originalFilename.isEmpty()) {
			String picture = "";
			String realFilePath = "";
			freeboardVO.setId(userRegisterVO.getId());
			freeboardVO.setPicture(picture);
			freeboardVO.setRealFilePath(realFilePath);
			logger.info("{}", freeboardVO);
			mapper.freeboardInsert(freeboardVO);
		} else {
			String picture = sdf.format(date) + "_" + originalFilename; // 업로드해서 실제로 저장될 파일명
			File dir = new File(rootUploadDir, picture);
			String realFilePath = dir.getPath();
			try {
				multipartFile.transferTo(dir); // 업로드해주는 코드
			} catch (Exception e) {
			}
			freeboardVO.setId(userRegisterVO.getId());
			freeboardVO.setPicture(picture);
			freeboardVO.setRealFilePath(realFilePath);
			logger.info("{}", freeboardVO);
			mapper.freeboardInsert(freeboardVO);
		}
		*/
		
		
		//////////////////////////////////////////////////////////////////////////////////
		
//		mapper.freeboardDelete(idx);
		model.addAttribute("idx", idx);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("result", "deleteOK"); // 메시지
		return "redirect:listView";
	}
	
<<<<<<< HEAD
	   
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
	   
	   @RequestMapping("/freeboard/shareView")
	   public String shareView(HttpServletRequest request, Model model) {
		   logger.info("shareView() 메소드 실행");
		   FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		   int idx = Integer.parseInt(request.getParameter("idx"));
		   int gup = Integer.parseInt(request.getParameter("gup"));
		   FreeboardVO freeboardVO = mapper.freeboardSelectByIdx(idx);
		   logger.info("{}", freeboardVO);
		   DietVO dvo = mapper.selectDiet(gup);
		   ArrayList<UserFoodVO> userFoodList = mapper.selectUserFood(gup);
		   model.addAttribute("dvo", dvo);
		   model.addAttribute("userFoodList", userFoodList);
		   System.out.println(dvo);
		   System.out.println(userFoodList);
		   model.addAttribute("vo", freeboardVO);
		   model.addAttribute("currentPage", request.getParameter("currentPage"));
		   model.addAttribute("enter", "\r\n");
		   
		   AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		   FreeboardCommentList freeboardCommentList = ctx.getBean("freeboardCommentList", FreeboardCommentList.class);
		   freeboardCommentList.setList(mapper.selectCommentList(idx));
		   model.addAttribute("freeboardCommentList", freeboardCommentList);
		   return "freeboard/contentView2";
	   }
	   
	   
=======
	@RequestMapping("/freeboard/deleteOK")
	public String deleteOK(HttpServletRequest request, Model model) {
		logger.info("deleteOK() 메소드 실행");
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		logger.info("idx: {}, currentPage: {}", idx, currentPage);
		
//		mapper.freeboardDelete(idx);
		model.addAttribute("idx", idx);
		model.addAttribute("currentPage", currentPage);
//		model.addAttribute("result", "deleteOK"); // 메시지
		return "freeboard/delete";
	}

	@RequestMapping("/freeboard/updateOK")
	public String updateOK(MultipartHttpServletRequest request, Model model, FreeboardVO freeboardVO) {
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
<<<<<<< HEAD
		String rootUploadDir = "C:\\coding\\Tjoeun\\07_web_project_foodary\\foodary\\src\\main\\webapp\\WEB-INF\\upload\\freeboard";
=======
		String rootUploadDir = "C:\\k_digital\\Spring_pj_foodary\\workspace\\foodary\\src\\main\\webapp\\WEB-INF\\upload\\freeboard";
>>>>>>> 19796b5b40dcf0c9c3826d143212d00d2633109a

		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");

		MultipartFile multipartFile = request.getFile("fileName");
		String originalFilename = multipartFile.getOriginalFilename().trim();
		logger.info("originalFilename이 뭔데;ㅋ :{}", originalFilename);
		if (originalFilename.isEmpty()) {
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
			} catch (Exception e) {
			}
			freeboardVO.setPicture(picture);
			freeboardVO.setRealFilePath(realFilePath);
			logger.info("수정에 파일 있을 때: {}", freeboardVO.getPicture());
			mapper.freeboardUpdate(freeboardVO);
		}

		model.addAttribute("result", "updateOK");
		return "redirect:listView";
	}

	@RequestMapping("/freeboard/commentOK")
	public String commentOK(HttpServletRequest request, Model model, FreeboardCommentVO freeboardCommentVO,
			UserRegisterVO userRegisterVO) {
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
>>>>>>> 370244fb95e8ea81ec8105779759cadf1c02ca29
}
