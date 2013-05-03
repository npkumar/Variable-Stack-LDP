
function validateForm() {
	
	var population_size = document.mainform.population.value;
	var evolutions = document.mainform.evolutions.value;
	
	if (population_size > 100){
		document.getElementById("population_error").innerHTML = "Maximum of 100!";
		document.getElementById("population").focus();
		return false;
	}else{
		document.getElementById("population_error").innerHTML = "";
	}
	
	return true;
}