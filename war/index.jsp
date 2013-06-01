
 
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.HashMap" %>

<%
HashMap<String,String> hm= (HashMap<String, String>) session.getAttribute("configs");

if(hm==null){
	hm=new HashMap<String,String>();
	hm.put("container","100");
	hm.put("width","4");
	hm.put("breadth","4");
	hm.put("maxStackSize","8");
	hm.put("minStackSize","1");
	hm.put("evolutions","100");
	hm.put("population","50");
	hm.put("crossover",".5");
	hm.put("mutation","10");
	session.setAttribute("configs",hm);
}
%>


<html>
	<head>
	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
	<title>Load Distribution Problem</title>
	<script type="text/javascript">
	function validateForm() {
	
	if (document.getElementById("Containers").value==''){
			alert("The number of containers is not set");
		document.getElementById("Containers").focus();
		return false;
	}
	
	if (document.getElementById("Width").value==''){
			alert("The Width is not set");
		document.getElementById("Width").focus();
		return false;
	}
	
	if (document.getElementById("Breadth").value==''){
			alert("The Breadth is not set");
		document.getElementById("Breadth").focus();
		return false;
	}
		
	if (document.getElementById("Evolutions").value==''){
			alert("The No. of Evolutions is not set");
		document.getElementById("Evolutions").focus();
		return false;
	}
		
	if (document.getElementById("PopulationSize").value==''){
			alert("The Population Size is not set");
		document.getElementById("PopulationSize").focus();
		return false;
	}
		
	if (document.getElementById("CrossoverRate").value==''){
			alert("The Crossover Rate is not set");
		document.getElementById("CrossoverRate").focus();
		return false;
	}
		
	if (document.getElementById("MutationRate").value==''){
			alert("The Mutation Rate is not set");
		document.getElementById("MutationRate").focus();
		return false;
	}
	
	if (document.getElementById("Maximum").value==''){
		alert("The Maximum stack size not set!");
		document.getElementById("Maximum").focus();
		return false;
	}
	
	if (document.getElementById("Minimum").value==''){
		alert("The Minimum stack size not set!");
		document.getElementById("Minimum").focus();
		return false;
	}
	
	return true;
	}
	
	function checkNum(field){
	var x=document.getElementById(field).value;
	if(isNaN(x)){
		if(x.length==1)
			x=''
		else
			x=x.substr(0,x.length-1);
		document.getElementById(field)=x;
	}
		document.getElementById(field).focus();
	}
	
	
	function validateField(field){
	
	var x=document.getElementById(field).value;
	if(x=='')
		return;
	if(isNaN(x)){
		alert("Please enter only numbers");
		document.getElementById(field).value='';
		document.getElementById(field).focus();
		return;
	}
	
	if(field=="Containers"){
		if((x<64)||(x>150))	{
			alert("The total number of containers has to between 64 and 150");
			document.getElementById(field).value='';
			document.getElementById(field).focus();
		}
	}
	
		if(field=="Width"){
		if((x<1)||(x>10))	{
			alert("The width  has to between 1 and 10");
			document.getElementById(field).value='';
			document.getElementById(field).focus();
		}
	}
	
		if(field=="Breadth"){
		if((x<1)||(x>10))	{
			alert("The breadth has to between 1 and 10");
			document.getElementById(field).value='';
			document.getElementById(field).focus();
		}
	}
	
		if(field=="Evolutions"){
		if((x<50)||(x>1000))	{
			alert("The no. of Evolutions has to between 50 and 1000");
			document.getElementById(field).value='';
			document.getElementById(field).focus();
		}
	}
	
		if(field=="PopulationSize"){
		if((x<10)||(x>200))	{
			alert("The Population Size has to between 10 and 200");
			document.getElementById(field).value='';
			document.getElementById(field).focus();
		}
	}
	
		if(field=="CrossoverRate"){
		if((x<.01)||(x>.99))	{
			alert("The Crossover Rate has to between .01 and .99");
			document.getElementById(field).value='';
			document.getElementById(field).focus();
		}
	}
		
		if(field=="MutationRate"){
		if((x<9)||(x>100))	{
			alert("The Mutation Rate has to between 10 and 99");
			document.getElementById(field).value='';
			document.getElementById(field).focus();
		}
	}

		if(field=="Maximum"){
			if((x<4)||(x>20))	{
				alert("The Maximum stack size is between 4 and 20");
				document.getElementById(field).value='';
				document.getElementById(field).focus();
			}
		}

		if(field=="Minimum"){
			if((x<1))	{
				alert("The minimum stack size is 1.");
				document.getElementById(field).value='';
				document.getElementById(field).focus();
			}
		}
	
	}
	
	</script>
	
	<style>
		body {
		 	font-family: Helvetica, Arial, sans-serif;
    		font-size: 14px;
			width: 700px;
    		margin: 0 auto;
		}
		
		input[type=submit] {
 			 font-size: 18px;
		}
		
		table {
    		margin: 0 auto;
		}
	</style>
	
	</head>
  
  <body>
  <a href="about.html"><img src="img/header.png"></a>
  <!-- <h2 style="text-align:center;">Load Distribution Problem Simulation</h2> -->
  <hr />
  
	<form name="detailsForm" id="detailsForm" action="/ldapp" method="post" onSubmit="return validateForm()">
  	<table  style="text-align:center;float:center;" >
	<!--  <tr><td><h2>Load Distribution Problem Simulation</h2></td></tr>  -->
	
	<tr></tr>
	<tr><td><p></p></td></tr>
	<tr><td><p></p></td></tr>
	<tr><td><p></p></td></tr>
	<tr><td><table>
	<tr>
	<td><h4 style="text-align:center;">Load Distribution Configuration</h4></td>
	<td style="float:right;text-align:center;"><h4>Genetic Algorithm Configuration</h4></td>
	</tr>
	<tr><td><table name="LoadConfigTable" style="text-align:center;" align="center">
  	        <tr><td>Containers</td><td><input type="text" name="containers" id="Containers" value="<%= (String) hm.get("container") %>" onblur="validateField('Containers')"></td></tr>
  	        <tr><td>Grid Width</td><td><input type="text" name="width" id="Width" value="<%= (String) hm.get("width") %>" onblur="validateField('Width')"></td></tr>
  	        <tr><td>Grid Breadth</td><td><input type="text" name="breadth" id="Breadth" value="<%= (String) hm.get("breadth") %>" onblur="validateField('Breadth')"></td></tr>
  	        <tr><td>Maximum Stack Size</td><td><input type="text" name="maximum" id="Maximum" value="<%= (String) hm.get("maxStackSize") %>" onblur="validateField('Maximum')"></td></tr>
  	        <tr><td>Minimum Stack Size</td><td><input type="text" name="minimum" id="Minimum" value="<%= (String) hm.get("minStackSize") %>" onblur="validateField('Minimum')"></td></tr>
  	</table></td><td style="float:right;">
  	<table name="GAConfigTable" style="text-align:center;" align="center">
  	        <tr><td>Evolutions</td><td>	<input type="text" name="evolutions" id="Evolutions" value="<%= (String) hm.get("evolutions") %>" onblur="validateField('Evolutions')"></td></tr>
  	        <tr><td>Population Size</td><td><input type="text" name="population" id="PopulationSize" value="<%= (String) hm.get("population") %>" onblur="validateField('PopulationSize')"></td></tr>
  	        <tr><td>Crossover Rate</td><td><input type="text" name="crossover" id="CrossoverRate" value="<%= (String) hm.get("crossover") %>" onblur="validateField('CrossoverRate')"></td></tr>
  	        <tr><td>Mutation Rate</td><td><input type="text" name="mutation" id="MutationRate" value="<%= (String) hm.get("mutation") %>" onblur="validateField('MutationRate')"></td></tr>
  	</table></td></tr>
	</table></td></tr>
	<tr><td><p></p></td></tr>
	<tr><td><p></p></td></tr>
	<tr><td><p></p></td></tr>
	<tr><td style="float:right;"><input type="submit" value="Run Simulation"/></td></tr>
	</table> 
	</form>
  </body>
</html>
