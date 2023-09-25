function insertCheck() {
	if ($('#ccontent').val().trim() === "") {
		alert('댓글을 입력해주세요')
		$('#ccontent').val('');
		$('#ccontent').focus();
		return false;
	}
	else if ($('#name').val().trim() === "") {
		alert('로그인 정보가 없습니다')
		return false;
	}
	else {
		return true;
	}
	
}