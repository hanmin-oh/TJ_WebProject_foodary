function addData() {
	console.log("addData 메소드 실행");
	var selectedRadios = document.querySelectorAll('input[name="foodName"]:checked');
	var id = document.getElementsByName("id")[0].value;
  if (selectedRadios.length > 0) {
    let food = [];

    var foodNames = [];
    var kcals = [];
    var carbss = [];
    var proteins = [];
    var fats = [];
    selectedRadios.forEach(function(selectedRadio) {
      var parentRow = selectedRadio.closest('tr');

      var foodName = parentRow.querySelector('td:nth-child(2)').innerHTML.trim();
      var kcal = parentRow.querySelector('td:nth-child(3)').innerHTML.trim();
      var carbs = parentRow.querySelector('td:nth-child(4)').innerHTML.trim();
      var protein = parentRow.querySelector('td:nth-child(5)').innerHTML.trim();
      var fat = parentRow.querySelector('td:nth-child(6)').innerHTML.trim();
      
      foodNames.push(foodName);
      kcals.push(kcal);
      carbss.push(carbs);
       proteins.push(protein);
        fats.push(fat);
    });
      var foods = {}
    var foodList = [];
    console.log('foodList type : ' , typeof foodList);
    console.log('foodNames type : ' , typeof foodNames);
    console.log('kcals type : ' , typeof kcals);
    console.log('carbss type : ' , typeof carbss);
    console.log('fats type : ' , typeof fats);
    for(var j = 0 ; j < foods.length ; j++) {
    	
    }
    foodList = [
    	{
    		"foodName" : foodNames[0],
    		"kcal" : parseFloat(kcals[0]),
    		"carbs" : parseFloat(carbss[0]),
    		"protein" : parseFloat(proteins[0]),
    		"fat" : parseFloat(fats[0])
    	}
    ]
    console.log('foodList : ' ,foodList);
  // for (var i = 0; i < foodNames.length; i++) {
	//   var url = './userFoodInsert?' +
  //     'foodName=' + foodNames[i] +
  //     '&kcal=' + kcals[i] +
  //     '&carbs=' + carbss[i] +
  //     '&protein=' + proteins[i] +
  //     '&fat=' + fats[i] +
  //     '&id=' + id;
  // }
  $.ajax({
	 url : './userFoodInsert',
	 type : "POST",
	 dataType : "json",
	 async: false ,
	 contentType:  "application/json; charset:UTF-8",
	 data: JSON.stringify(foodList),
     error : function(){

     }, success: function (data, textstatus) {
          alert('success')
          console.log('success');
      }, beforeSend: function () {

      }, complete: function () {
          console.log('complete의 foodNames : ' , foodNames);
          console.log('complete의 foodList : ' , foodList);
          console.log('complete의 type : ' , typeof foodList);
          console.log('complete');
      }
  });
//  window.location.href = url;
////  부모 창으로 데이터 전송 후 팝업 창 닫기
//    window.close(); // 팝업 창 닫기
//    window.opener.refreshParent();
  }
}

window.onbeforeunload = function() {
	var url = './popupClose'
	window.location.href = url;
}

function popupClose() {
	var url = './popupClose'
	window.location.href = url;
	window.close();
}


function getParameterByName(name) {
  name = name.replace(/[\[\]]/g, "\\$&");
  var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
      results = regex.exec(window.location.href);
  if (!results) return null;
  if (!results[2]) return '';
  return decodeURIComponent(results[2].replace(/\+/g, " "));
}



//ajax 검색 -- 향후 활용 가능(현재 service 활용 검색중)
const searchRequest = new XMLHttpRequest();
//ajax 검색 요청 함수
function searchFunction() {
	
	//GET 방식 요청
	let url = '../FoodSearch?foodName=' + encodeURIComponent(document.getElementById('foodName').value);
	searchRequest.open('GET' , url , true);
	//send() 함수로 서버에 요청(서블릿 호출)한다.
	searchRequest.send(null);
	// onreadystatechange를 사용해서 ajax 요청이 완료되면 자동으로 실행할 콜백 함수 이름을 지정한다. 
	searchRequest.onreadystatechange = searchProcess;
	
}

// ajax 요청이 완료되면 실행할 콜백 함수
function searchProcess() {
	//통신이 정상적으로 완료되었음을 확인하고 필요한 작업을 실행한다. 
	if (searchRequest.readyState == 4 && searchRequest.status == 200) {
		//console.log('responseText: ' + searchRequest.responseText);
		//서블릿에서 리턴된 문자열을 javascript 객체로 변환시키기 위해 괄호를 붙여서 eval()함수를
		// 실행해서 객체로 저장한다.
		let object = eval('(' + searchRequest.responseText + ')' );
		console.log(object);
		// javascript 객체에서 result 라는 key에 할당된 데이터를 얻어온다. => 화면에 출력할 데이터
		let result = object.result;
		console.log(result);
		
		//서블릿에서 수신된 데이터를 출력하기 위해 <tbody>탤그를 얻어온다. 
		let tbody = document.getElementById('ajaxTable');
		//새로 검색된 데이터가 표시되어야 하므로 이전에 <tbody>태그에 들어있던 내용은 지운다.
		tbody.innerHTML = "";
		//데이터의 개수만큼 반복하며 <tbody> 태그에 행을 만들어 추가한다.
		for(let i=0; i<result.length; i++) {
         // <tbody>에 넣어줄 행을 만든다.
         let row = tbody.insertRow(i);
         // 한 행에 출력할 열의 개수만큼 반복하며 행에 열을 추가한다.
         for(let j=0; j<result[i].length; j++) {
            // 행에 넣어줄 열을 만든다.
            let cell = row.insertCell(j);
            // 열에 화면에 표시할 데이터를 넣어준다.
            cell.innerHTML = result[i][j].value;
         }
          // 열을 추가하여 체크박스를 포함시킨다.
		  let checkboxCell = row.insertCell(result[i].length);
		  checkboxCell.className = "text-center";
		  checkboxCell.innerHTML = "<input type='checkbox' value='선택' name='foodName'/>";
      }
	} 
}
