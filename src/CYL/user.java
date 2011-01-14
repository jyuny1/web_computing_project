package CYL;

import java.io.File;

public class user {
	private String inputLoginName;
	private String inputPassWord;
	private boolean loginOK;
	private pathTranslator pt;
	private boolean modifyFlag;
	
	public user(String loginName, String passWord, pathTranslator pt){
		setInputLoginName(loginName);
		setInputPassWord(passWord);
		this.pt = pt;
	}
	
	public boolean exist(){
		return (new File(pt.getXMLFilePath()).exists());
	}
	
	public boolean checkPassWord(String inputPassWord) {
		XMLGenerator XMLReader = new XMLGenerator(pt);
		String passWord = XMLReader.getPassWord();		
		
		if(inputPassWord.equals(passWord)){
			return true;
		}
		else {
			return false;
		}
	}
	/*
	 * getter and setter
	 */
	public void setInputLoginName(String inputLoginName) {
		this.inputLoginName = inputLoginName;
	}
	public String getInputLoginName() {
		return inputLoginName;
	}
	public void setInputPassWord(String inputPassWord) {
		this.inputPassWord = inputPassWord;
	}
	public String getInputPassWord() {
		return inputPassWord;
	}
	public pathTranslator getPathTranslator(){
		return pt;
	}

	public void setLoginState(boolean loginOK) {
		this.loginOK = loginOK;
	}

	public boolean isLoginOK() {
		return loginOK;
	}

	public void setModifyFlag(boolean modifyFlag) {
		this.modifyFlag = modifyFlag;
	}

	public boolean getModifyFlag() {
		return modifyFlag;
	}
}
