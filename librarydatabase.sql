-- Publisher Table
CREATE TABLE Publisher (
    PublisherId INT PRIMARY KEY,
    YearOfPublication YEAR,
    Name VARCHAR(255)
);

-- Book Table with Foreign Key to Publisher
CREATE TABLE Book (
    authno INT,
    isbn VARCHAR(13) PRIMARY KEY,
    title VARCHAR(255),
    edition VARCHAR(50),
    category VARCHAR(100),
    price DECIMAL(10,2),
    PublisherId INT,
    FOREIGN KEY (PublisherId) REFERENCES Publisher(PublisherId)
);

-- Reader Table
CREATE TABLE Reader (
    UserId INT PRIMARY KEY,
    Email VARCHAR(255),
    Address VARCHAR(255),
    FirstName VARCHAR(100),
    LastName VARCHAR(100)
);

-- PhoneNumbers Table for Multi-valued Attribute
CREATE TABLE PhoneNumbers (
    UserId INT,
    PhoneNo VARCHAR(15),
    FOREIGN KEY (UserId) REFERENCES Reader(UserId),
    PRIMARY KEY (UserId, PhoneNo) -- Composite primary key for multi-valued attribute
);

-- Authentication System Table
CREATE TABLE AuthenticationSystem (
    LoginId INT PRIMARY KEY,
    Password VARCHAR(255)
);

-- Reports Table with Foreign Key to Reader and Book
CREATE TABLE Reports (
    Reg_no INT PRIMARY KEY,
    UserId INT,
    Book_no VARCHAR(13),
    IssueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (UserId) REFERENCES Reader(UserId),
    FOREIGN KEY (Book_no) REFERENCES Book(isbn)
);

-- Staff Table
CREATE TABLE Staff (
    Staff_id INT PRIMARY KEY,
    Name VARCHAR(255)
);

-- ReserveReturn Table for Reader and Book Reservation (1:N relationship)
CREATE TABLE ReserveReturn (
    UserId INT,
    Book_no VARCHAR(13),
    ReserveDate DATE,
    DueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (UserId) REFERENCES Reader(UserId),
    FOREIGN KEY (Book_no) REFERENCES Book(isbn),
    PRIMARY KEY (UserId, Book_no, ReserveDate) -- Composite primary key
);

-- Junction Table for Many-to-Many Relationship between Staff and Reader
CREATE TABLE StaffReader (
    Staff_id INT,
    UserId INT,
    PRIMARY KEY (Staff_id, UserId),
    FOREIGN KEY (Staff_id) REFERENCES Staff(Staff_id),
    FOREIGN KEY (UserId) REFERENCES Reader(UserId)
);

-- StaffReports Table for One-to-Many Relationship between Staff and Reports
CREATE TABLE StaffReports (
    Staff_id INT,
    Reg_no INT,
    PRIMARY KEY (Staff_id, Reg_no),
    FOREIGN KEY (Staff_id) REFERENCES Staff(Staff_id),
    FOREIGN KEY (Reg_no) REFERENCES Reports(Reg_no)
);
