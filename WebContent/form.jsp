<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="CYL.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
	//check user has logged-in or not	
	HttpSession localSession = request.getSession();
	user loginUser = (user) localSession.getAttribute("loginUser");
	FormOperator formOperator = new FormOperator();
	webForm applicationForm=new webForm();
	String urlString = "residence.jsp?residence=";	
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
			pathTranslator pt = new pathTranslator(request.getRealPath("/"), inputLoginName);	
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
		<script type="text/javascript" src="javascript/validate.js"></script>
		<link rel="stylesheet" type="text/css" href="css/template.css" />
    	<link rel="stylesheet" type="text/css" href="css/form.css" />
    	<link rel="stylesheet" type="text/css" href="css/table.css" />
		<title>Web Computing Project by Liu, Chun-Yi</title>
	</head>
 <body onload="init();">
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
		<li class="item"><a href="#">King's Road</a></li>
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
 	<form name="applicationForm" action="apply.jsp" method="post" onsubmit="return app.checkForm(this);">
  		<table class="applicationForm" name="applicationTable" border="0">
  			<tr><th class="custom" colspan="2">Personal Detail</th></tr>
  				<tr>
  				<td align="right">Title:</td>
  				<td><select id="title" name="inputTitle" onchange="app.checkList(this);">
  							<option value="nochoise">----choose a title----</option>
							<option value="Mr." <%=formOperator.getSelectedList("Mr.", applicationForm.getTitle()) %>>Mr.</option>
							<option value="Mrs." <%=formOperator.getSelectedList("Mrs.", applicationForm.getTitle()) %>>Mrs.</option>
							<option value="Ms." <%=formOperator.getSelectedList("Ms.", applicationForm.getTitle()) %>>Ms.</option>
   				    </select>
   				</td>
   				<td><span id="titleOKSpan">√</span></td>
   			</tr>
	   		<tr>
   				<td align="right">First Name: </td>
   				<td><input type="text" id="firstName" name="inputFirstName" onfocus="app.clearInput(this);" onchange="app.checkFirstName ();" <%=formOperator.getInputValue(applicationForm.getFirstName()) %>/></td>
   				<td><span id="firstNameOKSpan">√</span></td>
   			</tr>
   			<tr>
   				<td align="right">Last Name: </td>
   				<td><input type="text" id="lastName" name="inputLastName" onfocus="app.clearInput(this);" onchange="app.checkLastName ();" <%=formOperator.getInputValue(applicationForm.getLastName()) %>/></td>
   				<td><span id="lastNameOKSpan">√</span></td>
   			</tr>
   			<tr>
   				<td align="right">E-Mail: </td>
   				<td><input type="text" id="email" name="inputEmail" onfocus="app.clearInput(this);" onchange="app.checkEmail ();" <%=formOperator.getInputValue(applicationForm.getEmail()) %>/></td>
   				<td><span id="emailOKSpan">√</span></td>
   			</tr>
   			<tr>
   				<td align="right">Candidate Number: </td>
   				<td><input type="text" id="canNumber" name="inputCanNumber" onfocus="app.clearInput(this);" onchange="app.checkCanNumber ();" <%=formOperator.getInputValue(applicationForm.getCanNumber()) %>/></td>
   				<td><span id="canNumberOKSpan">√</span></td>
  			</tr>
  			<tr><th colspan="2" class="custom">Hall Preference</th></tr>
  			<tr>
  				<td align="right">1st choise:</td>
  				<td>
  					<select id="firstChoise" name="inputFirstChoise" onchange="app.checkList(this);">
						<option value="nochoise" >----On Campus----</option>
						<option value="Swanborough" <%=formOperator.getSelectedList("Swanborough", applicationForm.getFirstChoise()) %>>Swanborough</option>
						<option value="Brighthelm" <%=formOperator.getSelectedList("Brighthelm", applicationForm.getFirstChoise()) %>>Brighthlem</option>
						<option value="EastSlope" <%=formOperator.getSelectedList("EastSlope", applicationForm.getFirstChoise()) %>>East Slope</option>
						<option value="StanmerCourt" <%=formOperator.getSelectedList("StanmerCourt", applicationForm.getFirstChoise()) %>>Stanmer Court</option>
						<option value="LewesCourt" <%=formOperator.getSelectedList("LewesCourt", applicationForm.getFirstChoise()) %>>Lewes Court</option>
						<option value="ParkHouses" <%=formOperator.getSelectedList("ParkHouses", applicationForm.getFirstChoise()) %>>Park Houses</option>
						<option value="ParkVillage" <%=formOperator.getSelectedList("ParkVillage", applicationForm.getFirstChoise()) %>>Park Village</option>
						<option value="nochoise">----Off Campus----</option>
						<option value="KingsRoad" <%=formOperator.getSelectedList("KingsRoad", applicationForm.getFirstChoise()) %>>King's Road</option>
					  </select>	
  				</td>
  				<td><span id="firstChoiseOKSpan">√</span></td>
  			</tr>
  			<tr>
  				<td align="right">2nd choise:</td>
  				<td>
  					<select id="secondChoise" name="inputSecondChoise" onchange="app.checkList(this);">
						<option value="nochoise" >----On Campus----</option>
						<option value="Swanborough" <%=formOperator.getSelectedList("Swanborough", applicationForm.getSecondChoise()) %>>Swanborough</option>
						<option value="Brighthelm" <%=formOperator.getSelectedList("Brighthelm", applicationForm.getSecondChoise()) %>>Brighthlem</option>
						<option value="EastSlope" <%=formOperator.getSelectedList("EastSlope", applicationForm.getSecondChoise()) %>>East Slope</option>
						<option value="StanmerCourt" <%=formOperator.getSelectedList("StanmerCourt", applicationForm.getSecondChoise()) %>>Stanmer Court</option>
						<option value="LewesCourt" <%=formOperator.getSelectedList("LewesCourt", applicationForm.getSecondChoise()) %>>Lewes Court</option>
						<option value="ParkHouses" <%=formOperator.getSelectedList("ParkHouses", applicationForm.getSecondChoise()) %>>Park Houses</option>
						<option value="ParkVillage" <%=formOperator.getSelectedList("ParkVillage", applicationForm.getSecondChoise()) %>>Park Village</option>
						<option value="nochoise">----Off Campus----</option>
						<option value="KingsRoad" <%=formOperator.getSelectedList("KingsRoad", applicationForm.getFirstChoise()) %>>King's Road</option>
					  </select>	 			
  				</td>
  				<td><span id="secondChoiseOKSpan">√</span></td>
  			</tr>
  			<tr	>
  				<td align="right">3rd choise:</td>
	  			<td>
  					<select id="thirdChoise" name="inputThirdChoise" onchange="app.checkList(this);">
						<option value="nochoise" >----On Campus----</option>
						<option value="Swanborough" <%=formOperator.getSelectedList("Swanborough", applicationForm.getThirdChoise()) %>>Swanborough</option>
						<option value="Brighthelm" <%=formOperator.getSelectedList("Brighthelm", applicationForm.getThirdChoise()) %>>Brighthlem</option>
						<option value="EastSlope" <%=formOperator.getSelectedList("EastSlope", applicationForm.getThirdChoise()) %>>East Slope</option>
						<option value="StanmerCourt" <%=formOperator.getSelectedList("StanmerCourt", applicationForm.getThirdChoise()) %>>Stanmer Court</option>
						<option value="LewesCourt" <%=formOperator.getSelectedList("LewesCourt", applicationForm.getThirdChoise()) %>>Lewes Court</option>
						<option value="ParkHouses" <%=formOperator.getSelectedList("ParkHouses", applicationForm.getThirdChoise()) %>>Park Houses</option>
						<option value="ParkVillage" <%=formOperator.getSelectedList("ParkVillage", applicationForm.getThirdChoise()) %>>Park Village</option>
						<option value="nochoise">----Off Campus----</option>
						<option value="KingsRoad" <%=formOperator.getSelectedList("KingsRoad", applicationForm.getThirdChoise()) %>>King's Road</option>

					  </select>	 			
  				</td>
  				<td><span id="thirdChoiseOKSpan">√</span></td>
  			</tr>
  			<tr><th colspan="2" class="custom">Login Detail</th></tr>
  			<tr>
  				<td align="right">User Name: </td>
  				<td><input type="text" id="loginName" name="inputLoginName" onfocus="app.clearInput(this);" onchange="app.checkLoginName();" <%=formOperator.getInputValue(applicationForm.getLoginName()) %>/></td>
  				<td><span id="loginNameOKSpan">√</span></td>
  			</tr>
  			<tr>
  				<td align="right">Password: </td>
  				<td><input type="text" id="passWord" name="inputPassWord" onfocus="app.clearInput(this);" onchange="app.checkPassWord();" <%=formOperator.getInputValue(applicationForm.getPassWord()) %>/></td>
  				<td><span id="passWordOKSpan">√</span></td>
  			</tr>
  			<tr>
  				<td align="right">Re-enter Password: </td>
  				<td><input type="text" id="reEnterPassWord" onfocus="app.clearInput(this);" onfocus="app.clearInput(this);" onchange="app.checkReEnterPassWord(applicationForm.passWord.value, this.value);"/></td>
  				<!-- <td><span id="entPassWordOKSpan"></span>√</td> -->
  			</tr>
  			<tr><td colspan="2"><span id="errSpan">test</span></td></tr>
  			<tr><td colspan="2" align="center"><input type="submit" id="submitButton" value="Submit it!"/></td></tr>
  		</table>	 
 	 </form>
</div>
  </body>
</html>