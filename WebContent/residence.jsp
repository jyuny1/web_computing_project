<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="CYL.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
	//get residence name to search hall information
	String residenceName = request.getParameter("residence");
	if(residenceName==null){
		residenceName="Stanmer_Court";
	}
		pathTranslator pt = new pathTranslator(request.getRealPath("/"), "");
		FormOperator formOperator = new FormOperator();
		Residence residence = formOperator.getResidenceInformation(residenceName, pt);
		String hallName = residence.getName().replace("_", " ");
		String imagePath = pt.getHallImagePath();
		String urlString = "residence.jsp?residence=";
		
		//check user has logged-in or not	
		HttpSession localSession = request.getSession();
		user loginUser = (user) localSession.getAttribute("loginUser");
		webForm applicationForm=new webForm();
		boolean loginOK = false;
		String loginFail="";
		
		if(loginUser != null && loginUser.isLoginOK()) {		
			applicationForm = new webForm(loginUser.getPathTranslator());
			formOperator.setLoginState(loginUser.isLoginOK());
			loginUser.setModifyFlag(true);
			loginOK=true;
		}
		else{
			//not login
			//translate to different locations for data storage
			String inputLoginName = request.getParameter("inputLoginNameTop");
			String inputPassWord = request.getParameter("inputPassWordTop");
			
			if((inputLoginName!=null && inputPassWord!=null)&&(inputLoginName!=""&&inputPassWord!="")){
				out.print(inputLoginName);
				pt = new pathTranslator(request.getRealPath("/"), inputLoginName);	
				loginUser = new user(inputLoginName,
			 				    	 inputPassWord,
			  						 pt);
				
				boolean userExist = loginUser.exist();
				HttpSession newSession = request.getSession();

				if(userExist){
					boolean passWordOK = loginUser.checkPassWord(loginUser.getInputPassWord());

					if(passWordOK) {
						loginUser.setLoginState(true);
						newSession.setAttribute("loginUser", loginUser);
					}
				}
			}
		}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="css/template.css" />
<link rel="stylesheet" type="text/css" href="css/residence.css" />
<link rel="stylesheet" type="text/css" href="css/table.css" />
<script type="text/javascript" src="javascript/delayredirect.js"></script>
<title>Web Computing Project by Liu, Chun-Yi</title>
</head>
<body>
<div id="container">
	<table id="header">
	<tr><td class="title" colspan="2"><h1 class="title">Online Residence Application System</h1></td></tr>
	<tr><td class="author" colspan="2">by Liu, Chun-Yi (Candidate Number: 64859)</td></tr>
	<tr>
	<% if(!loginOK){ %>
		<td class="inputbox"><form action="login.jsp" method="post" onsubmit="return checkTop();">
								<input class="username" name="inputLoginNameTop" id="loginNameTop" onfocus="app.clearInput(this);" type="text"/> 
								<input class="password" name="inputPassWordTop" id="passWordTop" onfocus="app.clearInput(this);" type="text"/>
								<input type="submit" value="login"/></form></td>
	<% 
		}
		else{
	%>
		<td class="loginName">Welcome, <%=loginUser.getInputLoginName() %><a href="logout.jsp">(logout)</a></td>
	<%
		}
	%>
	</tr>	
	</table>
	<div id="menu">
		<ul id="onCampusAccommodation">
		<li class="top">Halls on campus</li>
		<li class="item"><a href="<%out.print(urlString+"Brighthelm"); %>">Brighthelm</a></li>
		<li class="item"><a href="<%out.print(urlString+"East_Slope"); %>">East Slope</a></li>
		<li class="item"><a href="<%out.print(urlString+"Lewes_Court"); %>">Lewes Court</a></li>
		<li class="item"><a href="<%out.print(urlString+"Park_Houses"); %>">Park Houses</a></li>
		<li class="item"><a href="<%out.print(urlString+"Park_Village"); %>">Park Village</a></li>
		<li class="item"><a href="<%out.print(urlString+"Stanmer_Court"); %>">Stanmer Court</a></li>
		<li class="item"><a href="<%out.print(urlString+"Swanborough"); %>">Swanborough</a></li>						
	</ul>

	<ul id="offCampusAccommodation">
		<li class="top">Halls off campus</li>
		<li class="item"><a href="<%out.print(urlString+"Kings_Road"); %>">King's Road</a></li>
	</ul>

	<ul id="doApply">
		<li class="top">Apply for it!</li>
		<li class="item"><a href="form.jsp">Application form</a></li>
	</ul>

	<ul id="about">
		<li class="top">About this project</li>
		<li class="item"><a href="cl304.zip">source code</a></li>
		<li class="item"><a href="Solution Report.pdf">solution report</a></li>
		<li class="item"><a href="data/user-name.sample.xml">user-name.xml</a></li>
		<li class="item"><a href="data/applicant.dtd">DTD file to against user-name.xml</a></li>	
		<li class="item"><a href="data/applicant.dtd.txt">applicant.dtd.txt</a></li>			
		<li class="item"><a href="data/residence.sample.xml">residence.xml</a></li>
		<li class="item"><a href="data/residence.dtd">DTD file to against residence.xml</a></li>
		<li class="item"><a href="data/residence.dtd.txt">residence.dtd.txt</a></li>		
		<li class="item"><a href="tree.txt">the hierarchy structure of this project</a></li>
	</ul>
</div>
<div class="clear"></div>

<div id="content">
	<table class="residenceInfo">
	<tr><th id="hallName" class="custom" colspan="2"><%=hallName %></th></tr>
	<tr class="custom"><td class="images" colspan="2"><img src="<%out.print(imagePath+residence.getImage1()); %>" /><img src="<%out.print(imagePath+residence.getImage2()); %>" /></td></tr>
	<tr><th id="briefIntro" class="custom" colspan="2">Brief Introduction</th></tr>
	<tr class="custom"><td colspan="2"><p><%=residence.getDescription() %></p></td></tr>
	<tr>
		<td id="tdHeader">Allocate to:</td>
		<td><%=residence.getAllocateTo() %></td>
	</tr>
	<tr class="custom">
		<td id="tdHeader">Tendancy:</td>
		<td><%=residence.getTendancy() %></td>
	</tr>
	<tr>
		<td id="tdHeader">Rent:</td>
		<td><%=residence.getRent() %></td>
	</tr>
	<tr class="custom">
		<td id="tdHeader">Room Type:</td>
		<td><%=residence.getRoomType() %></td>
	</tr>
	</table>
</div>
</div>
</body>
</html>