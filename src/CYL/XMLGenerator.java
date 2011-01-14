package CYL;

import java.io.File;
import java.io.IOException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;
import org.xml.sax.SAXException;

import IM.SerializeHack;

/*
 * this class will handle how to read/write XML
 */
public class XMLGenerator {
	/*
	 * the tag name of XML file for accommodation applicants
 	 */
	private static String applicantXMLTag = "applicant";
	private static String titleXMLTag = "title";
	private static String firstNameXMLTag = "firstName";
	private static String lastNameXMLTag = "lastName";
	private static String emailXMLTag = "email";
	private static String canNumberXMLTag = "canNumber";
	private static String firstChoiseXMLTag = "firstChoise";
	private static String secondChoiseXMLTag = "secondChoise";
	private static String thirdChoiseXMLTag = "thirdChoise";
	private static String loginNameXMLTag = "loginName";
	private static String passWordXMLTag = "passWord";
	
	private webForm webForm;
	private String XMLFilePath;
	private String DTDFilePath;
	private pathTranslator pt;
	
   /*
	* the constructor
	*/
	public XMLGenerator(webForm webForm, pathTranslator pt){
		this.webForm = webForm;
		this.pt = pt;
		this.XMLFilePath = pt.getXMLFilePath();
		this.DTDFilePath = pt.getDTDFilePath();
	}
	
	public XMLGenerator(pathTranslator pt){
		this.webForm = null;
		this.pt = pt;
		this.XMLFilePath = pt.getXMLFilePath();
	}
	
	/*
	public static void main(String[] args) {
		pathTranslator pt = new pathTranslator("/Applications/eclipse/workspace/cl304/WebContent/", "tester");
		XMLGenerator tester = new XMLGenerator(pt);
		tester.getResidenceInfo("Kings_Road");		
	}
	*/
	
	/*
	 * create an empty DOM
	 */
	private Document initNewDoc() {
		DocumentBuilderFactory factory;
		DocumentBuilder builder = null;
		Document doc = null;
		
		try {
			factory = DocumentBuilderFactory.newInstance();
			builder = factory.newDocumentBuilder();
			doc = builder.newDocument();
		} catch (FactoryConfigurationError fce) {
			System.err.println("Could not create DocumentBuilderFactory");
		} catch (ParserConfigurationException pce) {
			System.out.println("Could not locate a JAXP parser");
		}
		
		return doc;								
	}
	
	/*
	 * read an XML file which exists on server;
	 */
	private Document initDoc(){
		DocumentBuilderFactory factory;
		DocumentBuilder builder = null;
		Document doc = null;
		
		try {
			factory = DocumentBuilderFactory.newInstance();
			builder = factory.newDocumentBuilder();
			doc = builder.parse(new File(this.XMLFilePath));
		} catch (FactoryConfigurationError fce) {
			System.err.println("Could not create DocumentBuilderFactory");
		} catch (ParserConfigurationException pce) {
			System.out.println("Could not locate a JAXP parser");
		} catch (SAXException se) {
			System.out.println("XML file is not well-formed.");
		} catch (IOException ioe) {
			System.out.println("Due to an IOException, the parser could not read the XML file:"+this.XMLFilePath);
		}
		
		return doc;
	}
	
	private Document initDoc(String filePath){
		DocumentBuilderFactory factory;
		DocumentBuilder builder = null;
		Document doc = null;
		
		try {
			factory = DocumentBuilderFactory.newInstance();
			builder = factory.newDocumentBuilder();
			doc = builder.parse(new File(filePath));
		} catch (FactoryConfigurationError fce) {
			System.err.println("Could not create DocumentBuilderFactory");
		} catch (ParserConfigurationException pce) {
			System.out.println("Could not locate a JAXP parser");
		} catch (SAXException se) {
			System.out.println("XML file is not well-formed.");
		} catch (IOException ioe) {
			System.out.println("Due to an IOException, the parser could not read the XML file:"+filePath);
			ioe.printStackTrace();
		}
		
		return doc;
	}
	
	private String getNodeContent(Document document, String targetXMLTag) {
		NodeList nodeList = document.getElementsByTagName(targetXMLTag);
		Node node = nodeList.item(0);
		Text nodeText = (Text) node.getChildNodes().item(0);
		String nodeTextContent = nodeText.getNodeValue();

		return nodeTextContent;
	}
	/*
	 * to read XML and return a DOM object
	 * @return webForm: form exit
	 * 		   null: form does not exit
	 */
	public webForm readWebForm(){
		boolean isExist = new File(this.XMLFilePath).exists();
		
		if(isExist){
			Document document = initDoc();
			
			return (new webForm(getNodeContent(document, titleXMLTag),
					getNodeContent(document, firstNameXMLTag),
					getNodeContent(document, lastNameXMLTag),
					getNodeContent(document, emailXMLTag),
					getNodeContent(document, canNumberXMLTag),
					getNodeContent(document, firstChoiseXMLTag),
					getNodeContent(document, secondChoiseXMLTag),
					getNodeContent(document, thirdChoiseXMLTag),
					getNodeContent(document, loginNameXMLTag),
					getNodeContent(document, passWordXMLTag)));									
		}
		else {
			return null;
		}
	}
	
	public String getPassWord(){
		webForm userInfo = readWebForm();
		
		if(userInfo != null){
			return userInfo.getPassWord();
		}
		else {
			return null;
		}
	}
	
	/*
	 * this function will write form applied form from user to an XML with user-name
	 */
	public boolean writeToXML() {
		/*
		 * get root ready
		 */
		Document newXMLFile = initNewDoc(); //get an empty dom object
		Element root = newXMLFile.createElement(applicantXMLTag);
		newXMLFile.appendChild(root);
		/*
		 * creat elements with tag name
		 */
		Element titleElement = newXMLFile.createElement(titleXMLTag);
		Element firstNameElement = newXMLFile.createElement(firstNameXMLTag);
		Element lastNameElement = newXMLFile.createElement(lastNameXMLTag);
		Element emailElement = newXMLFile.createElement(emailXMLTag);
		Element canNumberElement = newXMLFile.createElement(canNumberXMLTag);
		Element firstChoiseElement = newXMLFile.createElement(firstChoiseXMLTag);
		Element secondChoiseElement = newXMLFile.createElement(secondChoiseXMLTag);
		Element thirdChoiseElement = newXMLFile.createElement(thirdChoiseXMLTag);
		Element loginNameElement = newXMLFile.createElement(loginNameXMLTag);
		Element passWordElement = newXMLFile.createElement(passWordXMLTag);
		/*
		 * assign values to element
		 */
		titleElement.appendChild(newXMLFile.createTextNode(webForm.getTitle()));
		firstNameElement.appendChild(newXMLFile.createTextNode(webForm.getFirstName()));
		lastNameElement.appendChild(newXMLFile.createTextNode(webForm.getLastName()));
		emailElement.appendChild(newXMLFile.createTextNode(webForm.getEmail()));
		canNumberElement.appendChild(newXMLFile.createTextNode(webForm.getCanNumber()));
		firstChoiseElement.appendChild(newXMLFile.createTextNode(webForm.getFirstChoise()));
		secondChoiseElement.appendChild(newXMLFile.createTextNode(webForm.getSecondChoise()));
		thirdChoiseElement.appendChild(newXMLFile.createTextNode(webForm.getThirdChoise()));
		loginNameElement.appendChild(newXMLFile.createTextNode(webForm.getLoginName()));
		passWordElement.appendChild(newXMLFile.createTextNode(webForm.getPassWord()));
		/*
		 * append new elements to roots
		 */
		root.appendChild(titleElement);
		root.appendChild(firstNameElement);
		root.appendChild(lastNameElement);
		root.appendChild(emailElement);
		root.appendChild(canNumberElement);
		root.appendChild(firstChoiseElement);
		root.appendChild(secondChoiseElement);
		root.appendChild(thirdChoiseElement);
		root.appendChild(loginNameElement);
		root.appendChild(passWordElement);
		/*
		 * write to XML file
		 */
		return (new SerializeHack(newXMLFile, new File(this.XMLFilePath), DTDFilePath).write());
	}

	public Residence getResidenceInfo(String residenceName){
		String residenceXMLPath = pt.getResidenceXMLPath();
		boolean isExist = new File(residenceXMLPath).exists();
		Residence residence=null;
		
		int onCampus=0;
		int desc=1;
		int handBook=2;
		int tenancy=3;
		int rent=4;
		int roomType=5;
		int allocateTo=6;
		int image1=7;
		int image2=8;
		
		if(isExist){
			Document document = initDoc(residenceXMLPath);
			
			NodeList halls = document.getElementsByTagName(residenceName);
			//get the name of hall
			String hallName = halls.item(0).getNodeName();
			NodeList hallInfo = halls.item(0).getChildNodes();
			
			//get the hall information
			residence = new Residence(hallInfo.item(onCampus).getTextContent(), 
												hallName,
												hallInfo.item(desc).getTextContent(),
												hallInfo.item(handBook).getTextContent(), 
												hallInfo.item(tenancy).getTextContent(), 
												hallInfo.item(rent).getTextContent(), 
												hallInfo.item(roomType).getTextContent(), 
												hallInfo.item(allocateTo).getTextContent(),
												hallInfo.item(image1).getTextContent(),
												hallInfo.item(image2).getTextContent());
			
		}
		return residence;
	}
}
