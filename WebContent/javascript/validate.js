var app = new WebForm();	

function init() {
}

function WebForm() {
	var submitButton = "submitButton";
	var titleId = "title";
	var firstNameId = "firstName";
	var lastNameId = "lastName";
	var emailId = "email";
	var canNumberId = "canNumber";
	var firstChoiseId = "firstChoise";
	var secondChoiseId = "secondChoise";
	var thirdChoiseId = "thirdChoise";
	var loginNameId = "loginName";
	var passWordId = "passWord";
	var passWordTopId = "passWordTop";
	var reEnterPassWordId = "reEnterPassWord";
	
	var checkFirstNameRe = "^([a-zA-Z\\-][\\s]?){1,128}\$";
	var checkLastNameRe = checkFirstNameRe;
	var checkEmailRe = "^(\\w+)\\@(\\w+\\.)+(\\w+)$";
	var checkCanNumberRe = "^\\d{8}\$";
	var checkLoginNameRe = "^[0-9a-zA-Z\\_s]{5,128}\$";
	var checkPassWordRe = "^[^~`\.\?\0\r\n\t\v]{5,128}\$";
	
	// private function
	var getOKSpanID = function(id){
		return id+'OKSpan';
	};
	
	var getErrSpanID = function(){
		return 'errSpan';
	};
	
	var checkOK = function(OK, spanID, errSpanID, errMsg) {
		if(OK) {
			document.getElementById(errSpanID).style.color="white";
			document.getElementById(spanID).style.color="green";
		}
		else{
			document.getElementById(spanID).style.color="white";
			document.getElementById(errSpanID).innerHTML=errMsg;
			document.getElementById(errSpanID).style.color="red";
		}
	};
	
	var validate = function(regExp, element, errMsg){
		var re = new RegExp(regExp);
		var matched = re.exec(element.value);
		var ID = element.id;
		var spanID = getOKSpanID(element.id);
		var errSpanID = getErrSpanID();
		var OK = false;
						
		if(matched) {
			OK = true;
		}
		
		checkOK(OK, spanID, errSpanID, errMsg);
		
		return OK;
	};
		
	this.checkFirstName = function() {
		var re = checkFirstNameRe;
		var element = document.getElementById(firstNameId);
		var errMsg = element.value+": should be a-z, A-Z,\'-\' and space.";
		return validate(re, element, errMsg);
	};
	
	this.checkLastName = function() {
		var re = checkLastNameRe;
		var element = document.getElementById(lastNameId);
		var errMsg = element.value+": should be a-z, A-Z,\'-\' and space.";
		return validate(re, element, errMsg);
	};
	
	this.checkEmail = function() {
		var re = checkEmailRe;
		var element = document.getElementById(emailId);
		var errMsg = "incorrect email adddress: "+element.value;
		return validate(re, element, errMsg);
	};
	
	this.checkCanNumber = function() {
		var re = checkCanNumberRe;
		var element = document.getElementById(canNumberId);
		var errMsg = "it should be exactly 8 digits.";
		return validate(re, element, errMsg);
	};
	
	this.checkLoginName = function() {
		var re = checkLoginNameRe;
		var element = document.getElementById(loginNameId);
		var errMsg = "5+ characters, 0-9, a-z, A-Z, \'_\' and no space."
		return validate(re, element, errMsg);
	};
	
	this.checkPassWord = function() {
		var re = checkPassWordRe;
		var element = document.getElementById(passWordId);
		var errMsg = "5+ characters without ~, `, \\, \., ?, \\r, \\n, \\t, \\v"
		return validate(re, element, errMsg);
	};
	
	this.checkLoginNameTop = function(){
		var element = document.getElementById(loginNameTop);
		var re = new RegExp(checkPassWordRe);
		var matched = re.exec(element.value);
		var OK = false;
		
		if(matched){
			OK = true;;
		}
		return OK;		
	}
	
	this.checkPassWordTop = function(){
		var element = document.getElementById(passWordTopId);
		var re = new RegExp(checkPassWordRe);
		var matched = re.exec(element.value);
		var OK = false;
		
		if(matched){
			OK = true;;
		}
		return OK;
	};
	
	this.checkReEnterPassWord = function(passWord, reEnterPassWord) {
		var ID = reEnterPassWordId;
		var spanID = getOKSpanID(ID);
		var errSpanID = getErrSpanID();
		var errMsg = "the password is not match, please enter it again."
		var OK = false;
		
		if(passWord==reEnterPassWord){
			OK = true;
		}
		
		checkOK(OK, spanID, errSpanID, errMsg);
		
		return OK;
	};
	
	this.checkList = function(element) {
		var ID = element.id;
		var spanID = getOKSpanID(element.id);
		var errSpanID=getErrSpanID();
		var value = element.value;
		var errMsg = "please select one.";
		var OK = false;
		
		if(value!="nochoise") {
			OK = true;
		}
		
		checkOK(OK, spanID, errSpanID, errMsg);
		
		return OK;
	};
	
	this.clearInput = function(element){
		document.getElementById(element.id).value="";
		var spanID = getOKSpanID(element.id);
		document.getElementById(spanID).style.color="";
	};
	
	this.checkForm = function(){
		var submitOK = this.checkList(document.getElementById(titleId))&&
					   this.checkFirstName()&&
					   this.checkLastName()&&
					   this.checkEmail()&&
					   this.checkCanNumber()&&
					   this.checkLoginName()&&
					   this.checkPassWord()&&
					   this.checkReEnterPassWord()&&
					   this.checkList(document.getElementById(firstChoiseId))&&
					   this.checkList(document.getElementById(secondChoiseId))&&
					   this.checkList(document.getElementById(thirdChoiseId));
					   
		return submitOK;
	};
	
	this.checkPasswordField = function(){
		var submitOK = this.checkLoginName()&&
					   this.checkPassWord();
		return submitOK;
	};
	
	this.checkTop = function(){
		var submitOK = this.checkLoginNameTop()&&
					   this.checkPassWordTop();
		return submitOK;
	}
}