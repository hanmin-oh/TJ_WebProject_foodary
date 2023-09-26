function insertCheck() {
	if ($('#content').val().trim() === "") {
		alert('댓글을 입력해주세요')
		$('#content').val('');
		$('#content').focus();
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