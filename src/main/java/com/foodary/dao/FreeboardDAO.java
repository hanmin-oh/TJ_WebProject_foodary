package com.foodary.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.foodary.vo.FreeboardCommentList;
import com.foodary.vo.FreeboardCommentVO;
import com.foodary.vo.FreeboardVO;

public interface FreeboardDAO {

	int freeboardSelectCount();

	ArrayList<FreeboardVO> freeboardSelectList(HashMap<String, Integer> hmap);

	ArrayList<FreeboardVO> freeboardSelectNotice();

	void freeboardInsert(FreeboardVO freeboardVO);

	int commentCount(int idx);

	void freeboardIncrement(int idx);

	FreeboardVO freeboardSelectByIdx(int idx);

	void freeboardDelete(int idx);

	void freeboardUpdate(FreeboardVO freeboardVO);

	void insertComment(FreeboardCommentVO freeboardCommentVO);

	void updateComment(FreeboardCommentVO freeboardCommentVO);

	void deleteComment(FreeboardCommentVO freeboardCommentVO);

	ArrayList<FreeboardCommentVO> selectCommentList(int idx);




	


}
