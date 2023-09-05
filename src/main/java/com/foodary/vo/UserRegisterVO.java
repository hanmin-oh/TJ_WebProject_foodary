package com.foodary.vo;

public class UserRegisterVO {
	
	private int idx;
	private String username;
	private String id;
	private String password;
	private String email;
	private String gender;
	private int height;
	private String age;
	private int currentWeight;
	private int goalWeight;
	private String active;
	private String state;
	
	public UserRegisterVO() {}

	public UserRegisterVO(int idx, String username, String id, String password, String email, String gender, int height,
			String age, int currentWeight, int goalWeight, String active, String state) {
		super();
		this.idx = idx;
		this.username = username;
		this.id = id;
		this.password = password;
		this.email = email;
		this.gender = gender;
		this.height = height;
		this.age = age;
		this.currentWeight = currentWeight;
		this.goalWeight = goalWeight;
		this.active = active;
		this.state = state;
	}

	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public int getCurrentWeight() {
		return currentWeight;
	}
	public void setCurrentWeight(int currentWeight) {
		this.currentWeight = currentWeight;
	}
	public int getGoalWeight() {
		return goalWeight;
	}
	public void setGoalWeight(int goalWeight) {
		this.goalWeight = goalWeight;
	}
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}

	
	@Override
	public String toString() {
		return "UserRegisterVO [idx=" + idx + ", username=" + username + ", id=" + id + ", password=" + password
				+ ", email=" + email + ", gender=" + gender + ", height=" + height + ", age=" + age + ", currentWeight="
				+ currentWeight + ", goalWeight=" + goalWeight + ", active=" + active + ", state=" + state + "]";
	}

	
	
	
	
	
}
