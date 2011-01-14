package CYL;

import java.util.ArrayList;

import org.w3c.dom.Node;

public class Residence {
	private String onCampus;
	private String name;
	private String description;
	private String handBook;
	private String tendancy;
	private String rent;
	private String roomType;
	private String allocateTo;
	private String image1;
	private String image2;
	
	public Residence(){
		
	}
	
	public Residence(String onCampus,
					 String name,
					 String description,
					 String handBook,
					 String tendancy,
					 String rent,
					 String roomType,
					 String allocateTo,
					 String image1,
					 String image2){
		this.setOnCampus(onCampus);
		this.name = name;
		this.description =description;
		this.handBook = handBook;
		this.tendancy = tendancy;
		this.rent = rent;
		this.roomType = roomType;
		this.allocateTo = allocateTo;
		this.setImage1(image1);
		this.setImage2(image2);
	}

	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDescription() {
		return description;
	}
	public void setHandBook(String handBook) {
		this.handBook = handBook;
	}
	public String getHandBook() {
		return handBook;
	}
	public void setTendancy(String tendancy) {
		this.tendancy = tendancy;
	}
	public String getTendancy() {
		return tendancy;
	}
	public void setRent(String rent) {
		this.rent = rent;
	}
	public String getRent() {
		return rent;
	}
	public void setRoolType(String roomType) {
		this.roomType = roomType;
	}
	public String getRoomType() {
		return roomType;
	}
	public void setAllocateTo(String allocateTo) {
		this.allocateTo = allocateTo;
	}
	public String getAllocateTo() {
		return allocateTo;
	}
	public void setOnCampus(String onCampus) {
		this.onCampus = onCampus;
	}

	public String getOnCampus() {
		return onCampus;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage2(String image2) {
		this.image2 = image2;
	}

	public String getImage2() {
		return image2;
	}
}
