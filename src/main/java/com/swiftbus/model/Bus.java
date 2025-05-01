package com.swiftbus.model;

public class Bus {
	private int busId;
    private String busNumber;
    private int totalSeats;
    
	public int getBusId() {
		return busId;
	}
	public String getBusNumber() {
		return busNumber;
	}
	public int getTotalSeats() {
		return totalSeats;
	}
	public void setBusId(int busId) {
		this.busId = busId;
	}
	public void setBusNumber(String busNumber) {
		this.busNumber = busNumber;
	}
	public void setTotalSeats(int totalSeats) {
		this.totalSeats = totalSeats;
	}
}