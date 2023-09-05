//	마이페이지 회원정보에서 정보 수정 누르면 텍스트 활성화 시켜주고 수정완료 누르면 비활성화 되게.
function updateMypage() {
	
		var updateBtn = document.getElementById("updateBtn");
		let name = document.getElementById("name");
		document.getElementById("name").focus();
		let id = document.getElementById("id");
		let password = document.getElementById("password");
		let email = document.getElementById("email");
		
		if (updateBtn.value === "정보 수정") {
			name.disabled = false;
			id.disabled = false;
			password.disabled = false;
			email.disabled = false;
			
			updateBtn.value = "수정 완료";
		} else {
			name.readOnly = true;
			id.readOnly = true;
			password.readOnly = true;
			email.readOnly = true;
			
			updateBtn.value = "정보 수정";
			
		}
		
}

function passwordUpdate() {
  let password = document.getElementById("password");
  password.disabled = false;
}	
