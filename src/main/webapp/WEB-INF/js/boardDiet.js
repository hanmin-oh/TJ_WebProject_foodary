//function transferDiet() {
//	 var gupEl  = document.getElementById("gup");
//	 var idEl  = document.getElementById("id");
//	 const gup = gupEl.value;
//	 const id = idEl.value;
//	  var url = './boardDiet?gup=' + gup + '&id=' + id;
//	  console.log(gup, id)
////  부모 창으로 데이터 전송 후 팝업 창 닫기
//	  window.location.href = url;
//    window.close(); // 팝업 창 닫기
//    window.opener.refreshParent();
//  }

function transferDiet() {
  var gupEl = document.getElementById("gup");
  var idEl = document.getElementById("id");
  var dietWriteDateEl = document.getElementById("dietWriteDate");
  const gup = gupEl.value;
  const id = idEl.value;
  const dietWriteDate = dietWriteDateEl.value;
  console.log(gup, id, dietWriteDate);

  // XMLHttpRequest 객체를 생성합니다.
  var xhr = new XMLHttpRequest();

  // 요청을 보낼 URL을 지정합니다.
<<<<<<< HEAD
  var url = './boardDiet?gup=' + gup + '&id=' + id + '&dietWriteDate=' + encodeURIComponent(dietWriteDate);
//  encodeURIComponent(protein)
=======
//  var url = './boardDiet?gup=' + gup + '&id=' + id;
  var url = './insert?gup=' + gup + '&id=' + id;
>>>>>>> 370244fb95e8ea81ec8105779759cadf1c02ca29

  // GET 요청을 보냅니다. 필요에 따라 POST 요청으로 변경할 수 있습니다.
  xhr.open("GET", url, true);

  // 요청 완료 후 실행할 콜백 함수를 정의합니다.
  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
      // 요청이 성공적으로 완료되었을 때 실행할 코드를 작성하세요.
      console.log("데이터 전송 성공");
      // 부모 창을 새로 고침하거나 필요한 작업을 수행하세요.
      window.opener.refreshParent();

      // 팝업 창 닫기
      window.close();
    } else if (xhr.readyState === 4 && xhr.status !== 200) {
      // 요청이 실패했을 때 실행할 코드를 작성하세요.
      console.error("데이터 전송 실패");
    }
  };

  // 요청을 보냅니다.
  xhr.send();
}
