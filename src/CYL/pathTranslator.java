package CYL;

/*
 * this class simply changes the path of data storage used by JSP pages 
 */
public class pathTranslator {
	private String XMLPath;
	private String hallImagePath;
	private String loginName;
	private String DTDFilePath;
	private String residenceXMLPath;
	
	/*
	 * constructor
	 */
	public pathTranslator(String severPath, String inputLoginName){
		String dataPath = "data/";
		String residenceImagePathString ="residences/images/";
		String dtdFileName = "applicant.dtd"; 
		String residenceFileName = "residences.xml";
		//String residenceFileName = "test.xml";
		
		setDTDFilePath(severPath+dataPath+dtdFileName);
		setXMLPath(severPath+dataPath);
		setHallImagePath(residenceImagePathString);
		setLoginName(inputLoginName);
		setResidenceXMLPath(severPath+dataPath+residenceFileName);
	}

	/*
	 * getter and setter
	 */
	public void setXMLPath(String xMLPath) {
		XMLPath = xMLPath;
	}
	
	public String getXMLFilePath(){
		return XMLPath+getLoginName()+".xml";
	}
	
	public String getXMLPath() {
		return XMLPath;
	}

	public void setHallImagePath(String hallImagePath) {
		this.hallImagePath = hallImagePath;
	}

	public String getHallImagePath() {
		return hallImagePath;
	}

	public void setLoginName(String inputLoginName){
		loginName=inputLoginName;
	}
	public String getLoginName(){
		return loginName;
	}

	public void setDTDFilePath(String dTDFilePath) {
		DTDFilePath = dTDFilePath;
	}

	public String getDTDFilePath() {
		return DTDFilePath;
	}

	public void setResidenceXMLPath(String residenceXMLPath) {
		this.residenceXMLPath = residenceXMLPath;
	}

	public String getResidenceXMLPath() {
		return residenceXMLPath;
	}
}
