package com.foodary.foodary;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.foodary.dao.DietDAO;
import com.foodary.vo.DietList;
import com.foodary.vo.DietVO;
import com.foodary.vo.FoodList;
import com.foodary.vo.UserFoodList;
import com.foodary.vo.UserFoodVO;
import com.foodary.vo.UserRegisterVO;

@Controller
public class DietController {
	
	private static final Logger logger = LoggerFactory.getLogger(DietController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private HttpSession session;
	
	@RequestMapping("/diet/dietInsertView")
	public String dietInsertView(HttpServletRequest request, Model model, UserFoodVO userFoodVO) {
		logger.info("dietInsertView() 메소드 실행");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		UserFoodList userFoodList = ctx.getBean("userFoodList", UserFoodList.class);
		userFoodList.setList(mapper.userFoodList(0));
		session.setAttribute("userFoodList", userFoodList);
		return "diet/dietInsertView";
	}

	@RequestMapping(value = {"/diet/foodList", "/diet/updateFoodList"})
	   public String foodListView(HttpServletRequest request, Model model , DietVO dvo) {
	      logger.info("foodListView 메소드 실행");
	      logger.info("{}============" ,  dvo);
	      DietDAO mapper = sqlSession.getMapper(DietDAO.class);
	      int currentPage = 1;
	      int pageSize = 10;
	      try {
	         currentPage = Integer.parseInt(request.getParameter("currentPage"));
	      } catch (NumberFormatException e) {
	      }
	      
	      String foodName = request.getParameter("foodName");
	      String sessfoodName = (String) session.getAttribute("foodName");

	      if( sessfoodName == null) {
	         foodName = request.getParameter("foodName");
	         System.out.println(foodName);
	      }else if(sessfoodName != null && foodName != null) {
	    	  session.removeAttribute("foodName");
		  }else {
	         foodName = (String) session.getAttribute("foodName");
	      }
	      AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
	      FoodList foodList = ctx.getBean("foodList", FoodList.class);
	      
	      if (foodName == null || foodName.trim().length() == 0) {
	         int totalCount = mapper.foodSelectCount();
	         System.out.println(totalCount);
	         System.out.println(foodName);
	         foodList.initFoodList(pageSize, totalCount, currentPage);
	         HashMap<String, Integer> hmap = new HashMap<String, Integer>();
	         hmap.put("startNo", foodList.getStartNo());
	         hmap.put("endNo", foodList.getEndNo());
	         foodList.setList(mapper.foodSelectList(hmap));
	      } else {
	         session.setAttribute("foodName", foodName);
	         int totalCount = mapper.selectCountFood(foodName);
	         System.out.println(totalCount);
	         System.out.println(foodName);
	         foodList.initFoodList(pageSize, totalCount, currentPage);
	         Param param = new Param();
	         param.setStartNo(foodList.getStartNo());
	         param.setEndNo(foodList.getEndNo());
	         param.setFoodName(foodName);
	         System.out.println(param.getFoodName());
	         foodList.setList(mapper.foodSearchList(param));
	         System.out.println(foodList);
	      }
	      model.addAttribute("foodList", foodList);
	      model.addAttribute("currentPage", currentPage);
	       if(request.getServletPath().equals("/diet/foodList")) {
	          return "diet/foodListView";
	       }else {
	          model.addAttribute("gup" , dvo.getGup());
	          return "diet/updateFoodListView";
	       }
	   }
	
	@RequestMapping("/diet/popupClose")
	public String popupClose(HttpServletRequest request, Model model) {
		logger.info("popupClose 메소드 실행");
		session.removeAttribute("foodName");
		return "diet/dietInsertView";
	}
	

	@RequestMapping("/diet/foodAll")
	public String foodAll(HttpServletRequest request, Model model) {
		logger.info("foodAll 메소드 실행");
		
		session.removeAttribute("foodName");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
	      int currentPage = 1;
	      int pageSize = 10;
	      try {
	         currentPage = Integer.parseInt(request.getParameter("currentPage"));
	      } catch (NumberFormatException e) {
	      }
	      
	      AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
	      FoodList foodList = ctx.getBean("foodList", FoodList.class);
	      
	         int totalCount = mapper.foodSelectCount();
	         System.out.println(totalCount);
	         foodList.initFoodList(pageSize, totalCount, currentPage);
	         HashMap<String, Integer> hmap = new HashMap<String, Integer>();
	         hmap.put("startNo", foodList.getStartNo());
	         hmap.put("endNo", foodList.getEndNo());
	         foodList.setList(mapper.foodSelectList(hmap));
	      
		
	         model.addAttribute("foodList", foodList);
		      model.addAttribute("currentPage", currentPage);
		return "diet/foodListView";
	}


	@RequestMapping(value = {"/diet/userFoodInsert", "/diet/updateUserFoodInsert"})
	public String userFoodInsert(HttpServletRequest request, Model model, UserFoodVO userFoodVO, DietVO dvo) {
		logger.info("userFoodInsert 메소드 실행");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		logger.info("{}", userFoodVO);
		HttpSession session = request.getSession();
		
		String id = (String) session.getAttribute("id");
		logger.info("{}", id);
		
		if (request.getServletPath().equals("/diet/userFoodInsert")) {
		 	mapper.userFoodInsert(userFoodVO);
		 	session.removeAttribute("foodName");
	    	return "redirect:dietInsertView";
	    } else if(request.getServletPath().equals("/diet/updateUserFoodInsert")){
	    	System.out.println("======= updateUserFoodInsert");
	    	int gup = dvo.getGup();
	    	System.out.println(gup);
	    	userFoodVO.setGup(gup);
	    	session.removeAttribute("foodName");
	    	mapper.userFoodInsert(userFoodVO);
	    	return null;
	    } else {
	    	return null;
	    }
	}

	@RequestMapping("/diet/updateUserFood")
	public String updateUserFood(HttpServletRequest request, Model model, UserFoodVO userFoodVO) {
		logger.info("updateUserFood 메소드 실행");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		logger.info("{}", userFoodVO);
		
		mapper.updateUserFood(userFoodVO);
		
		return "redirect:dietInsertView";
	}

	@RequestMapping("/diet/deleteUserFood")
	public String deleteUserFood(HttpServletRequest request, Model model, UserFoodVO userFoodVO) {
		logger.info("updateUserFood 메소드 실행");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		logger.info("{}", userFoodVO);
		
		mapper.deleteUserFood(userFoodVO.getIdx());
	
		return "redirect:dietInsertView";
	}

	@RequestMapping("/diet/dietInsert")
	public String dietInsert(MultipartHttpServletRequest request, Model model, DietVO dietVO, UserFoodList userFoodList, UserRegisterVO userRegisterVO) {
		logger.info("========== dietInsert 메소드 실행 ===========");
		HttpSession session = request.getSession();
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		
<<<<<<< HEAD
		String rootUploadDir = "C:\\coding\\Tjoeun\\07_web_project_foodary\\foodary\\src\\main\\webapp\\WEB-INF\\upload\\diet"; // 업로드 될 파일 경로
=======
		String rootUploadDir = "C:\\k_digital\\Spring_pj_foodary\\workspace\\foodary\\src\\main\\webapp\\WEB-INF\\upload\\diet"; // 업로드 될 파일 경로
>>>>>>> 19796b5b40dcf0c9c3826d143212d00d2633109a
		// 사진 파일명에 날짜를 붙여주기 위해 가져온 Date클래스 객체
	    Date date = new Date();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
	      
	    MultipartFile multipartFile = request.getFile("fileName");
	    String originalFilename = multipartFile.getOriginalFilename().trim();
	    if (originalFilename.isEmpty())  {
	    	String picture = "no picture";
	    	dietVO.setDietPicture(picture);
	    	dietVO.setId(userRegisterVO.getId());
	    	logger.info("{}", dietVO);
	    	mapper.insertDiet(dietVO);
	    }
	    else {
	    	String picture = sdf.format(date) + "_" + originalFilename;
	    	File dir = new File(rootUploadDir, picture);
	    	try {
	    		multipartFile.transferTo(dir);  // 업로드해주는 코드
	    	} catch (Exception e) { }
	    	dietVO.setDietPicture(picture);
	    	dietVO.setId(userRegisterVO.getId());
	    	logger.info("{}", dietVO);
	    	mapper.insertDiet(dietVO);
	    }
	    
		DietVO getIdx = mapper.getIdx(0);
		int idx = getIdx.getIdx();
		mapper.setDietGup(idx);
		mapper.setUserFoodGup(idx);
		session.setAttribute("foodNames", null);
		model.addAttribute("gup", idx);
		model.addAttribute("dietWriteDate", dietVO.getDietWriteDate());
		model.addAttribute("id", userRegisterVO.getId());
		return "redirect:dietListView";
	}

	
	@RequestMapping("/diet/dietListView")
	public String dietListView(HttpServletRequest request, Model model) {
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		String dietWriteDate = request.getParameter("dietWriteDate");
		String id = request.getParameter("id");

		mapper.deleteGupZero();
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		DietList dietList = ctx.getBean("dietList", DietList.class);
		
		HashMap<String, String> hmap = new HashMap<String, String>();
		hmap.put("dietWriteDate", dietWriteDate);
		hmap.put("id", id);
		dietList.setList(mapper.selectDietList(hmap));
		UserFoodList userFoodList = ctx.getBean("userFoodList", UserFoodList.class);
		
		logger.info("{}", dietList.getList());
		for (int i=0; i<dietList.getList().size(); i++) {
			DietVO dietVO = dietList.getList().get(i);
			ArrayList<UserFoodVO> userFoodGup = mapper.userFoodListGup(dietVO.getGup());
		    
		    userFoodList.getList().addAll(userFoodGup);
		}
		
		logger.info("{}", userFoodList);
		model.addAttribute("dietList", dietList);
		model.addAttribute("userFoodList", userFoodList);
		model.addAttribute("dietWriteDate", dietWriteDate);
		
		return "diet/dietListView";
	}

	@RequestMapping("/diet/dietView")
	public String dietView(HttpServletRequest request, Model model) {
		logger.info("fdietListView 메소드 실행");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		String dietWriteDate = request.getParameter("dietWriteDate");
		String dietWriteTime = request.getParameter("dietWriteTime");
		String id = request.getParameter("id");
		HashMap<String, String> hmap = new HashMap<String, String>();
		hmap.put("dietWriteDate", dietWriteDate);
		hmap.put("dietWriteTime", dietWriteTime);
		hmap.put("id", id);
		DietVO dvo = mapper.selectDiet(hmap);
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		UserFoodList userFoodList = ctx.getBean("userFoodList", UserFoodList.class);
		
		userFoodList.setList(mapper.userFoodListGup(dvo.getGup()));
		
		model.addAttribute("dvo", dvo);
		model.addAttribute("userFoodList", userFoodList);
		
		return "diet/dietView";
	}

   @RequestMapping("/diet/dietViewAll")
      public String dietViewAll(HttpServletRequest request, Model model) {
         logger.info("dietView 메소드 실행");
         DietDAO mapper = sqlSession.getMapper(DietDAO.class);
         String dietWriteDate = request.getParameter("dietWriteDate");
         String dietWriteTime = request.getParameter("dietWriteTime");      
         String id = request.getParameter("id");
         System.out.printf("id: %s, dietWriteDate: %s, dietWriteTime: %s", String.format("%s", id),
               String.format("%s", dietWriteDate), String.format("%s", dietWriteTime));
//	         logger.info("id: {}, dietWriteDate: {}", id, dietWriteDate);
         
         AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
         DietList dietList = ctx.getBean("dietList", DietList.class);
         UserFoodList userFoodList = ctx.getBean("userFoodList", UserFoodList.class);
         if (dietWriteTime != null) {
            HashMap<String, String> hmap = new HashMap<String, String>();
            hmap.put("dietWriteDate", dietWriteDate);
            hmap.put("dietWriteTime", dietWriteTime);
            hmap.put("id", id);
            DietVO dvo = mapper.selectDiet(hmap);
            
            userFoodList.setList(mapper.userFoodListGup(dvo.getGup()));
            logger.info("userFoodList: {}", userFoodList);
            model.addAttribute("dvo", dvo);
            model.addAttribute("userFoodList", userFoodList);
         } else {
            HashMap<String, String> hmap = new HashMap<String, String>();
            hmap.put("dietWriteDate", dietWriteDate);
            hmap.put("id", id);
            dietList.setList(mapper.selectGup(hmap));
            logger.info("selectGup: {}", dietList.getList());
            
            ArrayList<DietVO> selectDietList = new ArrayList<DietVO>();
            ArrayList<UserFoodVO> selectfoodList = new ArrayList<UserFoodVO>();
            DietVO dvo = new DietVO();
            
            for (int i=0; i<dietList.getList().size(); i++) {
               dvo = dietList.getList().get(i);
            //   logger.info("dietList.getList().get(" + i + ").getGup(): {}", dietList.getList().get(i).getGup());
               
               ArrayList<DietVO> dietGup = mapper.selectDietGup(dvo.getGup());
               ArrayList<UserFoodVO> userfoodGup = mapper.userFoodListGup(dvo.getGup());
               logger.info("dietGup: {}", dietGup);
               logger.info("userfoodGup: {}", userfoodGup);
               selectDietList.addAll(dietGup);
               selectfoodList.addAll(userfoodGup);
            }
            userFoodList.setList(selectfoodList);
            logger.info("selectDietList: {}", selectDietList);
            logger.info("selectfoodList: {}", selectfoodList);
            logger.info("userFoodList 전체: {}", userFoodList);
            model.addAttribute("selectDietList", selectDietList);
            model.addAttribute("userFoodList", userFoodList);
            model.addAttribute("dietWriteDate", dietWriteDate);
            
         }
         return "diet/dietViewAll";
      }
   @RequestMapping("/diet/dietUpdateView")
	public String dietUpdate(HttpServletRequest request, Model model, HttpSession session, DietVO dvo) {
		logger.info("============dietUpdateView 이동하는 메소드 실행");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		String id = (String) session.getAttribute("id");
		logger.info("id ==== {}", id);
		int gup = Integer.parseInt(request.getParameter("gup"));
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		UserFoodList userFoodList = ctx.getBean("userFoodList", UserFoodList.class);
		dvo = mapper.updateDeleteFoodDiet(dvo.getGup());
		System.out.println("1. ============" + dvo);
		System.out.println("2 :  " + dvo.getGup());
		userFoodList.setList(mapper.userFoodListGup(dvo.getGup()));
		System.out.println("3. ============" + userFoodList);
		model.addAttribute("userFoodList", userFoodList);
		model.addAttribute("dvo", dvo);
		return "diet/dietUpdateView";
		}
	
	@RequestMapping("/diet/dietUpdateUserFood")
	public String dietUpdateUserFood(HttpServletRequest request, Model model, UserFoodVO userFoodVO, DietVO dvo) {
		System.out.println("1. ======= dietUpdateUserFood");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		int gup = dvo.getGup();
		dvo = mapper.updateDeleteFoodDiet(dvo.getGup());
		System.out.println("######### " + dvo);
		System.out.println("2 " + userFoodVO);
		mapper.updateUserFood(userFoodVO);
		model.addAttribute("dvo", dvo);
		model.addAttribute("gup" , dvo.getGup());
		return "redirect:dietUpdateView";
	}

	@RequestMapping("/diet/diteDeleteUserFood")
	public String diteDeleteUserFood(HttpServletRequest request, Model model,  HttpSession session, UserFoodVO userFoodVO, DietVO dvo) {
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		System.out.println("이동. ======= diteDeleteUserFood");
		int idx = Integer.parseInt(request.getParameter("idx"));
		int gup = Integer.parseInt(request.getParameter("gup"));
		mapper.deleteUserFood(idx);
		dvo = mapper.updateDeleteFoodDiet(gup);
		model.addAttribute("dvo", dvo);
		model.addAttribute("gup" , dvo.getGup());
		return "redirect:dietUpdateView";
	}
	
	@RequestMapping("diet/dietUpdateOK")
	public String dietUpdateOK(MultipartHttpServletRequest request, Model model, DietVO dietVO) {
		logger.info("============dietUpdateOK 메소드 실행");
		logger.info("웨않뒈눈뒈 아롱나어ㅏ리나ㅓ리ㅏ어라 {}", dietVO);
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		
<<<<<<< HEAD
		String rootUploadDir = "C:\\coding\\Tjoeun\\07_web_project_foodary\\foodary\\src\\main\\webapp\\WEB-INF\\upload\\diet";
=======
		String rootUploadDir = "C:\\k_digital\\Spring_pj_foodary\\workspace\\foodary\\src\\main\\webapp\\WEB-INF\\upload\\diet";
>>>>>>> 19796b5b40dcf0c9c3826d143212d00d2633109a
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		
		MultipartFile multipartFile = request.getFile("fileName");
		String originalFilename = multipartFile.getOriginalFilename().trim();
		logger.info("오리지널파일네임이다아아아악 {}", originalFilename);
		
		if (originalFilename.isEmpty())  {
			if (dietVO.getDietPicture() != null) {
				String picture = dietVO.getDietPicture();
				dietVO.setDietPicture(picture);
				logger.info("수정에 파일 없고 원래 사진 있을 때: {}", dietVO.getDietPicture());
				mapper.updateDiet(dietVO);
			} else {
				String picture = "";
				dietVO.setDietPicture(picture);
				logger.info("수정에 사진 없고 올리지도 않을 때: {}", dietVO.getDietPicture());
				mapper.updateDiet(dietVO);
			}
		} else {
			   String picture = sdf.format(date) + "_" + originalFilename;
			   File dir = new File(rootUploadDir, picture);
			   try {
				   multipartFile.transferTo(dir);
			   } catch (Exception e) { }
			   dietVO.setDietPicture(picture);
			   logger.info("수정에 파일 있을 때: {}", dietVO.getDietPicture());
			   mapper.updateDiet(dietVO);
		   }
		
		int gup = dietVO.getGup();
		model.addAttribute("dvo", dietVO);
		model.addAttribute("gup", gup);
		return "redirect:dietViewUpdate";
	}
	
	@RequestMapping("/diet/dietViewUpdate")
	public String dietViewUpdate(HttpServletRequest request, Model model, DietVO dvo) {
		logger.info("dietViewUpdate 메소드 실행");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		int gup = Integer.parseInt(request.getParameter("gup"));
		dvo = mapper.updateDeleteFoodDiet(gup);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		UserFoodList userFoodList = ctx.getBean("userFoodList", UserFoodList.class);
		userFoodList.setList(mapper.userFoodListGup(dvo.getGup()));
		model.addAttribute("dvo", dvo);
		model.addAttribute("userFoodList", userFoodList);
		return "diet/dietView";
	}
	
	@RequestMapping("diet/dietDelete")
	public String dietDelete(HttpServletRequest request, Model model, DietVO dvo) {
		logger.info("============dietDelete 메소드 실행");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		int idx = Integer.parseInt(request.getParameter("idx"));
		String dietWriteDate = request.getParameter("dietWriteDate");
		int gup = Integer.parseInt(request.getParameter("gup"));
		System.out.println("===================== : " + dietWriteDate);
		String id = request.getParameter("id");
		mapper.deleteDietList(idx);
		mapper.deleteDietUserFood(gup);
		model.addAttribute("id", id);
		model.addAttribute("dietWriteDate", dietWriteDate);
		return "redirect:dietListView";
	}
	
}