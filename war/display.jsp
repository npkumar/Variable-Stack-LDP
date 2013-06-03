

<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Random"%>
<%@page import="com.getnpk.genetic.ds.Container"%>
<%@page import="com.getnpk.genetic.ds.Stack"%>
<%@page import="com.getnpk.genetic.ds.Vessel"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.List" %>


<%
Vessel finalVessel = null;
ArrayList<Integer> mylist = new ArrayList<Integer>();
if (request.getAttribute("final") != null){
	finalVessel = (Vessel) request.getAttribute("final");
	
}
HashMap<String,String> hm= (HashMap<String,String>) session.getAttribute("configs");
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
}else{
	session.setAttribute("configs",hm);
}
// For the Graph
ArrayList<Double> values = (ArrayList<Double>) request.getAttribute("graphArray");
//int evolutions= Integer.parseInt((String)request.getAttribute("evol"));
//if(values.size()>evolutions)
	//values=(ArrayList<Double>)values.subList(values.size()-evolutions-1, values.size());
%>


<html>
	<head>
	
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      
      var items = [];
      for (var i1=0; i1< <%= values.size() %>; i1++){
    	  items[i1] = [];
      }
      
      var iteration = 1;
      items[0][0] = 'Iteration';
      items[0][1] = 'Fitness Value';
      <% for (double d: values){ %>
    		items[iteration][0] = iteration;
    		items[iteration][1] = <%= d %>;
    		iteration++;
      <% } %>
      
       console.log(items);
      
      function drawChart() {
        var data = google.visualization.arrayToDataTable(items);
		
        var options = {
          title: 'Fitness Convergence',
          hAxis: {title: 'Number of evolutions',  titleTextStyle: {color: '#FF0000'}},
          vAxis: {title: 'Fitness Value',  titleTextStyle: {color: '#FF0000'}}
        };

        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
    
	<style> 
	
body {
 	font-family: Sans-serif, Helvetica, Arial;
    font-size: 16px;
	width: 800px;
    margin: 0 auto;
}

#maintable
{
border:2px solid;
border-radius:25px;

border-collapse:collapse;
margin-top:10px;
margin-bottom:10px;
margin-right:5px;
margin-left:5px;
}

table,th, td
{
border: 2px solid black;
text-align:center;
border-collapse:collapse;
margin: 0 auto;
}


td
{
padding:10px;
}

table.subTable
{
border-collapse:collapse;
border:2px solid;
border-radius:25px;
margin-top:5px;
margin-bottom:5px;
margin-right:3px;
margin-left:3px;
}

table.innerTable{
border-collapse:collapse;
border:1px solid;
border-radius:10px;
margin-top:5px;
margin-bottom:5px;
margin-right:3px;
margin-left:3px;
}
</style>
	
	<title>Load Distribution Problem</title>
	<SCRIPT type="text/javascript" language="JavaScript">
	i=1;
	
	function blockall(count){
		for(j=1;j<count;j++)
			blocking(j+'a');
	}
	
    function blocking(nr){
      displayNew = (document.getElementById(nr).style.display == 'none') ? 'block' : 'none';
       document.getElementById(nr).style.display = displayNew;
    }
    
	function init(){
		
		stackTable="<table id=\"maintable\"><tr class=\"mainrow\">";
		stackList='';
		var containerID;
		<%for (Stack<Container> s: finalVessel.getStackList()){	%>
			if((i%<%=Vessel.COLUMNS%>==1)&&(i!=1)){
				stackTable=stackTable+"</tr><tr class=\"mainrow\">";
			}
			stackTable=stackTable+"<td  class=\"maincell\" onclick=\"goTo('"+i+"')\"> <p>Stack "+i+" </p><table class=\"innerTable\"><tr><th>No. of Items</th><th>Total Weight</th></tr><tr><td>"+<%=s.getLength()%>+"</td><td>"+<%=s.getTotalStackWeight()%>+"</td></tr></table></td>";
			stackList=stackList+"<div id="+i+"><a href=\"\" onclick=\"blocking('"+i+"a'); return false;\"><h4>Stack "+i+"</h4></a><div id=\""+i+"a\"><table class=\"subTable\"><tr><th>Container ID</th><th>Weight</th></tr>";
			containerID=1;
			<%for (Container c: s.get()){%>
				stackList=stackList+"<tr><td>"+<%=c.getId()%>+"</td><td>"+<%=c.getWeight()%>+"</td></tr>";// CHANGE to c.getID
				containerID++;				
			<%}%>
			stackList=stackList+"</table></div></div>";
			i++;
		<%}%>
		document.getElementById("stackTable").innerHTML=stackTable;
		document.getElementById("stacklist").innerHTML=stackList;
		blockall(i);
	}
	
	function goTo(x){
		blocking(x+"a");
		document.getElementById(x).scrollIntoView();
	}
	</SCRIPT>
	</head>
  
  <body onload="init();" >	
  	
  	
  	
  	<table  style="text-align:center;float:center;" >
	<tr><td><table>	<tr>
	<td><h4 style="text-align:center;">Load Distribution Configuration</h4></td>
	<td style="float:right;text-align:center;"><h4>Genetic Algorithm Configuration</h4></td>	</tr>
	<tr><td><table name="LoadConfigTable" style="text-align:center;" align="center">
  	        <tr><td>Containers</td><td><%=(String)hm.get("container")%></td></tr>
  	        <tr><td>Grid Width</td><td><%=(String)hm.get("width")%></td></tr>
  	        <tr><td>Grid Breadth</td><td><%=(String)hm.get("breadth")%></td></tr>
  	        <tr><td>Maximum Stack Size</td><td><%=(String)hm.get("maxStackSize")%></td></tr>
  	        <tr><td>Minimum Stack Size</td><td><%=(String)hm.get("minStackSize")%></td></tr>
  	</table></td><td style="float:right;">
  	<table name="GAConfigTable" style="text-align:center;" align="center">
  	        <tr><td>Evolutions</td><td><%=(String)hm.get("evolutions")%></td></tr>
  	        <tr><td>Population Size</td><td><%=(String)hm.get("population")%></td></tr>
  	        <tr><td>Crossover Rate</td><td><%=(String)hm.get("crossover")%></td></tr>
  	        <tr><td>Mutation Rate</td><td><%=(String)hm.get("mutation")%></td></tr>
  	</table></td></tr>	</table></td></tr>	</table>
	
	
	
  	<div id="chart_div" style="width: 800px; height: 500px;"></div>  	
  	<h3>Click on Stack for more details.</h3>
  	<div id="stackTable"></div>	
  	<div id="stacklist"></div>
  	<a style="position: fixed; top:5px;right:5px;" href="index.jsp" title="Home Page"><img src="img/home.png"></a>
  	<a style="position: fixed; top:50px;right:5px;" href="about.html" title="About"><img src="img/about.png"></a>
  	<a style="position: fixed; top:95px;right:5px;" href="#" title="Click to go to top"><img src="img/top.png"></a>
  	
  </body>
</html>