CREATE DATABASE LibraryDB;

USE LibraryDB;
CREATE TABLE Books (
    Book_ID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    Publication_Year YEAR,
    Genre VARCHAR(100),
    Is_Available BOOLEAN DEFAULT TRUE
);
CREATE TABLE Authors (
    Author_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(100) NOT NULL,
    Last_Name VARCHAR(100) NOT NULL,
    Birth_Date DATE
);
CREATE TABLE Members (
    Member_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(100) NOT NULL,
    Last_Name VARCHAR(100) NOT NULL,
    Membership_Date DATE,
    Email VARCHAR(255) UNIQUE NOT NULL
);
CREATE TABLE Loans (
    Loan_ID INT PRIMARY KEY AUTO_INCREMENT,
    Member_ID INT,
    Book_ID INT,
    Loan_Date DATE,
    Due_Date DATE,
    Return_Date DATE,
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);
CREATE TABLE Book_Author (
    Book_ID INT,
    Author_ID INT,
    PRIMARY KEY (Book_ID, Author_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID),
    FOREIGN KEY (Author_ID) REFERENCES Authors(Author_ID)
);
-- Insert Authors
INSERT INTO Authors (First_Name, Last_Name, Birth_Date) VALUES 
('George', 'Orwell', '1903-06-25'),
('F. Scott', 'Fitzgerald', '1896-09-24');

-- Insert Books
INSERT INTO Books (Title, ISBN, Publication_Year, Genre, Is_Available) VALUES 
('1984', '9780451524935', 1949, 'Dystopian', TRUE),
('The Great Gatsby', '9780743273565', 1925, 'Novel', TRUE);

-- Insert Members
INSERT INTO Members (First_Name, Last_Name, Membership_Date, Email) VALUES 
('John', 'Doe', '2023-01-15', 'john.doe@example.com'),
('Jane', 'Smith', '2023-02-20', 'jane.smith@example.com');

-- Insert Loans
INSERT INTO Loans (Member_ID, Book_ID, Loan_Date, Due_Date) VALUES 
(1, 1, '2024-01-01', '2024-01-15'),
(2, 2, '2024-01-02', '2024-01-16');

-- Associate Books with Authors
INSERT INTO Book_Author (Book_ID, Author_ID) VALUES 
(1, 1), -- 1984 by George Orwell
(2, 2); -- The Great Gatsby by F. Scott Fitzgerald
SELECT m.First_Name AS Member_First_Name, m.Last_Name AS Member_Last_Name,
       b.Title AS Book_Title, l.Loan_Date, l.Due_Date, l.Return_Date
FROM Loans l
JOIN Members m ON l.Member_ID = m.Member_ID
JOIN Books b ON l.Book_ID = b.Book_ID
WHERE m.Member_ID = 1; -- Change this ID to get history for other members
SELECT Title, Genre FROM Books WHERE Is_Available = TRUE;