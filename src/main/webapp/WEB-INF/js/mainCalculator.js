function mainCalculator () {
	// alert("mainCalculator");
	// alert(currentWeight)
	let currentWeight = parseInt($('#currentWeight').val().trim());
	let goalWeight = parseInt($('#goalWeight').val().trim());
	let gender = $('input[name=gender]:checked').val();
	let age = parseInt($('#age').val().trim());
	let height = parseInt($('#height').val().trim());
	let active = parseFloat($('select > option[name=active]:selected').val());
	let mode = $('input[name=mode]:checked').val();
	// console.log(currentWeight, goalWeight, gender, age, height, active, mode);
	let kcal = 0.0;
	let protein = 0.0;
	let carbs = 0.0;
	let fat = 0.0;
//	입력되지 않은 정보 있는지 거르기	
	if (!isNaN(currentWeight) && !isNaN(goalWeight) && !isNaN(age) && !isNaN(height) && !isNaN(active)) {
		// console.log(currentWeight, goalWeight, gender, age, height, active, mode);
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
			// console.log(kcal);
		if (mode == 'health') {
			carbs = kcal * 0.4 / 4;
			protein = kcal * 0.3 / 4;
			fat = kcal * 0.3 / 9;
		} else {
			carbs = kcal * 0.5 / 4;
			protein = kcal * 0.3 / 4;
			fat = kcal * 0.2 / 9;
		}
		// console.log(kcal, carbs, protein, fat);
		$('#kcal').attr('value', parseInt(kcal));
		$('#carbs').attr('value', parseInt(carbs));
		$('#protein').attr('value', parseInt(protein));
		$('#fat').attr('value', parseInt(fat));
		
	} else {
		alert('입력한 정보를 확인해주세요')
		$('#currentWeight').val('');
		$('#currentWeight').focus();
		$('#goalWeight').val('');
		$('#age').val('');
		$('#height').val('');
	}
}





















