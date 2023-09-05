package com.foodary.vo;

public class FoodVO {
	
	private int idx;
	private String foodName;
	private float kcal;
	private float carbs;
	private float protein;
	private float fat;
	
	public FoodVO() {}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
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
		return "FoodVO [idx=" + idx + ", foodName=" + foodName + ", kcal=" + kcal + ", carbs=" + carbs + ", protein="
				+ protein + ", fat=" + fat + "]";
	}
}
