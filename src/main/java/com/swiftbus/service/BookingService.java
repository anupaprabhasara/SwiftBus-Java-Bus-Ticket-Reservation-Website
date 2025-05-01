package com.swiftbus.service;

import com.swiftbus.model.Booking;
import com.swiftbus.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingService {

    // Create Booking
    public boolean createBooking(Booking booking) {
        String query = "INSERT INTO bookings (user_id, schedule_id, travel_date, number_of_seats, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, booking.getUserId());
            stmt.setInt(2, booking.getScheduleId());
            stmt.setString(3, booking.getTravelDate());
            stmt.setInt(4, booking.getNumberOfSeats());
            stmt.setString(5, booking.getStatus());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get All Bookings (from view)
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings_view ORDER BY booking_id";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserName(rs.getString("user_name"));
                booking.setUserEmail(rs.getString("user_email"));
                booking.setBusNumber(rs.getString("bus_number"));
                booking.setStartLocation(rs.getString("start_location"));
                booking.setEndLocation(rs.getString("end_location"));
                booking.setTicketPrice(rs.getDouble("ticket_price"));
                booking.setTravelDate(rs.getString("travel_date"));
                booking.setStartTime(rs.getString("start_time"));
                booking.setArrivalTime(rs.getString("arrival_time"));
                booking.setNumberOfSeats(rs.getInt("number_of_seats"));
                booking.setBookingTime(rs.getString("booking_time"));
                booking.setStatus(rs.getString("status"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Get Booking by ID (from view)
    public Booking getBookingById(int id) {
        String query = "SELECT * FROM bookings_view WHERE booking_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserName(rs.getString("user_name"));
                booking.setUserEmail(rs.getString("user_email"));
                booking.setBusNumber(rs.getString("bus_number"));
                booking.setStartLocation(rs.getString("start_location"));
                booking.setEndLocation(rs.getString("end_location"));
                booking.setTicketPrice(rs.getDouble("ticket_price"));
                booking.setTravelDate(rs.getString("travel_date"));
                booking.setStartTime(rs.getString("start_time"));
                booking.setArrivalTime(rs.getString("arrival_time"));
                booking.setNumberOfSeats(rs.getInt("number_of_seats"));
                booking.setBookingTime(rs.getString("booking_time"));
                booking.setStatus(rs.getString("status"));
                return booking;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update Booking
    public boolean updateBooking(Booking booking) {
        String query = "UPDATE bookings SET status = ? WHERE booking_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, booking.getStatus());
            stmt.setInt(2, booking.getBookingId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Booking
    public boolean deleteBooking(int id) {
        String query = "DELETE FROM bookings WHERE booking_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}