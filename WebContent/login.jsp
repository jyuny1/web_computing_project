<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="CYL.*" %>
<%@page import="javax.servlet.http.*" %>
<%
//translate to different locations for data storage
String inputLoginName = request.getParameter("inputLoginNameTop");
String inputPassWord = request.getParameter("inputPassWordTop");				
pathTranslator pt = new pathTranslator(request.getRealPath("/"), inputLoginName);	
user loginUser = new user(inputLoginName,
	 		    	 	  inputPassWord,
	  				 	  pt);
String loginMsg;

boolean userExist = loginUser.exist();
HttpSession newSession = request.getSession();

if(userExist){
	boolean passWordOK = loginUser.checkPassWord(loginUser.getInputPassWord());

	if(passWordOK) {
		loginMsg = "Welcome! "+loginUser.getInputLoginName();
		//setup user attrbute
		loginUser.setLoginState(true);
		newSession.setAttribute("loginUser", loginUser);
	}
	else{
		loginMsg = "Wrong password! please enter it again. <br />Current page will redirect to login page.";
	}
}
else {
	loginMsg = loginUser.getInputLoginName()+" does not exist!.";
}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="javascript/delayredirect.js"></script>
<title>Insert title here</title>
</head>
<body onload="setTimeout('delayedRedirect()', 2000);">
	<h2><%=loginMsg %></h2>
	<p>this page will redirect to <a href="residence.jsp">residence page</a> in 2 seconds...</p>
</body>
</html>