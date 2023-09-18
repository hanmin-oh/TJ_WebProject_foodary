function idCheckFunction() {
	let id = $('#id').val();
	$.ajax({
		type: 'POST',
		url: '../UserRegisterCheck',
		data: {
			"id" : id
		},
		dataType: "text",
		success: res => {
			console.log(res)
			switch (res) {
				case '2':
					$('#messageType').html('에러 메시지');
					$('#messageContent').html('아이디를 입력하고 중복 체크 버튼을 누르세요.');
					$('#errorMessage').html('아이디를 입력하고 중복 체크 버튼을 누르세요.');
					$('#messageCheck').attr('class', 'modal-content panel-warning');
					$('#id').val('');
					break;
				case '1':
					$('#messageType').html('에러 메시지');
					$('#messageContent').html('사용중인 아이디 입니다.');
					$('#errorMessage').html('사용중인 아이디 입니다.');
					$('#messageCheck').attr('class', 'modal-content');
					$('#id').val('');
					break;
				case '0':
					$('#messageType').html('성공 메시지');
					$('#messageContent').html('사용 가능한 아이디입니다.');
					$('#errorMessage').html('사용 가능한 아이디입니다.');
					$('#register').attr('disabled', false);
					$('#messageCheck').attr('class', 'modal-content panel-success');
					break;
			}
			// 회원 저장 모달 창을 띄운다.
			$('#messageModal').modal('show');
		},
		error: e => console.log('요청 실패: ' + e.status)
	});
}

//function userRegister() {
//	let username = $('#username').val();
//	let id = $('#id').val();
//	let password = $('#password').val();
//	let passwordCheck = $('#passwordCheck').val();
//	let email = $('#email').val();
//	let gender = $('input[name=gender]:checked').val();
//	let height = $('#height').val();
//	let age = $('#age').val();
//	let currentWeight = $('#currentWeight').val();
//	let goalWeight = $('#goalWeight').val();
//	let active = $("select[name='active']").val();
//	let state = $('input[name=state]:checked').val();
//
// 	console.log(username, id, password, passwordCheck, email, gender, height, age, currentWeight, goalWeight, active, state);
//	
////	jQuery ajax
//	$.ajax({
//		type: 'POST', 
//		url: '../UserRegister', 
//		data: {
//			username: username,
//			id: id,
//			password: password,
//			passwordCheck: passwordCheck,
//			email: email,
//			gender: gender,
//			height: height,
//			age: age,
//			currentWeight: currentWeight,
//			goalWeight: goalWeight,
//			active: active,
//			state: state
//		},
//		
//		// ajax 요청이 성공하면 실행할 콜백 함수
//		success: function (res) {
//			 console.log("요청 성공: ", res);
//			
//			// 다음 데이터를 입력받기 위해 텍스트 상자의 내용을 지운다.
//			$('#username').val('');
//			$('#id').val('');
//			$('#password').val('');
//			$('#passwordCheck').val('');
//			$('#age').val('');
//			$('#email').val('');
//			$('#height').val('');
//			$('#currentWeight').val('');
//			$('#goalWeight').val('');
//			
//			// 서블릿 응답에 따른 메시지를 출력한다.
//			switch (res) {
//				case '1':
//					$('#messageType').html('에러 메시지');
//					$('#messageContent').html('모든 내용을 입력하세요.');
//					$('#messageCheck').attr('class', 'modal-content panel-warning');
//					break;
//				case '2':
//					$('#messageType').html('에러 메시지');
//					$('#messageContent').html('비밀번호가 일치하지 않습니다.');
//					$('#errorMessage').html('비밀번호가 일치하지 않습니다.');
//					$('#messageCheck').attr('class', 'modal-content panel-warning');
//					break;
//				case '3':
//					$('#messageType').html('성공 메시지');
//					$('#messageContent').html('회원가입에 성공했습니다.');
//					$('#messageCheck').attr('class', 'modal-content panel-success');
//					break;
//				case '4':
//					$('#messageType').html('에러 메시지');
//					$('#messageContent').html('이미 존재하는 회원입니다.');
//					$('#errorMessage').html('이미 존재하는 회원입니다.');
//					$('#messageCheck').attr('class', 'modal-content panel-warning');
//					break;
//			}
//			// 회원 저장 모달 창을 띄운다.
//			$('#messageModal').modal('show');
//		},
//		error: e => console.log('요청 실패: ' + e.status)
//	});
//}

//function userRegisterInfo() {
//	var form = $("#registerform").serialize();
//	$.ajax({
//		type: 'POST', 
//		url: '../UserRegister', 
//		data: form, 
//		
//		// ajax 요청이 성공하면 실행할 콜백 함수
//		success: function (res) {
//			 console.log("요청 성공: ", res);
//			
//			// 다음 데이터를 입력받기 위해 텍스트 상자의 내용을 지운다.
//			$('#username').val('');
//			$('#id').val('');
//			$('#password').val('');
//			$('#passwordCheck').val('');
//			$('#age').val('');
//			$('#email').val('');
//			$('#height').val('');
//			$('#currentWeight').val('');
//			$('#goalWeight').val('');
//			
//			// 서블릿 응답에 따른 메시지를 출력한다.
//			switch (res) {
//				case '1':
//					$('#messageType').html('에러 메시지');
//					$('#messageContent').html('모든 내용을 입력하세요.');
//					$('#messageCheck').attr('class', 'modal-content panel-warning');
//					break;
//				case '2':
//					$('#messageType').html('에러 메시지');
//					$('#messageContent').html('비밀번호가 일치하지 않습니다.');
//					$('#errorMessage').html('비밀번호가 일치하지 않습니다.');
//					$('#messageCheck').attr('class', 'modal-content panel-warning');
//					break;
//				case '3':
//					$('#messageType').html('성공 메시지');
//					$('#messageContent').html('회원가입에 성공했습니다.');
//					$('#messageCheck').attr('class', 'modal-content panel-success');
//					break;
//				case '4':
//					$('#messageType').html('에러 메시지');
//					$('#messageContent').html('이미 존재하는 회원입니다.');
//					$('#errorMessage').html('이미 존재하는 회원입니다.');
//					$('#messageCheck').attr('class', 'modal-content panel-warning');
//					break;
//			}
//			// 회원 저장 모달 창을 띄운다.
//			$('#messageModal').modal('show');
//		},
//		error: e => console.log('요청 실패: ' + e.status)
//	
//	});
//
//	
//}

//	비밀번호가 일치하는가 확인하는 함수
function passwordCheckFunction() {
	let password = $('#password').val();
	let passwordCheck = $('#passwordCheck').val();
	if(password != passwordCheck) {
		$('#passwordCheckMessage').html('비밀번호가 일치하지 않습니다.');

	} else {
		$('#passwordCheckMessage').html('');
	
	}
}


function Noregister() {
	let username = $('#username').val();
	let id = $('#id').val();
	let password = $('#password').val();
	let passwordCheck = $('#passwordCheck').val();
	let email = $('#email').val();
	let gender = $('input[name=gender]:checked').val();
	let height = $('#height').val();
	let age = $('#age').val();
	let currentWeight = $('#currentWeight').val();
	let goalWeight = $('#goalWeight').val();
	let active = $("select[name='active']").val();
	let state = $('input[name=state]:checked').val();
	
	if(username === '') {
		alert('이름을 입력하세요.');
		$('#username').focus();
		return false;
	}
	
	if(id === '') {
		alert('아이디를 입력하세요.');
		$('#id').focus();
		return false;
	}
	
	if(password === '') {
		alert('비밀번호를 입력하세요.');
		$('#password').focus();
		
	} else {
		
		var pw = $("#password").val();
   		var checkNumber = pw.search(/[0-9]/g);
   		var checkEnglish = pw.search(/[a-z]/ig);
 
	    if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(pw)) {
	        alert('영문자, 숫자 및 특수문자 조합으로 8자리 이상 사용해야 합니다.');
	 		document.getElementById('password').value = '';
	    	document.getElementById('passwordCheck').value = '';
	 		document.getElementById('password').focus();
	        return false;
	    } else if (checkNumber < 0 || checkEnglish <0){
	        alert("숫자와 영문자를 혼용하여야 합니다.");
	         document.getElementById('password').value = '';
	   		 document.getElementById('passwordCheck').value = '';
	        return false;
	    }
	}
	
	if(password != passwordCheck) {
		alert('비밀번호가 일치하지 않습니다.')
		$('#username').val('');
		$('#id').val('');
		$('#password').val('');
		$('#passwordCheck').val('');
		$('#age').val('');
		$('#email').val('');
		$('#height').val('');
		$('#currentWeight').val('');
		$('#goalWeight').val('');
		$('#id').focus();
		return false;
	}
	
	if(passwordCheck === '') {
	alert('비밀번호를 확인해주세요.');
	$('#passwordCheck').focus();
	return false;
	}
	
	if(email === '') {
	alert('이메일을 확인해주세요.');
	$('#email').focus();
	return false;
	}
	
	if(gender === '') {
	alert('성별을 선택해주세요.');
	return false;
	}
	
	if(height === '') {
	alert('키를 입력하세요.');
	$('#height').focus();
	return false;
	}
	
	if(age === '') {
	alert('나이를 입력하세요.');
	$('#age').focus();
	return false;
	}
	
	if(currentWeight === '') {
	alert('현재 체중을 입력하세요.');
	$('#currentWeight').focus();
	return false;
	}
	
	if(goalWeight === '') {
	alert('목표 체중을 입력하세요.');
	$('#goalWeight').focus();
	return false;
	}
	
	if(active === '') {
	alert('활동량을 선택하세요.');
	$('#active').focus();
	return false;
	}
	
	if(state === '') {
	alert('Mode를 선택하세요.');
	$('#state').focus();
	return false;
	}
	document.registerform.submit();
}


















