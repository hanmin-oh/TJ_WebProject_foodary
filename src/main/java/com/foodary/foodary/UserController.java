package com.foodary.foodary;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foodary.dao.UserDAO;
import com.foodary.vo.UserRegisterVO;

@Controller
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private SqlSession sqlSession; 
		
	   @RequestMapping("/user/register")
	   public String register() {
	      // logger.info("register() 메소드 실행");
	      return "user/register";
	   }

	   @RequestMapping("/user/loginForm")
	   public String loginForm(HttpServletRequest request, Model model) {
			if (request.getParameter("message") != null) {
					model.addAttribute("message", request.getParameter("message"));
				}
		   return "user/loginForm";
	   }
	   
	   @RequestMapping("/user/findId")
	   public String findId() {
		   logger.info("findId() 메소드 실행");
		   return "user/findId";
	   }
	   
	    @RequestMapping("/user/findIdOK")
	    public String findIdOK(HttpServletRequest request, Model model) {
	        String username = request.getParameter("username");
	        String email = request.getParameter("email");
	        
	        UserDAO mapper = sqlSession.getMapper(UserDAO.class);
	        HashMap<String, String> hmap = new HashMap<String, String>();
	        hmap.put("username", username);
	        hmap.put("email", email);
	        
	        List<UserRegisterVO> userRegisterVO = mapper.findId(hmap);
	        List<String> idList = new ArrayList<String>();
	        for (UserRegisterVO user : userRegisterVO) {
	            idList.add(user.getId());
	        }
	        logger.info("{}", idList);
	        model.addAttribute("idList", idList);
	        return "user/findIdAfter";
	    }

	   @RequestMapping("/user/findPassword")
	   public String findPassword() {
		   logger.info("findId() 메소드 실행");
		   return "user/findPassword";
	   }
	   
	    @RequestMapping("/user/findPasswordOK")
	    public String findPasswordOK(HttpServletRequest request, Model model) {
	        logger.info("findPasswordOK() 실행");
	        UserDAO mapper = sqlSession.getMapper(UserDAO.class);
	        String username = request.getParameter("username");
	        String id = request.getParameter("id");
	        HashMap<String, String> hmap = new HashMap<String, String>();
	        hmap.put("username", username);
	        hmap.put("id", id);
	        UserRegisterVO userRegisterVO = mapper.findPassword(hmap);

	        if (userRegisterVO == null) {
	            model.addAttribute("msg", "아이디 또는 이름을 확인해주세요.");
	        } else {
	            model.addAttribute("password", userRegisterVO.getPassword());
	        }

	        logger.info("{}", userRegisterVO);
	        return "user/findPasswordAfter";
	    }
	   
	   @RequestMapping(value = "/UserRegisterCheck", method = RequestMethod.POST)
	     @ResponseBody
	      public String memberServlet(HttpServletRequest request, Model model, UserRegisterVO userRegisterVO) {
	         logger.info("MemberController의 memberServlet()");
	         
	         UserDAO mapper = sqlSession.getMapper(UserDAO.class);
	         logger.info("{} line125", userRegisterVO);
	         String userID = request.getParameter("id").trim();
	         int result = 0;
	         if (userID.equals("")) {
	        	 result = 2;
	         } else {
	        	 result = mapper.registerCheck(userRegisterVO.getId());
	         }
	         logger.info("{} line129", result);
	         
	         return result + "";
	      }
	   
	    @RequestMapping("/user/registerOK")
	    public String registerOK(HttpServletRequest request, Model model, UserRegisterVO userRegisterVO) {
	       logger.info("registerOK() 실행");
	       UserDAO mapper = sqlSession.getMapper(UserDAO.class);
	       logger.info("userRegisterVO: {}", userRegisterVO);
	       mapper.userInsertRegister(userRegisterVO);
	       return "redirect:../";
	    }
	    
	    @RequestMapping("/user/loginOK")
	    public String loginOK(HttpServletRequest request, Model model, String id, String password) {
	       // logger.info("loginOK() 실행");
	       UserDAO mapper = sqlSession.getMapper(UserDAO.class);
	        if (id == null || id.isEmpty()) {
	            model.addAttribute("message", "아이디를 입력해주세요.");
	            return "redirect:loginForm";
	        } else if (password == null || password.isEmpty()) {
	            model.addAttribute("message", "비밀번호를 입력해주세요.");
	            return "redirect:loginForm";
	        }
			HashMap<String, String> hmap = new HashMap<String, String>();
		    hmap.put("id", id);
		    hmap.put("password", password);
		    UserRegisterVO userRegisterVO = mapper.userSelectByInfo(hmap);
		    
		    if (userRegisterVO != null) {
		    	// logger.info("{}", userRegisterVO);
		    	HttpSession session = request.getSession();
		    	session.setAttribute("rvo", userRegisterVO);
		    	
		    	session.setAttribute("id", userRegisterVO.getId());
		    	return "redirect:../main/foodaryMainPageAfter";
		    } else {
                model.addAttribute("message", "일치하는 회원정보가 없습니다.");
                return "redirect:loginForm";
		    }
		    
	    }

	    @RequestMapping("/user/myPageOK")
	    public String myPageOK(HttpServletRequest request, Model model, UserRegisterVO userRegisterVO) {
	    	UserDAO mapper = sqlSession.getMapper(UserDAO.class);
	        mapper.deleteGupZero();
	    	return "user/myPageView";
	    }
	    
	    @RequestMapping("user/userInfoUpdate")
	    public String myPageInfoUpdate(HttpServletRequest request, Model model, String username, String id, String email, int idx) {
	    	// logger.info("myPageInfoUpdate() 실행");
	        UserDAO mapper = sqlSession.getMapper(UserDAO.class);
	        HashMap<String, String> hmap = new HashMap<String, String>();
	        hmap.put("username", username);
	        hmap.put("id", id);
	        hmap.put("email", email);
	        mapper.userInfoUpdate(hmap);
	        UserRegisterVO userRegisterVO = mapper.userSelectByIdx(idx);
	        HttpSession session = request.getSession();
	    	session.setAttribute("rvo", userRegisterVO);
	        model.addAttribute("msg", userRegisterVO.getUsername() + " 님 회원 정보 수정 완료!");
	        return "user/myPageView";
	     }
	    
	    @RequestMapping("user/userKcalUpdate")
	    public String myPageUpdateEnd(HttpServletRequest request, Model model,
	          String height, String currentWeight, String goalWeight,
	          String age, String mode, String active, String id, int idx) {
	       // logger.info("myPageUpdateEnd() 실행");
	       UserDAO mapper = sqlSession.getMapper(UserDAO.class);
	       HashMap<String, String> hmap = new HashMap<String, String>();
	       hmap.put("height", height);
	       hmap.put("currentWeight", currentWeight);
	       hmap.put("goalWeight", goalWeight);
	       hmap.put("age", age);
	       hmap.put("state", mode);
	       hmap.put("active", active);
	       hmap.put("id", id);
	       // logger.info("{}", hmap);
	       mapper.userKcalUpdate(hmap);
	       UserRegisterVO userRegisterVO = mapper.userSelectByIdx(idx);
	       HttpSession session = request.getSession();
	       session.setAttribute("rvo", userRegisterVO);
	       model.addAttribute("msg", userRegisterVO.getUsername() + " 님 회원 정보 수정 완료!");
	       return "user/myPageView";
	    }
	    
	    @RequestMapping("user/passwordUpdate")
	    public String passwordUpdate(HttpServletRequest request, Model model, UserRegisterVO userRegisterVO) {
	    	// logger.info("passwordUpdate() 실행");
	       return "user/passwordUpdate";
	    }


	    @RequestMapping("user/userPasswordUpdate")
	    public String userPasswordUpdate(HttpServletRequest request, Model model, UserRegisterVO userRegisterVO) {
	       // logger.info("userPasswordUpdate() 실행");
	       UserDAO mapper = sqlSession.getMapper(UserDAO.class);
	       HashMap<String, String> hmap = new HashMap<String, String>();
	       String id = userRegisterVO.getId();
	       String password = userRegisterVO.getPassword();
	       String username = userRegisterVO.getUsername();
	       String currentpassword = request.getParameter("currentpassword");
	       String newpassword = request.getParameter("newpassword");
	       String newpasswordcheck = request.getParameter("newpasswordcheck");
	        
	        hmap.put("username", username);
	        hmap.put("id", id);
	        hmap.put("currentpassword", currentpassword);
	        hmap.put("newpassword", newpassword);
	        logger.info("{}", hmap);
	        logger.info("{}", password);
	        if (currentpassword.trim().equals(password.trim())) {
	            if (newpassword != null && newpasswordcheck != null && newpassword.equals(newpasswordcheck)) {
	               mapper.userPasswordUpdate(hmap);
	               String msg = "	<script type=\"text/javascript\">" + 
	        				"		alert('비밀번호 변경 완료!')" + 
	        				"	</script>";
	                model.addAttribute("msg", msg);
	                return "redirect:/";
	            } else {
	                model.addAttribute("msg", "새 비밀번호가 일치하지 않습니다.");
	                return "redirect:../main/foodaryMainPageAfter";
	            }
	        } else {
	            model.addAttribute("msg", "비밀번호가 올바르지 않습니다.");
	            return "redirect:../main/foodaryMainPageAfter";
	        }
	    }
	    
	    @RequestMapping("user/unregister")
	    public String unregister(HttpServletRequest request, Model model, UserRegisterVO userRegisterVO) {
	    	// logger.info("unregister() 실행");
	    	return "user/unregister";
	    }

	    @RequestMapping("user/deleteUserInfo")
	    public String deleteUserInfo(HttpServletRequest request, Model model, UserRegisterVO userRegisterVO) {
	    	logger.info("deleteUserInfo() 실행");
	    	UserDAO mapper = sqlSession.getMapper(UserDAO.class);
	    	String id = userRegisterVO.getId();
	    	mapper.deleteUserInfo(id); 
	    	return "redirect:/";
	    }
	    
}





