-- LinkedIn Learning SQL Code Challenges

-- Chapter 2: At the Library
USE ch02;

-- ------------------------------- --

-- Check book availability
SELECT 
	(SELECT COUNT(b.Title) FROM Books b WHERE b.Title = 'Dracula')
	-
	(SELECT COUNT(b.Title)
		FROM Loans l
		JOIN Books b USING(BookID)
		WHERE b.Title = 'Dracula' AND l.ReturnedDate IS NULL)
AS AvailableBooks;


-- Add new books to the library
INSERT INTO Books
	(Title, Author, Published, Barcode)
VALUES
	('Dracula', 'Bram Stoker', 1897, 4819277482),
    ("Gulliver's Travels", 'Jonathon Swift', 1729, 4899254401);


-- Check out books
SELECT * FROM Patrons WHERE FirstName = 'Jack' AND LastName = 'Vaan';
	-- Jack Vaan: PatronID = 50

INSERT INTO Loans
	(BookID, PatronID, LoanDate, DueDate)
VALUES (
	(SELECT BookID FROM Books WHERE Barcode = '2855934983'),
    (SELECT PatronID FROM Patrons WHERE Email = 'jvaan@wisdompets.com'),
    '2020-08-25',
    '2020-09-08'),
    (
    (SELECT BookID FROM Books WHERE Barcode = '4043822646'),
    (SELECT PatronID FROM Patrons WHERE Email = 'jvaan@wisdompets.com'),
    '2020-08-25',
    '2020-09-08');


-- Check for books due back
SELECT l.DueDate, b.Title, p.Email, p.FirstName
FROM Loans l
JOIN Books b USING(BookID)
JOIN Patrons p USING(PatronID)
WHERE l.DueDate = '2020-07-13' AND l.ReturnedDate IS NULL;


-- Return books to the library
UPDATE Loans SET
	ReturnedDate = '2020-07-05'
WHERE
	BookID IN (
	(SELECT BookID FROM Books WHERE Barcode = 6435968642),
    (SELECT BookID FROM Books WHERE Barcode = 5677520613),
    (SELECT BookID FROM Books WHERE Barcode = 8730298424))
AND ReturnedDate IS NULL;


-- Encourage patrons to check out books
SELECT COUNT(l.LoanID) AS LoanCount, p.FirstName, p.Email
FROM Loans l
JOIN Patrons p USING(PatronID)
GROUP BY p.FirstName, p.Email
ORDER BY LoanCount ASC
LIMIT 10;


-- Find books to feature for an event
SELECT b.Title, b.Author, b.Published 
FROM Books b
LEFT JOIN Loans l USING(BookID)
WHERE b.Published > 1889 AND b.Published < 1900
	AND l.ReturnedDate IS NOT NULL
GROUP BY b.BookID
ORDER BY Title;


-- Book statistics
	-- How many books were published each year
SELECT Published AS Year, COUNT(DISTINCT(Title)) AS Count
FROM Books
GROUP BY Year
ORDER BY Count DESC;

	-- Show the 5 most popular books to check out
SELECT b.Title as Title, COUNT(l.LoanID) as Count
FROM Books b
JOIN Loans l USING(BookID)
GROUP BY Title
ORDER BY Count DESC
LIMIT 5;






