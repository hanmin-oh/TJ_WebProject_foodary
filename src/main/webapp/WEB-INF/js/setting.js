function setting(idx, mode, title, name, content) {
	let frm = document.commentForm; // 댓글 폼을 저장한다.
//	수정 또는 삭제할 댓글 번호를 넣어준다. 댓글 입력 작업시는 0을 넣어줄다.
	frm.idx.value = idx;
//	commentOK.jsp에서 사용할 댓글 작업 모드를 넣어준다. 1 => 저장, 2 => 수정, 3 => 삭제
	frm.mode.value = mode;
//	submit 버튼에 표시할 텍스트를 넣어준다.
	frm.commentBtn.value = title;
//	수정 또는 삭제할 댓글 작성자 이름을 댓글 폼의 name 속성이 name인 텍스트 상자에 넣어준다.
	frm.name.value = name;
	
	document.getElementById("commentBtnText").textContent = title;
	
	while (content.indexOf('<br/>') != -1) {
		content = content.replace('<br/>', '\r\n');
	}
	frm.content.value = content;
}

function deleteOK() {
    var confirmation = confirm("해당 글을 삭제하시겠습니까?\n(삭제 후에는 복구가 불가능 합니다.)");
    if (confirmation) {
    	location.href = "deleteOK?idx=" + $('#idx').val() +
		"&currentPage=" + $('#currentPage').val()
    }
}






















