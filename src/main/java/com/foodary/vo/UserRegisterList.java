package com.foodary.vo;

import java.util.ArrayList;

public class UserRegisterList {

	private ArrayList<UserRegisterVO> list = new ArrayList();
	
	public UserRegisterList() { }

	public UserRegisterList(UserRegisterVO vo) {}
	
	public UserRegisterList(ArrayList<UserRegisterVO> list) {
		this.list = list;
	}


	public ArrayList<UserRegisterVO> getList() {
		return list;
	}

	public void setList(ArrayList<UserRegisterVO> list) {
		this.list = list;
	}

	
	@Override
	public String toString() {
		return "UserRegisterList [list=" + list + "]";
	}
	
}
