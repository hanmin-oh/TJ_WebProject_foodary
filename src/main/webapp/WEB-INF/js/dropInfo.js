//	회원 탈퇴 완료 띄우기
function dropInfo1() {
  let password = document.getElementById("password").value;
  let passwordChk = document.getElementById("passwordChk").value;
  let id = document.getElementById("id").value;
  
  if (password === passwordChk) {
    alert("회원탈퇴가 완료되었습니다.");
    location.href='deleteUserInfo?id=' + id;
  } else if (passwordChk === '') {
	alert("비밀번호를 입력해 주세요.");
  } else {
	alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
  }
}


