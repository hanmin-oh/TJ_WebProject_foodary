package com.foodary.vo;

public class DietVO {
   
   private int idx;
   private String id;
   private String dietMemo;
   private String dietPicture;
   private String dietWriteDate;
   private String dietWriteTime;
   private int gup;
   
   public DietVO() { }

	public DietVO(int idx, String id, String dietMemo, String dietPicture, String dietWriteDate, String dietWriteTime,
			int gup) {
		super();
		this.idx = idx;
		this.id = id;
		this.dietMemo = dietMemo;
		this.dietPicture = dietPicture;
		this.dietWriteDate = dietWriteDate;
		this.dietWriteTime = dietWriteTime;
		this.gup = gup;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDietMemo() {
		return dietMemo;
	}

	public void setDietMemo(String dietMemo) {
		this.dietMemo = dietMemo;
	}

	public String getDietPicture() {
		return dietPicture;
	}

	public void setDietPicture(String dietPicture) {
		this.dietPicture = dietPicture;
	}

	public String getDietWriteDate() {
		return dietWriteDate;
	}

	public void setDietWriteDate(String dietWriteDate) {
		this.dietWriteDate = dietWriteDate;
	}

	public String getDietWriteTime() {
		return dietWriteTime;
	}

	public void setDietWriteTime(String dietWriteTime) {
		this.dietWriteTime = dietWriteTime;
	}

	public int getGup() {
		return gup;
	}

	public void setGup(int gup) {
		this.gup = gup;
	}

	@Override
	public String toString() {
		return "DietVO [idx=" + idx + ", id=" + id + ", dietMemo=" + dietMemo + ", dietPicture=" + dietPicture
				+ ", dietWriteDate=" + dietWriteDate + ", dietWriteTime=" + dietWriteTime + ", gup=" + gup + "]";
	}
	
	
   
}