package com.foodary.foodary;

public class Param {

    private int startNo;
    private int endNo;
    private String foodName;
    
	public int getStartNo() {
		return startNo;
	}
	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}
	public String getFoodName() {
		return foodName;
	}
	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}
	@Override
	public String toString() {
		return "Param [startNo=" + startNo + ", endNo=" + endNo + ", foodName=" + foodName + "]";
	}
    
    
    
    

}
