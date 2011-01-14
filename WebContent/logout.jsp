<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="CYL.*" %>
<%@page import="javax.servlet.http.*" %>
<%
	//check user has logged-in or not	
	HttpSession localSession = request.getSession();
	user loginUser = (user) localSession.getAttribute("loginUser");
	boolean removeOK = false;
	
	if(loginUser != null && loginUser.isLoginOK()) {
		//remove the login state
		localSession.removeAttribute("loginUser");
		removeOK = true;
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="css/logout.css" />
<script type="text/javascript" src="javascript/delayredirect.js"></script>
<title>You've logged out!</title>
</head>
<body onload="setTimeout('delayedRedirect()', 2000);">
<table>
	<%
		if(removeOK) {	
	%>
		<tr><td>
		Hey, you've already logged out.<br />
		</td></tr>
	<%
		}
		else {
	%>
		<tr><td>
		<h2>You haven't logged in!</h2>	
		</td></tr>
	<% 
		}
	%>
</table>
	<p>
		this page will redirect to <a href="residence">residence page</a> in 2 seconds
	</p>
</body>
</html>