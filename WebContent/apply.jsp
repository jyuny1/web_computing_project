<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="CYL.*" %>
<%
	//check user has logged-in or not	
	HttpSession localSession = request.getSession();
	user loginUser = (user) localSession.getAttribute("loginUser");
	webForm applicationForm = new webForm();
	boolean loginOK = false;
	
	if(loginUser != null && loginUser.isLoginOK()) {
		loginOK = loginUser.isLoginOK();
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="css/apply.css" />
<script type="text/javascript" src="javascript/delayredirect.js"></script>
<title>Confirm your application</title>
</head>
<body onload="setTimeout('delayedRedirect()', 2000);">
	<%
		if(loginOK){
			if(loginUser.getModifyFlag()){
				applicationForm = new webForm(request.getParameter("inputTitle"),
				    	  request.getParameter("inputFirstName"),
						  request.getParameter("inputLastName"),
						  request.getParameter("inputEmail"),
						  request.getParameter("inputCanNumber"),
						  request.getParameter("inputFirstChoise"),
						  request.getParameter("inputSecondChoise"),
						  request.getParameter("inputThirdChoise"),
						  request.getParameter("inputLoginName"),
						  request.getParameter("inputPassWord"));
				
				boolean isWriteOK = applicationForm.toXML(loginUser.getPathTranslator());
				//update user state
				loginUser.setModifyFlag(false);
				localSession.setAttribute("loginUser", loginUser);
				if(isWriteOK){
				%>
					<p>your information has updated! :-)</p>
				<%
				}
			}
		}
		else{
			//login not ok, a new user
			applicationForm = new webForm(request.getParameter("inputTitle"),
			    	  request.getParameter("inputFirstName"),
					  request.getParameter("inputLastName"),
					  request.getParameter("inputEmail"),
					  request.getParameter("inputCanNumber"),
					  request.getParameter("inputFirstChoise"),
					  request.getParameter("inputSecondChoise"),
					  request.getParameter("inputThirdChoise"),
					  request.getParameter("inputLoginName"),
					  request.getParameter("inputPassWord"));
				//translate to different locations for data storage
				pathTranslator pt = new pathTranslator(request.getRealPath("/"), applicationForm.getLoginName());	
				loginUser = new user(request.getParameter("inputLoginName"),
									 request.getParameter("inputPassWord"),
									 pt);
				boolean userExist = loginUser.exist();
				if(!userExist){
					//the user name that applicant has chosen is not been exist
					boolean isWriteOK = applicationForm.toXML(loginUser.getPathTranslator());
					
					if(isWriteOK){
					%>
					<p>
						your information has alredy saved! :-)<br />
						<%=pt.getXMLFilePath() %>
					</p>	
					<%
					}
				}
				else {
				%>
					<p>
						Oops, <b><%=loginUser.getInputLoginName() %></b> is already used by someone. <br />
						Please try another one. :-)
					</p>
				<%
				}
		}
	%>
	<p>
		will redirect this page to <a href="residence.jsp">residence page</a> in 2 seconds...
	</p>
</body>
</html>