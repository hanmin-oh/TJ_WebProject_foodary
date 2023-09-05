function photoView(event) {
   $('#output').attr('src', URL.createObjectURL(event.target.files[0]));
}

function insertCheck() {
	if ($('#name').val().trim() === "") {
		alert('로그인 정보가 없습니다')
		return false;
	}
	else if ($('#subject').val().trim() === "") {
		alert('제목을 입력해주세요')
		$('#subject').val('');
		$('#subject').focus();
		return false;
	}
	else if ($('#content').val().trim() === "") {
		alert('내용을 입력해주세요')
		$('#content').val('');
		$('#content').focus();
		return false;
	}
	else {
		return true;
	}
	
}