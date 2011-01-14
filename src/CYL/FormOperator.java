package CYL;

public class FormOperator {
	private String selectList = "selected=\"selected\"";
	private String emptyString = new String();
	private boolean loginOK;
	
	public FormOperator() {
	}
	
	private String getTemplate(String id, String inputField, String attribute){
		if(loginOK){
			if(inputField.equals(id)){
				return attribute;
			}
		}
		return emptyString;
	}
	
	public String getSelectedList(String id, String selectedValue){
		return getTemplate(id, selectedValue, selectList);
	}
	
	public String getInputValue(String inputValue){		
		if(loginOK){
			String inputBoxValue = "value=\""+inputValue+"\"";
			return inputBoxValue;
		}
		return emptyString;
	}

	public void setLoginState(boolean loginOK) {
		this.loginOK = loginOK;
	}

	public boolean isLoginOK() {
		return loginOK;
	}

	public Residence getResidenceInformation(String hallName, pathTranslator pt){
		XMLGenerator reader = new XMLGenerator(pt);
		return reader.getResidenceInfo(hallName);
	}
}
