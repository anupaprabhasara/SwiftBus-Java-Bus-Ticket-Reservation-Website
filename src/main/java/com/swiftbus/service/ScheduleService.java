package com.swiftbus.service;

import com.swiftbus.model.Schedule;
import com.swiftbus.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ScheduleService {

    // Create Schedule
    public boolean createSchedule(Schedule schedule) {
        String query = "INSERT INTO schedules (bus_id, route_id, start_time, arrival_time) VALUES (?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, schedule.getBusId());
            stmt.setInt(2, schedule.getRouteId());
            stmt.setString(3, schedule.getStartTime());
            stmt.setString(4, schedule.getArrivalTime());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get All Schedules (using view)
    public List<Schedule> getAllSchedules() {
        List<Schedule> schedules = new ArrayList<>();
        String query = "SELECT * FROM schedules_view ORDER BY schedule_id";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setScheduleId(rs.getInt("schedule_id"));
                schedule.setBusNumber(rs.getString("bus_number"));
                schedule.setStartLocation(rs.getString("start_location"));
                schedule.setEndLocation(rs.getString("end_location"));
                schedule.setTicketPrice(rs.getDouble("ticket_price"));
                schedule.setStartTime(rs.getString("start_time"));
                schedule.setArrivalTime(rs.getString("arrival_time"));
                schedules.add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedules;
    }

    // Get Schedule by ID (using view)
    public Schedule getScheduleById(int id) {
        String query = "SELECT * FROM schedules_view WHERE schedule_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setScheduleId(rs.getInt("schedule_id"));
                schedule.setBusNumber(rs.getString("bus_number"));
                schedule.setStartLocation(rs.getString("start_location"));
                schedule.setEndLocation(rs.getString("end_location"));
                schedule.setTicketPrice(rs.getDouble("ticket_price"));
                schedule.setStartTime(rs.getString("start_time"));
                schedule.setArrivalTime(rs.getString("arrival_time"));
                return schedule;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update Schedule
    public boolean updateSchedule(Schedule schedule) {
        String query = "UPDATE schedules SET bus_id = ?, route_id = ?, start_time = ?, arrival_time = ? WHERE schedule_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, schedule.getBusId());
            stmt.setInt(2, schedule.getRouteId());
            stmt.setString(3, schedule.getStartTime());
            stmt.setString(4, schedule.getArrivalTime());
            stmt.setInt(5, schedule.getScheduleId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Schedule
    public boolean deleteSchedule(int id) {
        String query = "DELETE FROM schedules WHERE schedule_id = ?";
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