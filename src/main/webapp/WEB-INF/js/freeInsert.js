function openPopup() {
	  // 현재 날짜 객체 생성
	  const currentDate = new Date();
	  var inputElement  = document.getElementById("id");
	  const id = inputElement.value;
	  console.log(id);
	  // 날짜를 원하는 형식으로 포맷팅 (예: YYYY-MM-DD)
	  const formattedDate = currentDate.toISOString().split('T')[0];

    // 새 창을 열고 URL로 이동
   url = 'dietListView?dietWriteDate=' +  formattedDate + '&id=' + id;
   // 모니터의 가로 중앙 위치 계산
    var left = (screen.width - 800) / 2; // 800은 팝업 창의 가로 크기
    // 모니터의 세로 중앙 위치 계산
    var top = (screen.height - 600) / 2; // 600은 팝업 창의 세로 크기
 // 새 창을 열고 URL로 이동하며 위치를 중앙으로 설정
    window.open(url, '_blank', 'width=1200,height=600,left=' + left + ',top=' + top);
}

function refreshParent() {
    // 부모 창 새로고침
    window.location.reload();
}




