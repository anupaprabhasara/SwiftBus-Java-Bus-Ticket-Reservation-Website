-- ========================================
-- Create Database
-- ========================================
CREATE DATABASE IF NOT EXISTS swiftbus_db;
USE swiftbus_db;

-- ========================================
-- Create Tables
-- ========================================

-- Table: users
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: admins
CREATE TABLE admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: buses
CREATE TABLE buses (
    bus_id INT AUTO_INCREMENT PRIMARY KEY,
    bus_number VARCHAR(50) NOT NULL,
    total_seats INT NOT NULL
);

-- Table: routes
CREATE TABLE routes (
    route_id INT AUTO_INCREMENT PRIMARY KEY,
    start_location VARCHAR(100) NOT NULL,
    end_location VARCHAR(100) NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL
);

-- Table: schedules (Corrected to use only TIME)
CREATE TABLE schedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    bus_id INT NOT NULL,
    route_id INT NOT NULL,
    start_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    FOREIGN KEY (bus_id) REFERENCES buses(bus_id) ON DELETE CASCADE,
    FOREIGN KEY (route_id) REFERENCES routes(route_id) ON DELETE CASCADE
);

-- Table: bookings (with travel_date)
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    schedule_id INT NOT NULL,
    travel_date DATE NOT NULL,
    number_of_seats INT NOT NULL,
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Confirmed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id) ON DELETE CASCADE
);

-- ========================================
-- Create Views
-- ========================================

-- View: schedules_view
CREATE VIEW schedules_view AS
SELECT 
    s.schedule_id,
    b.bus_number,
    r.start_location,
    r.end_location,
    r.ticket_price,
    s.start_time,
    s.arrival_time
FROM 
    schedules s
INNER JOIN buses b ON s.bus_id = b.bus_id
INNER JOIN routes r ON s.route_id = r.route_id;

-- View: bookings_view
CREATE VIEW bookings_view AS
SELECT 
    bk.booking_id,
    bk.user_id,
    u.name AS user_name,
    u.email AS user_email,
    scv.bus_number,
    scv.start_location,
    scv.end_location,
    scv.ticket_price,
    bk.travel_date,
    scv.start_time,
    scv.arrival_time,
    bk.number_of_seats,
    bk.booking_time,
    bk.status
FROM 
    bookings bk
INNER JOIN users u ON bk.user_id = u.user_id
INNER JOIN schedules_view scv ON bk.schedule_id = scv.schedule_id;

-- ========================================
-- Insert Sample Data
-- ========================================

-- Users
INSERT INTO users (name, email, phone, password) VALUES
('Kasun Silva', 'kasun@gmail.com', '0771234567', 'password123'),
('Nimali Perera', 'nimali@gmail.com', '0767654321', 'mypassword'),
('Sahan Jayasuriya', 'sahanj@gmail.com', '0789876543', 'passsahan'),
('Iresha Kumari', 'iresha.k@gmail.com', '0756541234', 'iresha123');

-- Admins
INSERT INTO admins (username, email, password) VALUES
('admin1', 'admin1@swiftbus.com', 'adminpass1'),
('admin2', 'admin2@swiftbus.com', 'adminpass2');

-- Buses
INSERT INTO buses (bus_number, total_seats) VALUES
('NB-1234', 50),
('NB-5678', 45),
('NB-9123', 48),
('NB-8765', 47),
('NB-3456', 50);

-- Routes (with vice versa routes already added!)
INSERT INTO routes (start_location, end_location, ticket_price) VALUES
-- Colombo to Other Cities
('Colombo', 'Matara', 1200.00),
('Matara', 'Colombo', 1200.00),

('Colombo', 'Galle', 1000.00),
('Galle', 'Colombo', 1000.00),

('Colombo', 'Hambantota', 1500.00),
('Hambantota', 'Colombo', 1500.00),

('Colombo', 'Kataragama', 1800.00),
('Kataragama', 'Colombo', 1800.00),

('Colombo', 'Embilipitiya', 1400.00),
('Embilipitiya', 'Colombo', 1400.00),

('Colombo', 'Tangalle', 1350.00),
('Tangalle', 'Colombo', 1350.00),

('Colombo', 'Wellawaya', 2000.00),
('Wellawaya', 'Colombo', 2000.00),

('Colombo', 'Badulla', 2200.00),
('Badulla', 'Colombo', 2200.00),

('Colombo', 'Ampara', 2600.00),
('Ampara', 'Colombo', 2600.00),

('Colombo', 'Monaragala', 2100.00),
('Monaragala', 'Colombo', 2100.00),

('Colombo', 'Kaduruwela', 2000.00),
('Kaduruwela', 'Colombo', 2000.00),

('Colombo', 'Anuradhapura', 2200.00),
('Anuradhapura', 'Colombo', 2200.00),

('Colombo', 'Trincomalee', 2400.00),
('Trincomalee', 'Colombo', 2400.00),

('Colombo', 'Batticaloa', 2500.00),
('Batticaloa', 'Colombo', 2500.00),

('Colombo', 'Kurunegala', 900.00),
('Kurunegala', 'Colombo', 900.00),

('Colombo', 'Dambulla', 1400.00),
('Dambulla', 'Colombo', 1400.00),

('Colombo', 'Kandy', 1200.00),
('Kandy', 'Colombo', 1200.00),

-- Makumbura to Other Cities
('Makumbura', 'Kandy', 1100.00),
('Kandy', 'Makumbura', 1100.00),

('Makumbura', 'Kurunegala', 950.00),
('Kurunegala', 'Makumbura', 950.00),

('Makumbura', 'Matara', 1100.00),
('Matara', 'Makumbura', 1100.00),

('Makumbura', 'Hambantota', 1450.00),
('Hambantota', 'Makumbura', 1450.00),

-- Kadawatha to Other Cities
('Kadawatha', 'Kandy', 1000.00),
('Kandy', 'Kadawatha', 1000.00),

('Kadawatha', 'Dambulla', 1350.00),
('Dambulla', 'Kadawatha', 1350.00),

('Kadawatha', 'Kurunegala', 850.00),
('Kurunegala', 'Kadawatha', 850.00),

('Kadawatha', 'Matara', 1250.00),
('Matara', 'Kadawatha', 1250.00),

-- Negombo to Other Cities
('Negombo', 'Galle', 1400.00),
('Galle', 'Negombo', 1400.00),

('Negombo', 'Matara', 1600.00),
('Matara', 'Negombo', 1600.00),

('Negombo', 'Kandy', 1500.00),
('Kandy', 'Negombo', 1500.00),

-- Galle to Other Cities
('Galle', 'Matara', 400.00),
('Matara', 'Galle', 400.00),

('Galle', 'Hambantota', 900.00),
('Hambantota', 'Galle', 900.00),

('Galle', 'Kataragama', 1300.00),
('Kataragama', 'Galle', 1300.00),

-- Matara to Other Cities
('Matara', 'Hambantota', 700.00),
('Hambantota', 'Matara', 700.00),

('Matara', 'Kataragama', 1200.00),
('Kataragama', 'Matara', 1200.00);

-- Schedules (daily based times only!)
INSERT INTO schedules (bus_id, route_id, start_time, arrival_time) VALUES
-- Colombo to Matara (Very Popular - 5 trips)
(1, 1, '05:00:00', '08:00:00'),
(2, 1, '08:00:00', '11:00:00'),
(3, 1, '11:00:00', '14:00:00'),
(4, 1, '14:00:00', '17:00:00'),
(5, 1, '17:00:00', '20:00:00'),

-- Matara to Colombo (Very Popular - 5 trips)
(2, 2, '05:30:00', '08:30:00'),
(3, 2, '08:30:00', '11:30:00'),
(4, 2, '11:30:00', '14:30:00'),
(5, 2, '14:30:00', '17:30:00'),
(1, 2, '17:30:00', '20:30:00'),

-- Colombo to Galle (Very Popular - 5 trips)
(3, 3, '06:00:00', '08:00:00'),
(4, 3, '09:00:00', '11:00:00'),
(5, 3, '12:00:00', '14:00:00'),
(1, 3, '15:00:00', '17:00:00'),
(2, 3, '18:00:00', '20:00:00'),

-- Galle to Colombo (Very Popular - 5 trips)
(4, 4, '06:30:00', '08:30:00'),
(5, 4, '09:30:00', '11:30:00'),
(1, 4, '12:30:00', '14:30:00'),
(2, 4, '15:30:00', '17:30:00'),
(3, 4, '18:30:00', '20:30:00'),

-- Colombo to Hambantota (Moderate - 3 trips)
(5, 5, '05:00:00', '09:00:00'),
(1, 5, '11:00:00', '15:00:00'),
(2, 5, '17:00:00', '21:00:00'),

-- Hambantota to Colombo (Moderate - 3 trips)
(1, 6, '06:00:00', '10:00:00'),
(2, 6, '12:00:00', '16:00:00'),
(3, 6, '18:00:00', '22:00:00'),

-- Colombo to Kataragama (Moderate - 2 trips)
(2, 7, '06:00:00', '10:30:00'),
(3, 7, '14:00:00', '18:30:00'),

-- Kataragama to Colombo (Moderate - 2 trips)
(4, 8, '07:00:00', '11:30:00'),
(5, 8, '15:00:00', '19:30:00'),

-- Colombo to Embilipitiya (Moderate - 2 trips)
(4, 9, '07:00:00', '10:00:00'),
(5, 9, '15:00:00', '18:00:00'),

-- Embilipitiya to Colombo (Moderate - 2 trips)
(5, 10, '08:00:00', '11:00:00'),
(1, 10, '16:00:00', '19:00:00'),

-- Colombo to Tangalle (Moderate - 2 trips)
(1, 11, '06:30:00', '09:30:00'),
(2, 11, '14:30:00', '17:30:00'),

-- Tangalle to Colombo (Moderate - 2 trips)
(2, 12, '07:30:00', '10:30:00'),
(3, 12, '15:30:00', '18:30:00'),

-- Colombo to Wellawaya (Moderate - 2 trips)
(3, 13, '05:30:00', '10:00:00'),
(4, 13, '14:00:00', '18:30:00'),

-- Wellawaya to Colombo (Moderate - 2 trips)
(4, 14, '06:30:00', '11:00:00'),
(5, 14, '15:00:00', '19:30:00'),

-- Colombo to Badulla (Moderate - 2 trips)
(5, 15, '04:30:00', '10:30:00'),
(1, 15, '14:00:00', '20:00:00'),

-- Badulla to Colombo (Moderate - 2 trips)
(1, 16, '05:00:00', '11:00:00'),
(2, 16, '15:00:00', '21:00:00'),

-- Colombo to Ampara (Low - 1 trip)
(2, 17, '05:00:00', '11:00:00'),

-- Ampara to Colombo (Low - 1 trip)
(3, 18, '06:00:00', '12:00:00'),

-- Colombo to Monaragala (Low - 1 trip)
(4, 19, '04:30:00', '10:30:00'),

-- Monaragala to Colombo (Low - 1 trip)
(5, 20, '05:30:00', '11:30:00'),

-- Colombo to Kaduruwela (Low - 1 trip)
(1, 21, '04:00:00', '09:00:00'),

-- Kaduruwela to Colombo (Low - 1 trip)
(2, 22, '05:00:00', '10:00:00'),

-- Colombo to Anuradhapura (Low - 1 trip)
(3, 23, '05:00:00', '10:00:00'),

-- Anuradhapura to Colombo (Low - 1 trip)
(4, 24, '06:00:00', '11:00:00'),

-- Colombo to Trincomalee (Low - 1 trip)
(5, 25, '04:00:00', '10:00:00'),

-- Trincomalee to Colombo (Low - 1 trip)
(1, 26, '05:00:00', '11:00:00'),

-- Colombo to Batticaloa (Low - 1 trip)
(2, 27, '04:30:00', '10:30:00'),

-- Batticaloa to Colombo (Low - 1 trip)
(3, 28, '05:30:00', '11:30:00'),

-- Colombo to Kurunegala (Moderate - 3 trips)
(4, 29, '06:00:00', '08:00:00'),
(5, 29, '10:00:00', '12:00:00'),
(1, 29, '16:00:00', '18:00:00'),

-- Kurunegala to Colombo (Moderate - 3 trips)
(5, 30, '07:00:00', '09:00:00'),
(1, 30, '11:00:00', '13:00:00'),
(2, 30, '17:00:00', '19:00:00'),

-- Colombo to Dambulla (Moderate - 2 trips)
(1, 31, '06:00:00', '09:00:00'),
(2, 31, '14:00:00', '17:00:00'),

-- Dambulla to Colombo (Moderate - 2 trips)
(2, 32, '07:00:00', '10:00:00'),
(3, 32, '15:00:00', '18:00:00'),

-- Colombo to Kandy (Very Popular - 5 trips)
(3, 33, '06:00:00', '08:30:00'),
(4, 33, '08:00:00', '10:30:00'),
(5, 33, '10:00:00', '12:30:00'),
(1, 33, '14:00:00', '16:30:00'),
(2, 33, '16:00:00', '18:30:00'),

-- Kandy to Colombo (Very Popular - 5 trips)
(4, 34, '06:30:00', '09:00:00'),
(5, 34, '08:30:00', '11:00:00'),
(1, 34, '10:30:00', '13:00:00'),
(2, 34, '14:30:00', '17:00:00'),
(3, 34, '16:30:00', '19:00:00');

-- Bookings (with travel_date sample!)
INSERT INTO bookings (user_id, schedule_id, travel_date, number_of_seats, status) VALUES
(1, 1, '2025-05-01', 2, 'Confirmed'),
(2, 2, '2025-05-01', 1, 'Pending'),
(3, 3, '2025-05-02', 3, 'Confirmed'),
(4, 4, '2025-05-02', 2, 'Pending'),
(1, 5, '2025-05-03', 1, 'Cancelled'),
(2, 6, '2025-05-03', 2, 'Confirmed');