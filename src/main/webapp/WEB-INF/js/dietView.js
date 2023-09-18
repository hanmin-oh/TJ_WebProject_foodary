function photoView(event) {
      $('#output').attr('src', URL.createObjectURL(event.target.files[0]));
}

//idx활용, index활용 수정 완료!! 
function updateUserFood(idx , index) {
   var userFoodName = $('#userFoodName_' + index).val().trim();
   var userKcal = $('#userKcal_' + index).val().trim();
   var userCarbs = $('#userCarbs_' + index).val().trim();
   var userProtein = $('#userProtein_' + index).val().trim();
   var userFat = $('#userFat_' + index).val().trim();
   console.log(userProtein);
    var url = './updateUserFood' +
      '?idx=' + idx +
      '&foodName=' + userFoodName +
      '&kcal=' + userKcal +
      '&carbs=' + userCarbs +
      '&protein=' + userProtein +
      '&fat=' + userFat;
    location.href = url;
}

 function showNutrient() {
    
   var kcalElements = document.getElementsByClassName("kcals");
//   var carbsElements = document.getElementsByClassName("carbs");
//   var proteinElements = document.getElementsByClassName("proteins");
//   var fatElements = document.getElementsByClassName("fats");
   
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
    console.log(userKcals);
    console.log(userCarbs);
    console.log(userProteins);
    console.log(userFats);    // ["50", "60", "70"]
     
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
      
     // 본인의 총 칼로리양 초과 시 그래프 색 변경
      if(parseInt(kcalSum) > parseInt(kcal)) {
         $('#kcalGraph').css('background', '#F07272');
      }
      if(parseInt(carbsSum) > parseInt(carbs)) {
         $('#carbsGraph').css('background', '#F07272');
      }
      if(parseInt(proteinSum) > parseInt(protein)) {
         $('#proteinGraph').css('background', '#F07272');
      }
      if(parseInt(fatSum) > parseInt(fat)) {
         $('#fatGraph').css('background', '#F07272');
      }
      
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

function deleteOK() {
    var confirmation = confirm("해당 글을 삭제하시겠습니까?\n(삭제 후에는 복구가 불가능 합니다.)");
    if (confirmation) {
    	location.href="dietDelete?idx=" + $('#idx').val() +
    				"&id=" + $('#id').val() +
    				"&dietWriteDate=" + $('#dietWriteDate').val() +
    				"&gup=" + $('#gup').val()
    }
} 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 