<%@page import="java.util.ArrayList"%>
<%@page import="com.getnpk.genetic.ds.Container"%>
<%@page import="com.getnpk.genetic.ds.Stack"%>
<%@page import="com.getnpk.genetic.ds.Vessel"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>

	<head>
	<link type="text/css" rel="stylesheet" href="/stylesheets/display.css" />
	<title>Load Distribution Problem</title>
	</head>
  
  <body>

<%
	Vessel finalVessel = null;
	ArrayList<Integer> mylist = new ArrayList<Integer>();
	if (request.getAttribute("final") != null){
		finalVessel =  (Vessel) request.getAttribute("final");
		
		for (Stack<Container> s: finalVessel.getStackList()){
			
			%> <div class="vessel"> <%
			for (Container c: s.get()){
				mylist.add(c.getWeight());
				%>
				<div class="package"><p><%= c.getWeight() %></p></div>
				<%
			}
			%></div><%
		}
	}
	%>
	
  </body>
</html>