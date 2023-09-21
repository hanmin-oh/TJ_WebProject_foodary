package com.foodary.vo;

import java.util.ArrayList;

public class ShareDietList {
	
	private ArrayList<ShareDietVO> list = new ArrayList();

	public ArrayList<ShareDietVO> getList() {
		return list;
	}

	public void setList(ArrayList<ShareDietVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "ShareDietList [list=" + list + "]";
	}
	
	
}
