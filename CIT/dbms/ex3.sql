-- Create and select database
CREATE DATABASE IF NOT EXISTS platform_data;
USE platform_data;

-- 1. Gaming Platform: user_play_sessions
CREATE TABLE IF NOT EXISTS user_play_sessions (
    user_id INT,
    game_id INT,
    hours_played DECIMAL(5,2),
    play_date DATE
);

INSERT INTO user_play_sessions VALUES
(1, 101, 2.5, '2025-07-01'),
(1, 102, 1.0, '2025-07-15'),
(2, 101, 3.5, '2025-07-20'),
(3, 103, 4.0, '2025-08-01'),
(1, 101, 1.5, '2025-08-05');

-- 2. Cab Booking System: rides
CREATE TABLE IF NOT EXISTS rides (
    ride_id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(50),
    fare DECIMAL(8,2),
    trip_distance DECIMAL(5,2),
    ride_date DATE,
    ride_status VARCHAR(20),
    driver_id INT
);

INSERT INTO rides (city, fare, trip_distance, ride_date, ride_status, driver_id) VALUES
('New York', 25.50, 10.5, '2025-07-20', 'completed', 101),
('Los Angeles', 30.00, 12.0, '2025-07-22', 'completed', 102),
('New York', 15.00, 5.0, '2025-08-01', 'cancelled', 101),
('Chicago', 40.00, 20.0, '2025-08-02', 'completed', 103),
('Los Angeles', 22.00, 9.0, '2025-08-05', 'completed', 102);

-- 3. Hotel Booking System: guest_stays
CREATE TABLE IF NOT EXISTS guest_stays (
    guest_id INT,
    room_id INT,
    room_type VARCHAR(50),
    booking_date DATE,
    check_in_date DATE,
    check_out_date DATE
);

INSERT INTO guest_stays VALUES
(1, 201, 'Deluxe', '2025-07-01', '2025-07-10', '2025-07-15'),
(2, 202, 'Standard', '2025-07-20', '2025-07-21', '2025-07-23'),
(1, 203, 'Suite', '2025-08-01', '2025-08-05', '2025-08-10'),
(3, 201, 'Deluxe', '2025-08-03', '2025-08-04', '2025-08-06');

-- 4. Logistics & Delivery Platform: package_tracking
CREATE TABLE IF NOT EXISTS package_tracking (
    package_id INT,
    region VARCHAR(50),
    shipment_date DATE,
    delivery_date DATE,
    dispatch_date DATE,
    status VARCHAR(20),
    shipment_type VARCHAR(20),
    warehouse_id INT
);

INSERT INTO package_tracking VALUES
(1001, 'East', '2025-06-15', '2025-06-20', '2025-06-14', 'delivered', 'domestic', 1),
(1002, 'West', '2025-07-01', '2025-07-10', '2025-06-30', 'delivered', 'international', 2),
(1003, 'East', '2025-07-05', '2025-07-15', '2025-07-04', 'delivered', 'international', 1),
(1004, 'North', '2025-08-01', '2025-08-05', '2025-07-31', 'pending', 'domestic', 3),
(1005, 'East', '2025-08-01', '2025-08-07', '2025-08-01', 'delivered', 'domestic', 1);

-- 5. Streaming Service: viewership
CREATE TABLE IF NOT EXISTS viewership (
    user_id INT,
    show_id INT,
    genre VARCHAR(50),
    watch_time INT,
    view_date DATE,
    subscriber_type VARCHAR(20)
);

INSERT INTO viewership VALUES
(1, 501, 'Drama', 120, '2025-07-01', 'premium'),
(2, 502, 'Comedy', 90, '2025-07-15', 'free'),
(1, 503, 'Drama', 60, '2025-07-20', 'premium'),
(3, 504, 'Action', 150, '2025-08-01', 'premium'),
(2, 505, 'Comedy', 80, '2025-08-05', 'premium');
 
USE platform_data;

-- 1. Total number of hours played by each user in the past month
SELECT user_id, 
       SUM(hours_played) AS total_hours_played
FROM user_play_sessions
WHERE play_date >= CURDATE() - INTERVAL 1 MONTH
GROUP BY user_id;

-- 2. Average number of games played per user last week
SELECT AVG(games_played) AS avg_games_per_user
FROM (
    SELECT user_id, COUNT(DISTINCT game_id) AS games_played
    FROM user_play_sessions
    WHERE play_date >= CURDATE() - INTERVAL 1 WEEK
    GROUP BY user_id
) AS sub;

-- 3. Most played game and total hours logged in the current quarter
SELECT game_id, 
       SUM(hours_played) AS total_hours
FROM user_play_sessions
WHERE play_date >= MAKEDATE(YEAR(CURDATE()), 1) 
      + INTERVAL QUARTER(CURDATE()) QUARTER - INTERVAL 1 QUARTER
  AND play_date < MAKEDATE(YEAR(CURDATE()), 1) 
      + INTERVAL QUARTER(CURDATE()) QUARTER
GROUP BY game_id
ORDER BY total_hours DESC
LIMIT 1;


-- 4. Total fare collected from each city in the last 30 days
SELECT city, 
       SUM(fare) AS total_fare_collected
FROM rides
WHERE ride_date >= CURDATE() - INTERVAL 30 DAY
GROUP BY city;

-- 5. Average trip distance for all completed rides this week
SELECT AVG(trip_distance) AS avg_trip_distance
FROM rides
WHERE ride_status = 'completed'
  AND ride_date >= CURDATE() - INTERVAL WEEKDAY(CURDATE()) DAY;

-- 6. Driver with the highest total ride earnings in the last year
SELECT driver_id, 
       SUM(fare) AS total_earnings
FROM rides
WHERE ride_date >= CURDATE() - INTERVAL 1 YEAR
GROUP BY driver_id
ORDER BY total_earnings DESC
LIMIT 1;

-- 7. Count the number of nights stayed by guests in the last season (last 3 months)
SELECT guest_id, 
       SUM(DATEDIFF(check_out_date, check_in_date)) AS total_nights_stayed
FROM guest_stays
WHERE check_in_date >= CURDATE() - INTERVAL 3 MONTH
GROUP BY guest_id;



-- 8. Average number of rooms booked per guest this month
SELECT AVG(room_count) AS avg_rooms_per_guest
FROM (
    SELECT guest_id, COUNT(room_id) AS room_count
    FROM guest_stays
    WHERE booking_date >= CURDATE() - INTERVAL 1 MONTH
    GROUP BY guest_id
) AS sub;

-- 9. Room type with the highest occupancy in the current year
SELECT room_type, 
       SUM(DATEDIFF(check_out_date, check_in_date)) AS total_occupied_nights
FROM guest_stays
WHERE check_in_date >= DATE_FORMAT(CURDATE(), '%Y-01-01')
GROUP BY room_type
ORDER BY total_occupied_nights DESC
LIMIT 1;

-- 10. Number of packages delivered per region in the past quarter
SELECT region, 
       COUNT(*) AS packages_delivered
FROM package_tracking
WHERE delivery_date >= CURDATE() - INTERVAL 3 MONTH
  AND status = 'delivered'
GROUP BY region;

-- 11. Average delivery time for international shipments (in hours)
SELECT AVG(TIMESTAMPDIFF(HOUR, shipment_date, delivery_date)) AS avg_delivery_time_hours
FROM package_tracking
WHERE shipment_type = 'international'
  AND status = 'delivered';

-- 12. Warehouse with the highest number of dispatches this year
SELECT warehouse_id, 
       COUNT(*) AS dispatch_count
FROM package_tracking
WHERE dispatch_date >= DATE_FORMAT(CURDATE(), '%Y-01-01')
GROUP BY warehouse_id
ORDER BY dispatch_count DESC
LIMIT 1;

-- 13. Total views per genre in the last 90 days
SELECT genre, 
       COUNT(*) AS total_views
FROM viewership
WHERE view_date >= CURDATE() - INTERVAL 90 DAY
GROUP BY genre;

-- 14. Average watch time per user for premium subscribers
SELECT user_id, AVG(watch_time) AS avg_watch_time
FROM viewership
WHERE subscriber_type = 'premium'
GROUP BY user_id;

-- 15. Show or movie with the highest total view time this month
SELECT show_id, 
       SUM(watch_time) AS total_view_time
FROM viewership
WHERE view_date >= CURDATE() - INTERVAL 1 MONTH
GROUP BY show_id
ORDER BY total_view_time DESC
LIMIT 1;
