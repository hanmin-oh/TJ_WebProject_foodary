package com.foodary.foodary;

import java.util.ArrayList;
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

import com.foodary.dao.DietDAO;
import com.foodary.vo.DietList;
import com.foodary.vo.DietVO;
import com.foodary.vo.FoodList;
import com.foodary.vo.FoodVO;
import com.foodary.vo.UserFoodList;
import com.foodary.vo.UserFoodVO;

@Controller
public class DietController {

	private static final Logger logger = LoggerFactory.getLogger(DietController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/diet/dietInsertView")
	public String dietInsertView(HttpServletRequest request, Model model, UserFoodVO userFoodVO) {
		logger.info("dietInsertView() 메소드 실행");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		HttpSession session = request.getSession();
		String[] foodNames;
		String[] kcals;
		String[] carbss;
		String[] proteins;
		String[] fats;
		foodNames = request.getParameterValues("foodName");
		kcals = request.getParameterValues("kcal");
		carbss = request.getParameterValues("carbs");
		proteins = request.getParameterValues("protein");
		fats = request.getParameterValues("fat");

		if (foodNames == null) {
			foodNames = new String[] {};
			kcals = new String[] {};
			carbss = new String[] {};
			proteins = new String[] {};
			fats = new String[] {};
		} else {
			session.setAttribute("foodNames", foodNames);
			session.setAttribute("kcals", kcals);
			session.setAttribute("carbss", carbss);
			session.setAttribute("proteins", proteins);
			session.setAttribute("fats", fats);
		}

		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		UserFoodList userFoodList = ctx.getBean("userFoodList", UserFoodList.class);
		userFoodList.setList(mapper.userFoodList(0));

		session.setAttribute("userFoodList", userFoodList);
		return "diet/dietInsertView";
	}

	@RequestMapping("/diet/foodList")
	public String foodListView(HttpServletRequest request, Model model) {
		logger.info("foodListView 메소드 실행");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		int currentPage = 1;
		int pageSize = 10;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {
		}

		String foodName = request.getParameter("foodName");

		int totalCount = mapper.foodSelectCount();

		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		FoodList foodList = ctx.getBean("foodList", FoodList.class);
		foodList.initFoodList(pageSize, totalCount, currentPage);

		if (foodName == null || foodName.trim().length() == 0) {
			HashMap<String, Integer> hmap = new HashMap<String, Integer>();
			hmap.put("startNo", foodList.getStartNo());
			hmap.put("endNo", foodList.getEndNo());
			foodList.setList(mapper.foodSelectList(hmap));
		} else {
			Param param = new Param();
			param.setStartNo(foodList.getStartNo());
			param.setEndNo(foodList.getEndNo());
			param.setFoodName(foodName);
			System.out.println(param.getFoodName());
			foodList.setList(mapper.foodSearchList(param));
		}

		model.addAttribute("foodList", foodList);
		model.addAttribute("currentPage", currentPage);

		return "diet/foodListView";
	}

	@RequestMapping("/diet/userFoodInsert")
	public String userFoodInsert(HttpServletRequest request, Model model/* , UserFoodVO uvo, */
			/* ArrayList<UserFoodVO> userfoodList, ArrayList<FoodVO> foodList*/) {
		logger.info("userFoodInsert 메소드 실행");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
//		logger.info("==========={}", foodList);
//		logger.info("==========={}", userfoodList);
//		logger.info("==========={}", uvo);
		HttpSession session = request.getSession();
		String[] foodNames1;
		String[] foodNames2;
		String[] kcals;
		String[] carbes;
		String[] proteins;
		String[] fats;
		foodNames1 = request.getParameterValues("param");
		foodNames2 = request.getParameterValues("foodNames");
		kcals = request.getParameterValues("kcals");
		carbes = request.getParameterValues("carbses");
		proteins = request.getParameterValues("proteins");
		fats = request.getParameterValues("fats");
		System.out.println(foodNames1);
		System.out.println(foodNames2);
//		mapper.userFoodInsert(foodList);

		return "redirect:dietInsertView";
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
	public String dietInsert(HttpServletRequest request, Model model, DietVO dietVO, UserFoodList userFoodList) {
		logger.info("========== dietList 메소드 실행 ===========");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		logger.info("{}", dietVO);
		logger.info("{}", userFoodList);
		
		mapper.insertDiet(dietVO);
		
		DietVO getIdx = mapper.getIdx(0);
		
		int idx = getIdx.getIdx();
		
		mapper.setDietGup(idx);
		mapper.setUserFoodGup(idx);
		
		HttpSession session = request.getSession();
		session.setAttribute("foodNames", null);
		model.addAttribute("gup", idx);
		
		return "redirect:dietListView";
	}

	@RequestMapping("/diet/dietListView")
	public String dietListView(HttpServletRequest request, Model model) {
		logger.info("dietListView 메소드 실행");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		String dietWriteDate = request.getParameter("dietWriteDate");

		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		DietList dietList = ctx.getBean("dietList", DietList.class);
		dietList.setList(mapper.selectDietList(dietWriteDate));
		UserFoodList userFoodList = ctx.getBean("userFoodList", UserFoodList.class);

		logger.info("{}", dietList.getList());
		for (int i = 0; i < dietList.getList().size(); i++) {
			DietVO dietVO = dietList.getList().get(i);

		}

		logger.info("{}", userFoodList);
		model.addAttribute("dietList", dietList);
		model.addAttribute("userFoodList", userFoodList);
		model.addAttribute("dietWriteDate", dietWriteDate);

		return "diet/dietListView";
	}

	@RequestMapping("/diet/dietView")
	public String dietView(HttpServletRequest request, Model model) {
		logger.info("========dietListView 메소드 실행");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		String dietWriteDate = request.getParameter("dietWriteDate");
		String dietWriteTime = request.getParameter("dietWriteTime");

		HashMap<String, String> hmap = new HashMap<String, String>();
		hmap.put("dietWriteDate", dietWriteDate);
		hmap.put("dietWriteTime", dietWriteTime);
		DietVO dvo = mapper.selectDiet(hmap);

		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		UserFoodList userFoodList = ctx.getBean("userFoodList", UserFoodList.class);


		model.addAttribute("dvo", dvo);
		model.addAttribute("userFoodList", userFoodList);

		return "diet/dietView";
	}

	@RequestMapping("/diet/dietUpdate")
	public String dietUpdate(HttpServletRequest request, Model model, HttpSession session, DietVO dietVO,
			ArrayList<UserFoodVO> userFoodList, UserFoodVO uvo) {
		logger.info("========dietUpdate 메소드 실행");
		logger.info("{}", dietVO);
		logger.info("{}", userFoodList);
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		System.out.println(uvo);
		System.out.println(userFoodList);
		String userFoodDate = request.getParameter("userFoodDate");
		String userFoodTime = request.getParameter("userFoodTime");
		request.setAttribute("userFoodDate", userFoodDate);
		request.setAttribute("userFoodTime", userFoodTime);
//		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
//		UserFoodList userFoodList = ctx.getBean("userFoodList", UserFoodList.class);
//		userFoodList.setList(mapper.userFoodList(0));
		model.addAttribute("dietVO", dietVO);
		model.addAttribute("userFoodList", userFoodList);
		session.setAttribute("userFoodList", userFoodList);
		return "diet/dietUpdate";
	}
	

	@RequestMapping("/diet/deleteUpdateUserFood")
	public String deleteUpdateUserFood(HttpServletRequest request, Model model, UserFoodVO userFoodVO) {
		logger.info("updateUserFood 메소드 실행");
		DietDAO mapper = sqlSession.getMapper(DietDAO.class);
		logger.info("{}", userFoodVO);
		
		mapper.deleteUserFood(userFoodVO.getIdx());
		
		return "redirect:dietUpdate";
	}

}