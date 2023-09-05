package com.foodary.vo;

import java.util.ArrayList;

public class UserFoodList {
	
	private ArrayList<UserFoodVO> list = new ArrayList();
	
	public UserFoodList() { }
	
	public ArrayList<UserFoodVO> getList() {
		return list;
	}

	public void setList(ArrayList<UserFoodVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "UserFoodList [list=" + list + "]";
	}
}
