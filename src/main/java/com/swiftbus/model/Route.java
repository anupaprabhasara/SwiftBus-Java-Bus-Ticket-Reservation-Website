package com.swiftbus.model;

public class Route {
	private int routeId;
    private String startLocation;
    private String endLocation;
    private double ticketPrice;
    
	public int getRouteId() {
		return routeId;
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
	public void setRouteId(int routeId) {
		this.routeId = routeId;
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