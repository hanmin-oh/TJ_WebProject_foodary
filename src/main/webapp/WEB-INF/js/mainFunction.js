function showMenu() {
	// alert("showMenu");
	var ranNum = Math.floor(Math.random() * 24) + 1
	// console.log(ranNum);
	$('#showMenu').html('');
	$('#showMenu').html('<img src="../images/' + ranNum + '.png" style="width: 340px;"/>');
}









