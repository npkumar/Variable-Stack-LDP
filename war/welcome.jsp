<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>

	<head>
	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
	<script type="text/javascript" src="/scripts/main.js"></script>
	
	<title>Load Distribution Problem</title>
	</head>
  
  <body>
	<h2>Load Distribution Problem Simulation</h2>
	<hr />
	<p>Stack Size of four. And the Container area a grid size of 5 X 5. 500 evolutions.</p>
	<p>Weights of containers are randomly generated.</p>
  

  
<form name="mainform" action="/ldapp" method="post" onSubmit="return validateForm()"> 
	
	    <table>
        <tr>
          <td class="label">
            Evolutions
          </td>
          <td>
            <input type="text" name="evolutions" value="500">
          </td>
          <td class="error"> 
         	<div id="evolutions_error"></div> 
         </td>
        </tr>

        <tr>
          <td class="label">
            Population Size
          </td>
          <td>
            <input type="text" name="population" value="50">
          </td>
         <td class="error"> 
         	<div id="population_error"></div> 
         </td>
         
        </tr>

        <tr>
          <td class="label">
            Width
          </td>
          <td>
            <input type="text" name="width" value="5">
          </td>
          
        </tr>

        <tr>
          <td class="label">
            Breadth
          </td>
          <td>
            <input type="text" name="breadth" value="5">
          </td>
        </tr>
        
      </table>
	    
    <p><div><input type="submit" value="Run Simulation"/></div><p>
  </form>
  
   	
  </body>
</html>


    </form>