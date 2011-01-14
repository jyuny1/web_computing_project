package CYL;

/*
 * 
 */
public class webForm {
	private String title;
	private String firstName;
	private String lastName;
	private String email;
	private String canNumber;
	private String firstChoise;
	private String secondChoise;
	private String thirdChoise;
	private String loginName;
	private String passWord;
		
	/*
	 * constructor for new application form
	 */
	public webForm(String title, String firstName, String lastName, String email,
				   String canNumber, String firstChoise, String secondChoise, String thirdChoise,
				   String loginName, String passWord){
		setTitle(title);
		setFirstName(firstName);
		setLastName(lastName);
		setEmail(email);
		setCanNumber(canNumber);
		setFirstChoise(firstChoise);
		setSecondChoise(secondChoise);
		setThirdChoise(thirdChoise);
		setLoginName(loginName);
		setPassWord(passWord);		
	}	
	
	public webForm(pathTranslator pt){
		webForm formReader = (new XMLGenerator(pt)).readWebForm();
		this.title = formReader.getTitle();
		this.firstName = formReader.getFirstName();
		this.lastName = formReader.getLastName();
		this.email = formReader.getEmail();
		this.canNumber = formReader.getCanNumber();
		this.firstChoise = formReader.getFirstChoise();
		this.secondChoise = formReader.getSecondChoise();
		this.thirdChoise = formReader.getThirdChoise();
		this.loginName = formReader.getLoginName();
		this.passWord = formReader.getPassWord();
	}
	
	public webForm() {
		// TODO Auto-generated constructor stub
	}
	
	/*
	 * method to save form into an XML file
	 */	public boolean toXML(pathTranslator pt){
		XMLGenerator writer = new XMLGenerator(this, pt);
		return writer.writeToXML();
	}
	/*
	 * getters and setter
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail() {
		return email;
	}

	public void setCanNumber(String canNumber) {
		this.canNumber = canNumber;
	}

	public String getCanNumber() {
		return canNumber;
	}

	public void setFirstChoise(String firstChoise) {
		this.firstChoise = firstChoise;
	}

	public String getFirstChoise() {
		return firstChoise;
	}

	public void setSecondChoise(String secondChoise) {
		this.secondChoise = secondChoise;
	}

	public String getSecondChoise() {
		return secondChoise;
	}

	public void setThirdChoise(String thirdChoise) {
		this.thirdChoise = thirdChoise;
	}

	public String getThirdChoise() {
		return thirdChoise;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}

	public String getPassWord() {
		return passWord;
	}
	
	
}
