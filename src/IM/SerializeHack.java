package IM;

import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import java.io.File;

// modified from code at 
// http://www.cafeconleche.org/books/xmljava/chapters/ch09s09.html

public class SerializeHack {

	Document doc;
	File out;
	String DTDFilePath;

	public SerializeHack(Document doc, File out, String DTDFilePath) {
		this.doc = doc;
		this.out = out;
		this.DTDFilePath = DTDFilePath;
	}

	public boolean write() {
		try {
			// Write the document using an identity transform
			TransformerFactory xformFactory = TransformerFactory.newInstance();
			Transformer idTransform = xformFactory.newTransformer();
			Source input = new DOMSource(doc);
			Result output = new StreamResult(out);
			idTransform.setOutputProperty(OutputKeys.DOCTYPE_SYSTEM,DTDFilePath);
			idTransform.transform(input, output);
		} catch (TransformerFactoryConfigurationError e) {
			System.out.println("Could not locate a factory class");
			return false;
		} catch (TransformerConfigurationException e) {
			System.out.println("This DOM does not support transforms.");
			return false;
		} catch (TransformerException e) {
			e.printStackTrace();
			System.out.println("Transform failed.");
			return false;
		}
		return true;
	}
}