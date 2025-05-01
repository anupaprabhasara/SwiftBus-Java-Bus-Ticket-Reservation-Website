package com.swiftbus.model;

public class Schedule {
	// From schedules table
    private int scheduleId;
    private int busId;
    private int routeId;
    private String startTime;
    private String arrivalTime;

    // From schedules_view
    private String busNumber;
    private String startLocation;
    private String endLocation;
    private double ticketPrice;
    
	public int getScheduleId() {
		return scheduleId;
	}
	public int getBusId() {
		return busId;
	}
	public int getRouteId() {
		return routeId;
	}
	public String getStartTime() {
		return startTime;
	}
	public String getArrivalTime() {
		return arrivalTime;
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
	public void setScheduleId(int scheduleId) {
		this.scheduleId = scheduleId;
	}
	public void setBusId(int busId) {
		this.busId = busId;
	}
	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public void setArrivalTime(String arrivalTime) {
		this.arrivalTime = arrivalTime;
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
}