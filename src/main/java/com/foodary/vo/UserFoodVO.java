package com.foodary.vo;

public class UserFoodVO {
	private int idx;
	private int gup;
	private String foodName;
	private String id;
	private float kcal;
	private float carbs;
	private float protein;
	private float fat;
	
	public UserFoodVO() { }

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getGup() {
		return gup;
	}

	public void setGup(int gup) {
		this.gup = gup;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public float getKcal() {
		return kcal;
	}

	public void setKcal(float kcal) {
		this.kcal = kcal;
	}

	public float getCarbs() {
		return carbs;
	}

	public void setCarbs(float carbs) {
		this.carbs = carbs;
	}

	public float getProtein() {
		return protein;
	}

	public void setProtein(float protein) {
		this.protein = protein;
	}

	public float getFat() {
		return fat;
	}

	public void setFat(float fat) {
		this.fat = fat;
	}

	@Override
	public String toString() {
		return "UserFoodVO [idx=" + idx + ", gup=" + gup + ", foodName=" + foodName + ", id=" + id + ", kcal=" + kcal
				+ ", carbs=" + carbs + ", protein=" + protein + ", fat=" + fat + "]";
	}
}
