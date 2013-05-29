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

// For the Graph
ArrayList<Double> values = (ArrayList<Double>) request.getAttribute("graphArray");
%>


<html>
	<head>
	
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      
      var items = [];
      for (var i=0; i< <%= values.size() %>; i++){
    	  items[i] = [];
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
          title: 'Fitness Convergence'
        };

        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
    
	
	
	<title>Load Distribution Problem</title>
	<SCRIPT type="text/javascript" language="JavaScript">
	function init(){
		stackTable="<table><tr>";
		stackList='';
		var i=1;
		var containerID;
		<%for (Stack<Container> s: finalVessel.getStackList()){	%>
			if((i%<%=Vessel.COLUMNS%>==1)&&(i!=1)){
				stackTable=stackTable+"</tr><tr>";
			}
			stackTable=stackTable+"<td onclick=\"goTo('"+i+"')\"> Stack "+i+" , Total Weight = "+<%=s.getTotalStackWeight()%>+"</td>";
			stackList=stackList+"<div id="+i+"><h4>Stack "+i+"</h4><table><tr><th>Container ID</th><th>Weight</th></tr>";
			containerID=1;
			<%for (Container c: s.get()){%>
				stackList=stackList+"<tr><td>"+<%=c.getId()%>+"</td><td>"+<%=c.getWeight()%>+"</td></tr>";// CHANGE to c.getID
				containerID++;				
			<%}%>
			stackList=stackList+"</table></div>";
			i++;
		<%}%>
		document.getElementById("stackTable").innerHTML=stackTable;
		document.getElementById("stacklist").innerHTML=stackList;
	}
	
	function goTo(x){
		document.getElementById(x).scrollIntoView();
	}
	</SCRIPT>
	</head>
  
  <body onload="init();" >	
  
  	<div id="chart_div" style="width: 900px; height: 500px;"></div>
  	
  	<div id="stackTable"></div>	
  	<div id="stacklist"></div>
  </body>
</html>