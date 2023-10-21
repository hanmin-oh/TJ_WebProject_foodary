function openPopup() {
    // 새 창을 열고 URL로 이동
	var gup = document.getElementById("gup").value;
	console.log(gup)
   url = 'updateFoodList?gup='+ gup;
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

//인덱스 활용 음식 저장 형태 완료 
function foodPlus(index) {
   // console.log(index);
    var userFoodName = document.getElementsByName("dietFoodName")[index].value;
    var kcal = document.getElementsByName("dietKcal")[index].value;
    var carbs = document.getElementsByName("dietCarbs")[index].value;
    var protein = document.getElementsByName("dietProtein")[index].value;
    var fat = document.getElementsByName("dietFat")[index].value;
    var id = document.getElementsByName("id")[index].value;
   var url = './updateUserFoodInsert' +
        '?foodName=' + encodeURIComponent(userFoodName) +
        '&kcal=' + encodeURIComponent(kcal) +
        '&carbs=' + encodeURIComponent(carbs) +
        '&protein=' + encodeURIComponent(protein) +
        '&fat=' + encodeURIComponent(fat) +
        '&id=' + encodeURIComponent(id);
    location.href = url;
}

function photoView(event) {
	$('#output').attr('src', URL.createObjectURL(event.target.files[0]));
}

function photoDelete() {
	var confirmation = confirm("사진을 삭제하시겠습니까?");
	if (confirmation) {
		$('#output').remove();
		$('#deleteBtn').remove();
		$('#dietPictuer').val('no picture');
	}
}

//idx활용, index활용 수정 완료!! 
function dietUpdateUserFood(idx , index) {
   var userFoodName = $('#userFoodName_' + index).val().trim();
   var userKcal = $('#userKcal_' + index).val().trim();
   var userCarbs = $('#userCarbs_' + index).val().trim();
   var userProtein = $('#userProtein_' + index).val().trim();
   var userFat = $('#userFat_' + index).val().trim();
   var gup = document.getElementById("gup").value;
	console.log(gup)
   console.log(userProtein);
    var url = './dietUpdateUserFood' +
      '?idx=' + idx +
      '&foodName=' + userFoodName +
      '&kcal=' + userKcal +
      '&carbs=' + userCarbs +
      '&protein=' + userProtein +
      '&fat=' + userFat + 
      '&gup=' + gup;
    console.log(url);
    location.href = url;
}

 function showNutrient() {
	 
   var kcalElements = document.getElementsByClassName("kcals");
   var carbsElements = document.getElementsByClassName("carbs");
   var proteinElements = document.getElementsByClassName("proteins");
   var fatElements = document.getElementsByClassName("fats");
   
   var userKcals = [];
   var userCarbs = [];
   var userProteins = [];
   var userFats = [];
   
   // 각 태그의 값을 배열에 저장
   for (var i = 0; i < kcalElements.length; i++) {
     var kcalValue = document.getElementById("userKcal_" + i).value;
     var carbsValue = document.getElementById("userCarbs_" + i).value;
     var proteinValue = document.getElementById("userProtein_" + i).value;
     var fatValue = document.getElementById("userFat_" + i).value;
   
     userKcals.push(kcalValue);
     userCarbs.push(carbsValue);
     userProteins.push(proteinValue);
     userFats.push(fatValue);
}

   console.log(userCarbs);    // ["50", "60", "70"]
     
   var kcalSum = 0;
   var carbsSum  = 0;
   var proteinSum  = 0;
   var fatSum  = 0;
   
   for (var i = 0; i < userKcals.length; i++) {
     kcalSum += Number(userKcals[i]);
     carbsSum += Number(userCarbs[i]);
     proteinSum += Number(userProteins[i]);
     fatSum += Number(userFats[i]);
   }
   
   // alert("mainCalculator");
   // alert(currentWeight)
   let currentWeight = parseInt($('#currentWeight').val().trim());
   let goalWeight = parseInt($('#goalWeight').val().trim());
   let gender = $('input[name=gender]').val();
   let age = parseInt($('#age').val().trim());
   let height = parseInt($('#height').val().trim());
   let active = parseFloat($('select > option[name=active]:selected').val());
   let mode = $('input[name=mode]:checked').val();
   console.log(currentWeight, goalWeight, gender, age, height, active, mode);
   let kcal = 0.0;
   let protein = 0.0;
   let carbs = 0.0;
   let fat = 0.0;
//   입력되지 않은 정보 있는지 거르기   
   if (!isNaN(currentWeight) && !isNaN(goalWeight) && !isNaN(age) && !isNaN(height) && !isNaN(active)) {
      console.log(currentWeight, goalWeight, gender, age, height, active, mode);
      // 성별 체크
      if (gender == '남자') {
         // 모드 체크
         if (mode == 'health') {
            kcal = 66 + (13.7 * currentWeight) + (5 * height) - (4.7 * age) ;
         }
         else{
            kcal = 66 + (13.7 * goalWeight) + (5 * height) - (4.7 * age);
         }
      } else {
         if (mode == 'health') {
            kcal = 655 + (9.6 * currentWeight) + (1.8 * height) - (4.7 * age);
         }
         else {
            kcal = 655 + (9.6 * goalWeight) + (1.8 * height) - (4.7 * age);
         }
         
         kcal = kcal * active;
      }
      if (mode == 'health') {
         carbs = kcal * 0.4 / 4;
         protein = kcal * 0.3 / 4;
         fat = kcal * 0.3 / 9;
      } else {
         carbs = kcal * 0.5 / 4;
         protein = kcal * 0.3 / 4;
         fat = kcal * 0.2 / 9;
      }
      
       
	   var kcalGraph = document.getElementById("kcalGraph");
	   var carbsGraph = document.getElementById("carbsGraph");
	   var proteinGraph = document.getElementById("proteinGraph");
	   var fatGraph = document.getElementById("fatGraph");
	   
	   
	   	kcalGraph.style.width =  kcalSum / kcal * 100 + "%";// 너비 값을 변경
		carbsGraph.style.width = carbsSum / carbs * 100 + "%";// 너비 값을 변경
		proteinGraph.style.width = proteinSum / protein * 100 + "%";// 너비 값을 변경
		fatGraph.style.width = fatSum / fat * 100  + "%";// 너비 값을 변경
		
      // console.log(kcal, carbs, protein, fat);
      $('#kcalGraph').attr('aria-valuemax', parseInt(kcal)); 
      $('#kcalGraph').text(parseInt(kcalSum) + 'kcal / ' + parseInt(kcal) + ' kcal');

      $('#carbsGraph').attr('aria-valuemax', parseInt(carbs)); 
      $('#carbsGraph').text(parseInt(carbsSum) + 'g / '+ parseInt(carbs) + ' g');

      $('#proteinGraph').attr('aria-valuemax', parseInt(protein)); 
      $('#proteinGraph').text(parseInt(proteinSum) + 'g / '+ parseInt(protein) + ' g');

      $('#fatGraph').attr('aria-valuemax', parseInt(fat)); 
      $('#fatGraph').text(parseInt(fatSum) + 'g / '+ parseInt(fat) + ' g');
      
   } else {
      alert('입력한 정보를 확인해주세요')
      $('#currentWeight').val('');
      $('#currentWeight').focus();
      $('#goalWeight').val('');
      $('#age').val('');
      $('#height').val('');
   }
}
 
function insertCheck() {
	if ($('#memo').val().trim() === "") {
		alert('메모를 입력해주세요')
		$('#memo').val('');
		$('#memo').focus();
		return false;
	} else {
		return true;
	}
}
