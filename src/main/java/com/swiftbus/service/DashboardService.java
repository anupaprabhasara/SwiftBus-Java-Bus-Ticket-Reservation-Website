package com.swiftbus.service;

import com.swiftbus.model.Booking;
import com.swiftbus.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DashboardService {

    public int getTotalUsers() {
        return getCount("SELECT COUNT(*) FROM users");
    }

    public int getTotalBuses() {
        return getCount("SELECT COUNT(*) FROM buses");
    }

    public int getTotalRoutes() {
        return getCount("SELECT COUNT(*) FROM routes");
    }

    public int getTotalBookings() {
        return getCount("SELECT COUNT(*) FROM bookings");
    }

    public List<Booking> getLatestBookings() {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings_view ORDER BY booking_time DESC LIMIT 3";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getInt("booking_id"));
                b.setUserName(rs.getString("user_name"));
                b.setUserEmail(rs.getString("user_email"));
                b.setBusNumber(rs.getString("bus_number"));
                b.setStartLocation(rs.getString("start_location"));
                b.setEndLocation(rs.getString("end_location"));
                b.setTicketPrice(rs.getDouble("ticket_price"));
                b.setTravelDate(rs.getString("travel_date"));
                b.setStartTime(rs.getString("start_time"));
                b.setArrivalTime(rs.getString("arrival_time"));
                b.setNumberOfSeats(rs.getInt("number_of_seats"));
                b.setBookingTime(rs.getString("booking_time"));
                b.setStatus(rs.getString("status"));
                bookings.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    private int getCount(String query) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}