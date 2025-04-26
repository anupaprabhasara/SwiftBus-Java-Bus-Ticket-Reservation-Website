package com.swiftbus.model;

public class Admin {
	private int adminId;
    private String username;
    private String email;
    private String password;
    private String createdAt;
    
	public int getAdminId() {
		return adminId;
	}
	public String getUsername() {
		return username;
	}
	public String getEmail() {
		return email;
	}
	public String getPassword() {
		return password;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
}