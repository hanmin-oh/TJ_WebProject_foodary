function unregisterChk() {
  var password = document.getElementById('password').value;
  var passwordChk = document.getElementById('passwordChk').value;

  if (password.trim() === '' || passwordChk.trim() === '') {
    alert('비밀번호를 입력해주세요.');
    return false;
  }

  if (password !== passwordChk) {
    alert('비밀번호가 일치하지 않습니다.');
 	document.getElementById('password').value = '';
    document.getElementById('passwordChk').value = '';
    return false;
  }
  


	var pw = $("#password").val();
	var id = $("#id").val();
    var checkNumber = pw.search(/[0-9]/g);
    var checkEnglish = pw.search(/[a-z]/ig);
 
    if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(pw)) {            
        alert('영문자, 숫자 및 특수문자 조합으로 8자리 이상 사용해야 합니다.');
 		document.getElementById('password').value = '';
    	document.getElementById('passwordChk').value = '';
        return false;
    }else if(checkNumber < 0 || checkEnglish <0){
        alert("숫자와 영문자를 혼용하여야 합니다.");
         document.getElementById('password').value = '';
   		 document.getElementById('passwordChk').value = '';
        return false;
    }
    
    location.href = 'unregisterChk2.jsp';

}


document.getElementById('unregisterChk').addEventListener('click', function(event) {
  event.preventDefault(); 
  if (unregisterChk()) {
    location.href = 'unregisterChk2.jsp';
  }
});