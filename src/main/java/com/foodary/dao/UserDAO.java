package com.foodary.dao;

import java.util.HashMap;
import java.util.List;

import com.foodary.vo.UserRegisterVO;

public interface UserDAO {

	void userInsertRegister(UserRegisterVO userRegisterVO);

	int registerCheck(String id);

	UserRegisterVO userSelectByInfo(HashMap<String, String> hmap);

	UserRegisterVO userSelectByIdx(int idx);

	void userInfoUpdate(HashMap<String, String> hmap);

	void userKcalUpdate(HashMap<String, String> hmap);

	void userPasswordUpdate(HashMap<String, String> hmap);

	void deleteUserInfo(String id);

	List<UserRegisterVO> findId(HashMap<String, String> hmap);

	UserRegisterVO findPassword(HashMap<String, String> hmap);

	void deleteGupZero();
	
	


}
