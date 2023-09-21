package com.foodary.vo;

	public class ShareDietVO {
	    private int idx;
	    private String foodName;
	    private float kcal;
	    private float carbs;
	    private float protein;
	    private float fat;
	    private String dietDate;
	    private String dietTime;
	    private int freeboardIdx; // Freeboard 테이블의 IDX와 연결되는 FK 필드
	    
	
	    // Getter와 Setter 메서드 생략
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
		public String getDietDate() {
			return dietDate;
		}
		public void setDietDate(String dietDate) {
			this.dietDate = dietDate;
		}
		public String getDietTime() {
			return dietTime;
		}
		public void setDietTime(String dietTime) {
			this.dietTime = dietTime;
		}
		public int getFreeboardIdx() {
			return freeboardIdx;
		}
		public void setFreeboardIdx(int freeboardIdx) {
			this.freeboardIdx = freeboardIdx;
		}
		@Override
		public String toString() {
			return "ShareDietVO [idx=" + idx + ", foodName=" + foodName + ", kcal=" + kcal + ", carbs=" + carbs
					+ ", protein=" + protein + ", fat=" + fat + ", dietDate=" + dietDate + ", dietTime=" + dietTime
					+ ", freeboardIdx=" + freeboardIdx + "]";
		}
		
		
	    

}
