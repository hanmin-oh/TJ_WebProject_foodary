package com.foodary.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.foodary.foodary.Param;
import com.foodary.vo.DietVO;
import com.foodary.vo.FoodVO;
import com.foodary.vo.ShareDietVO;
import com.foodary.vo.UserFoodVO;

public interface DietDAO {

	int foodSelectCount();

	ArrayList<FoodVO> foodSelectList(HashMap<String, Integer> hmap);

	ArrayList<FoodVO> foodSearchList(Param param);

	void userFoodInsert(UserFoodVO userFoodVO);

	void updateUserFood(UserFoodVO userFoodVO);

	void deleteUserFood(int idx);
	
	ArrayList<UserFoodVO> userFoodList();

	void insertDiet(DietVO dietVO);

	DietVO getIdx();

	void setDietGup(int idx);

	void setUserFoodGup(int idx);

	ArrayList<DietVO> selectDietList(HashMap<String, String> hmap);

	ArrayList<UserFoodVO> userFoodListGup(int gup);

	DietVO selectDiet(HashMap<String, String> hmap);

	ArrayList<UserFoodVO> updateDietUserFood(int gup);

	void updateDiet(DietVO dvo);

	void diteDeleteUserFood(int idx);

	void dietUpdateUserFood(UserFoodVO userFoodVO);

	DietVO updateDeleteFoodDiet(int gup);

	void deleteDietList(int idx);

	void deleteDietUserFood(int gup);
	
   ArrayList<DietVO> selectGup(HashMap<String, String> hmap);

   ArrayList<DietVO> selectDietGup(int gup);

   ArrayList<DietVO> dateGetDiet(String dietWriteDate);

   ArrayList<UserFoodVO> getFoodListGup(int[] gupList);

   void insertShare(ShareDietVO shareDietVO);
//   void insertShare(HashMap<String, Object> paramMap);






	

}
