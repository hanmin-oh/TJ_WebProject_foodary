package com.foodary.vo;

import java.util.Date;

//	댓글 1건을 기억하는 클래스
public class FreeboardCommentVO {

	private int idx;
	private int gup; // 메인글의 글번호 => 어떤 메인글의 댓글인가?
	private String name;
	private String content;
	private Date writeDate;
	private String id;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	@Override
	public String toString() {
		return "FreeboardCommentVO [idx=" + idx + ", gup=" + gup + ", name=" + name + ", content=" + content
				+ ", writeDate=" + writeDate + ", id=" + id + "]";
	}
	
}
