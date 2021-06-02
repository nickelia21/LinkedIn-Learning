-- LinkedIn Learning SQL Code Challenges

-- Chapter 1: In the Restaurant
USE ch01;

-- ------------------------------- --

-- Create invitations for a party
SELECT FirstName, LastName, Email
FROM Customers
ORDER BY LastName;


-- Create a table to store information
CREATE TABLE IF NOT EXISTS AnniversaryAttendees (
    CustomerID 	INTEGER, -- FOREIGN KEY REFERENCES Customers(CustomerID),
	PartySize	INTEGER
);


-- Print a menu
SELECT *
FROM Dishes
ORDER BY Price;

SELECT *
FROM Dishes
WHERE Type IN ('Appetizer', 'Beverage')
ORDER BY Type;

SELECT Name, Type
FROM Dishes
WHERE Type <> 'Beverage'
ORDER BY Type;


-- Sign a customer up for your loyalty program
INSERT INTO Customers
	(FirstName,LastName, Email, Address, City, State, Phone, Birthday)
    VALUES
    ('Anna', 'Smith', 'asmith@kinetecoinc.com', '479 Lapis Dr.', 'Memphis', 'TN',
    '(555) 555-1212', '1973-07-21');


-- Update a customer's personal information
UPDATE Customers SET
	Address = "74 Pine St.",
    City = "New York",
    State = "NY"
WHERE CustomerID = 26;


-- Remove a customer's record
DELETE FROM Customers
WHERE CustomerID = 4;


-- Log customer's responses
INSERT INTO AnniversaryAttendees
	(CustomerID, PartySize)
VALUES 
	((	SELECT CustomerID
		FROM Customers
		WHERE Email = 'atapley2j@kinetecoinc.com'),
    4);


-- Look up reservations
SELECT c.FirstName, c.LastName, r.Date, r.PartySize
FROM Reservations r
LEFT JOIN Customers c USING(CustomerID)
WHERE LastName LIKE 'Ste%';

-- Take a reservation
INSERT INTO Customers
	(FirstName, LastName, Email, Phone)
VALUES 
	('Sam', 'McAdams', 'smac@kinetecoinc.com', '(555) 555-1232');

INSERT INTO Reservations
	(CustomerID, Date, PartySize)
VALUES 
	(102, '2020-06-14 18:00:00', 5);


-- Take a delivery order (house salad, mini cheeseburgers, tropical blue smoothie)
SELECT *
FROM Customers
WHERE FirstName = 'Loretta' AND LastName = 'Hundey';
	-- CustomerID = 70

SELECT * FROM Orders;

INSERT INTO Orders
	(OrderID, CustomerID, OrderDate)
VALUES
	(1001, 70, '2021-06-01 08:21:00');
    
INSERT INTO OrdersDishes
	(OrderID, DishID)
VALUES
	(1001, (SELECT DishID FROM Dishes WHERE Name = 'House Salad')),
    (1001, (SELECT DishID FROM Dishes WHERE Name = 'Mini Cheeseburgers')),
    (1001, (SELECT DishID FROM Dishes WHERE Name = 'Tropical Blue Smoothie'));

	-- Find total cost
SELECT Name, SUM(Price) as 'Price'
FROM Dishes
WHERE Name IN ('House Salad', 'Mini Cheeseburgers', 'Tropical Blue Smoothie')
GROUP BY Name WITH ROLLUP;


-- Track your customer's favorite dishes
SELECT * FROM Dishes WHERE Name LIKE '%quinoa%';
	-- Quinoa Salmon Salad: DishID = 9

SELECT * FROM Customers WHERE FirstName = 'Cleo' AND LastName = 'Goldwater';
	-- Cleo Goldwater: CustomerID = 42

UPDATE Customers SET
	FavoriteDish = (
		SELECT DishID
        FROM Dishes
        WHERE Name = 'Quinoa Salmon Salad'
	)
WHERE CustomerID = 42;


-- Prepare a report of your top five customers
SELECT c.FirstName, c.LastName, c.Email, COUNT(o.OrderID) AS 'Number of Orders'
FROM Customers c
LEFT JOIN Orders o USING(CustomerID)
GROUP BY c.FirstName, c.LastName, c.Email
ORDER BY COUNT(*) DESC
LIMIT 5








