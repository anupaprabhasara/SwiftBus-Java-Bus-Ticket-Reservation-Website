package com.swiftbus.service;

import com.swiftbus.model.User;
import com.swiftbus.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserService {

    // Create User
    public boolean createUser(User user) {
        String query = "INSERT INTO users (name, email, phone, password) VALUES (?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getPassword());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get User by ID
    public User getUser(int id) {
        String query = "SELECT * FROM users WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPassword(rs.getString("password"));
                user.setCreatedAt(rs.getString("created_at"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get All Users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users ORDER BY user_id";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPassword(rs.getString("password"));
                user.setCreatedAt(rs.getString("created_at"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // Update User
    public boolean updateUser(User user) {
        String query = "UPDATE users SET name = ?, email = ?, phone = ?, password = ? WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getPassword());
            stmt.setInt(5, user.getUserId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete User
    public boolean deleteUser(int id) {
        String query = "DELETE FROM users WHERE user_id = ?";
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