package com.swiftbus.model;

public class Booking {
	// From bookings table
    private int bookingId;
    private int userId;
    private int scheduleId;
    private String travelDate;
    private int numberOfSeats;
    private String bookingTime;
    private String status;

    // From bookings_view
    private String userName;
    private String userEmail;
    private String busNumber;
    private String startLocation;
    private String endLocation;
    private double ticketPrice;
    private String startTime;
    private String arrivalTime;
    
	public int getBookingId() {
		return bookingId;
	}
	public int getUserId() {
		return userId;
	}
	public int getScheduleId() {
		return scheduleId;
	}
	public String getTravelDate() {
		return travelDate;
	}
	public int getNumberOfSeats() {
		return numberOfSeats;
	}
	public String getBookingTime() {
		return bookingTime;
	}
	public String getStatus() {
		return status;
	}
	public String getUserName() {
		return userName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public String getBusNumber() {
		return busNumber;
	}
	public String getStartLocation() {
		return startLocation;
	}
	public String getEndLocation() {
		return endLocation;
	}
	public double getTicketPrice() {
		return ticketPrice;
	}
	public String getStartTime() {
		return startTime;
	}
	public String getArrivalTime() {
		return arrivalTime;
	}
	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public void setScheduleId(int scheduleId) {
		this.scheduleId = scheduleId;
	}
	public void setTravelDate(String travelDate) {
		this.travelDate = travelDate;
	}
	public void setNumberOfSeats(int numberOfSeats) {
		this.numberOfSeats = numberOfSeats;
	}
	public void setBookingTime(String bookingTime) {
		this.bookingTime = bookingTime;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public void setBusNumber(String busNumber) {
		this.busNumber = busNumber;
	}
	public void setStartLocation(String startLocation) {
		this.startLocation = startLocation;
	}
	public void setEndLocation(String endLocation) {
		this.endLocation = endLocation;
	}
	public void setTicketPrice(double ticketPrice) {
		this.ticketPrice = ticketPrice;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public void setArrivalTime(String arrivalTime) {
		this.arrivalTime = arrivalTime;
	}
}