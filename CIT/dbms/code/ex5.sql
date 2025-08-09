CREATE DATABASE travel_booking;
USE travel_booking;
----------------------------------------
-- Customers
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100)
);

-- Bookings (general bookings with destination city)
CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    DestinationCity VARCHAR(100),
    BookingDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Payments
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    BookingID INT,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

-- Flights
CREATE TABLE Flights (
    FlightID INT AUTO_INCREMENT PRIMARY KEY,
    Airline VARCHAR(100),
    FlightNumber VARCHAR(20),
    DepartureCity VARCHAR(100),
    ArrivalCity VARCHAR(100)
);

-- HotelBookings
CREATE TABLE HotelBookings (
    HotelBookingID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    HotelName VARCHAR(100),
    HotelCategory VARCHAR(10),  -- e.g., '3-star', '4-star'
    BookingDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Trips (individual trips made by customers)
CREATE TABLE Trips (
    TripID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
----------------------------------------
-- Customers
INSERT INTO Customers (Name, Email) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com');

-- Bookings
INSERT INTO Bookings (CustomerID, DestinationCity, BookingDate) VALUES
(1, 'New York', '2023-01-10'),
(1, 'Paris', '2023-02-15'),
(2, 'New York', '2023-03-20'),
(2, 'Tokyo', '2022-12-25'),
(1, 'Paris', '2023-04-05');

-- Payments
INSERT INTO Payments (BookingID, PaymentDate, Amount) VALUES
(1, '2023-01-11', 500.00),
(2, '2023-02-16', 700.00),
(3, '2023-03-21', 450.00),
(4, '2022-12-26', 1200.00),
(5, '2023-04-06', 700.00);

-- Flights
INSERT INTO Flights (Airline, FlightNumber, DepartureCity, ArrivalCity) VALUES
('Airways A', 'AA101', 'New York', 'Paris'),
('Airways B', 'BB202', 'Paris', 'Tokyo'),
('Airways A', 'AA103', 'Tokyo', 'New York'),
('Airways C', 'CC303', 'New York', 'London');

-- HotelBookings
INSERT INTO HotelBookings (CustomerID, HotelName, HotelCategory, BookingDate) VALUES
(1, 'Hotel Lux', '5-star', '2023-02-10'),
(1, 'Budget Inn', '3-star', '2023-02-12'),
(2, 'Comfort Stay', '4-star', '2023-03-15'),
(2, 'Hotel Lux', '5-star', '2023-04-20');

-- Trips
INSERT INTO Trips (CustomerID, StartDate, EndDate) VALUES
(1, '2023-01-10', '2023-01-15'),
(1, '2023-02-15', '2023-02-20'),
(2, '2022-11-01', '2022-11-10'),
(2, '2023-03-05', '2023-03-12');
----------------------------------------
SELECT DestinationCity, COUNT(*) AS TotalBookings
FROM Bookings
GROUP BY DestinationCity;
----------------------------------------
SELECT YEAR(PaymentDate) AS Year, SUM(Amount) AS TotalRevenue
FROM Payments
GROUP BY Year;
----------------------------------------
SELECT MONTH(BookingDate) AS Month, COUNT(*) AS BookingsCount
FROM Bookings
WHERE YEAR(BookingDate) = 2023
GROUP BY Month
ORDER BY Month;
----------------------------------------
SELECT Airline, COUNT(*) AS TotalFlights
FROM Flights
GROUP BY Airline;
----------------------------------------
SELECT HotelCategory, COUNT(*) AS TotalBookings
FROM HotelBookings
GROUP BY HotelCategory;
----------------------------------------
SELECT CustomerID, AVG(DATEDIFF(EndDate, StartDate)) AS AvgTripDuration
FROM Trips
GROUP BY CustomerID;
----------------------------------------
SELECT QUARTER(StartDate) AS Quarter, COUNT(*) AS TripsCount
FROM Trips
WHERE YEAR(StartDate) = 2022
GROUP BY Quarter;
----------------------------------------
SELECT COUNT(*) AS WeekendBookings
FROM Bookings
WHERE DAYOFWEEK(BookingDate) IN (1, 7);  -- Sunday=1, Saturday=7 in MySQL

