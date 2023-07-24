package ssg.com.a.dto;

import java.io.Serializable;
import java.util.Date;

public class stocksDto implements Serializable{

	private String Symbol;
	private String Market;
	private String Name;
	private String Sector;
	private String Industry;
	private Date ListingDate;
	private String SettleMonth;
	private String Representative;
	private String HomePage;
	
	public stocksDto() {
	}
	
	public stocksDto(String symbol, String market, String name, String sector, String industry, Date listingDate,
			String settleMonth, String representative, String homePage) {
		super();
		Symbol = symbol;
		Market = market;
		Name = name;
		Sector = sector;
		Industry = industry;
		ListingDate = listingDate;
		SettleMonth = settleMonth;
		Representative = representative;
		HomePage = homePage;
	}

	public String getSymbol() {
		return Symbol;
	}

	public void setSymbol(String symbol) {
		Symbol = symbol;
	}

	public String getMarket() {
		return Market;
	}

	public void setMarket(String market) {
		Market = market;
	}

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}

	public String getSector() {
		return Sector;
	}

	public void setSector(String sector) {
		Sector = sector;
	}

	public String getIndustry() {
		return Industry;
	}

	public void setIndustry(String industry) {
		Industry = industry;
	}

	public Date getListingDate() {
		return ListingDate;
	}

	public void setListingDate(Date listingDate) {
		ListingDate = listingDate;
	}

	public String getSettleMonth() {
		return SettleMonth;
	}

	public void setSettleMonth(String settleMonth) {
		SettleMonth = settleMonth;
	}

	public String getRepresentative() {
		return Representative;
	}

	public void setRepresentative(String representative) {
		Representative = representative;
	}

	public String getHomePage() {
		return HomePage;
	}

	public void setHomePage(String homePage) {
		HomePage = homePage;
	}


	@Override
	public String toString() {
		return "stocksDto [Symbol=" + Symbol + ", Market=" + Market + ", Name=" + Name + ", Sector=" + Sector
				+ ", Industry=" + Industry + ", ListingDate=" + ListingDate + ", SettleMonth=" + SettleMonth
				+ ", Representative=" + Representative + ", HomePage=" + HomePage + "]";
	}	
	
}
