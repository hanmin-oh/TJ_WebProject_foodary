package com.foodary.vo;

// 한 날짜에 해당하는 시간과 음식에 관한 변수들을 기억하는 클래스
import java.util.ArrayList;

import com.foodary.vo.DietVO;

public class DietList {
	
	private ArrayList<DietVO> list = new ArrayList();
	
	public DietList() { }
	
	public ArrayList<DietVO> getList() {
		return list;
	}

	public void setList(ArrayList<DietVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "DietList [list=" + list + "]";
	}
}
