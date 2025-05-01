package com.swiftbus.service;

import com.swiftbus.model.Route;
import com.swiftbus.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RouteService {

    // Create Route
    public boolean createRoute(Route route) {
        String query = "INSERT INTO routes (start_location, end_location, ticket_price) VALUES (?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, route.getStartLocation());
            stmt.setString(2, route.getEndLocation());
            stmt.setDouble(3, route.getTicketPrice());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Route by ID
    public Route getRoute(int id) {
        String query = "SELECT * FROM routes WHERE route_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Route route = new Route();
                route.setRouteId(rs.getInt("route_id"));
                route.setStartLocation(rs.getString("start_location"));
                route.setEndLocation(rs.getString("end_location"));
                route.setTicketPrice(rs.getDouble("ticket_price"));
                return route;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Route> getTopRoutes(int limit) {
        List<Route> routes = new ArrayList<>();
        String query = "SELECT * FROM routes ORDER BY route_id LIMIT ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Route route = new Route();
                route.setRouteId(rs.getInt("route_id"));
                route.setStartLocation(rs.getString("start_location"));
                route.setEndLocation(rs.getString("end_location"));
                route.setTicketPrice(rs.getDouble("ticket_price"));
                routes.add(route);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return routes;
    }
    
    // Get All Routes
    public List<Route> getAllRoutes() {
        List<Route> routes = new ArrayList<>();
        String query = "SELECT * FROM routes ORDER BY route_id";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Route route = new Route();
                route.setRouteId(rs.getInt("route_id"));
                route.setStartLocation(rs.getString("start_location"));
                route.setEndLocation(rs.getString("end_location"));
                route.setTicketPrice(rs.getDouble("ticket_price"));
                routes.add(route);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return routes;
    }

    // Update Route
    public boolean updateRoute(Route route) {
        String query = "UPDATE routes SET start_location = ?, end_location = ?, ticket_price = ? WHERE route_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, route.getStartLocation());
            stmt.setString(2, route.getEndLocation());
            stmt.setDouble(3, route.getTicketPrice());
            stmt.setInt(4, route.getRouteId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Route
    public boolean deleteRoute(int id) {
        String query = "DELETE FROM routes WHERE route_id = ?";
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