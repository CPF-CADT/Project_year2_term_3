 drop database Bookstore;
create database Bookstore;
	use Bookstore;
create  table if not exists Person  (
    id  varchar(20) primary key,
	name VARCHAR(100),

    email VARCHAR(255) UNIQUE,
    phoneNumber VARCHAR(20),
    password varchar(100),
    address varchar(100),
    profilePicUrl TEXT,
    accountStatus VARCHAR(50) CHECK (accountStatus IN ('Active', 'Inactive', 'Suspended'))
);
create table if not exists Customer (
 customerId varchar(20) primary key,
 dateJoin  date,
 membership boolean default false,
 foreign key (customerId) references Person(id)
);
create  table if not exists `Vendor` (
    vendorId varchar(20) PRIMARY KEY,
    hireDate DATE,
    salary decimal(10, 2),
    shift VARCHAR(20) CHECK (shift IN ('Morning', 'Afternoon', 'Night')),
    bonus decimal(10, 2),
    manageBy VARCHAR(20),
    status VARCHAR(50) check(status in ('ACTIVE','INACTIVE')),
    foreign key (vendorId) references Person(id),
    foreign key (manageBy) references Person(id)
);
CREATE TABLE if not exists Book (
    id varchar(20) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    genre VARCHAR(100),
    publisher VARCHAR(255),
    publishedYear INT CHECK (publishedYear >= 1900 AND publishedYear <= 2026),
    isBn VARCHAR(20) UNIQUE,
    language VARCHAR(50),
    cover_image_url TEXT
);
CREATE TABLE BookInventory (
	id varchar(20),
    bookInventoryId varchar(20) PRIMARY KEY,
    location VARCHAR(10) CHECK (location IN ('l1', 'l2', 'l3', 'l4', 'l5', 'l6', 'l7', 'l8', 'l9', 'l10')),
    stock_qty INT,
    price DECIMAL(10, 2),
    editions VARCHAR(50),
    FOREIGN KEY (id) REFERENCES Book(id)
);
CREATE TABLE review (
    reviewId VARCHAR(20) PRIMARY KEY,
    reviewBy varchar(20),
    bookId VARCHAR(20),
    comment TEXT,
	sentiment ENUM('liked', 'hated', 'neutral') DEFAULT 'neutral',
    rate DECIMAL(3,2) CHECK (rate >= 0.00 AND rate <= 5.00),
    FOREIGN KEY (bookId) REFERENCES Book(id),
    FOREIGN KEY (reviewBy) REFERENCES Person(id)
     
);

CREATE TABLE IF NOT EXISTS `Order` (
    orderId VARCHAR(20) PRIMARY KEY,
    saleDateTime DATETIME,
    totalprice DECIMAL(10, 2),
    paymentMethod VARCHAR(50),
    vendorId VARCHAR(20),
    customerId VARCHAR(20),
    discounts DECIMAL(5, 2) CHECK (discounts >= 0 AND discounts <= 100),
    qty INT,
    bookId VARCHAR(20),
    veriflyNumber VARCHAR(50),
    FOREIGN KEY (bookId) REFERENCES Book(id),
    FOREIGN KEY (vendorId) REFERENCES Vendor(vendorId),
    FOREIGN KEY (customerId) REFERENCES Customer(customerId)
);

CREATE TABLE IF NOT EXISTS OrderItem (
    orderId VARCHAR(20),
    bookInventoryId VARCHAR(20),
    pricePerItem DECIMAL(10, 2),
    quantity INT,
    PRIMARY KEY (orderId, bookInventoryId),
    FOREIGN KEY (orderId) REFERENCES `Order`(orderId),
    FOREIGN KEY (bookInventoryId) REFERENCES BookInventory(bookInventoryId)
);

CREATE TABLE IF NOT EXISTS Payment (
    paymentId VARCHAR(20) PRIMARY KEY,
    orderId VARCHAR(20),
    amount DECIMAL(10, 2),
    paymentDate DATETIME,
    method VARCHAR(50) ,
    status VARCHAR(20) CHECK (status IN ('Pending', 'Completed', 'Failed')),
    FOREIGN KEY (orderId) REFERENCES `Order`(orderId)
);


-- Person table (combining both customer and vendor IDs)
INSERT INTO Person (id, firstName, lastName, dob, email, phoneNumber, password, address, profilePicUrl, accountStatus) VALUES
('C001', 'John', 'Doe', '1990-05-15', 'john.doe@email.com', '123-456-7890', 'pass123', '123 Main St', 'http://pic1.com', 'Active'),
('C002', 'Jane', 'Smith', '1985-08-22', 'jane.smith@email.com', '234-567-8901', 'pass456', '456 Oak Ave', 'http://pic2.com', 'Active'),
('V001', 'Michael', 'Brown', '1992-03-10', 'michael.b@email.com', '345-678-9012', 'pass789', '789 Pine Rd', 'http://pic3.com', 'Inactive'),
('C003', 'Sarah', 'Davis', '1988-11-30', 'sarah.d@email.com', '456-789-0123', 'pass101', '321 Elm St', 'http://pic4.com', 'Active'),
('V002', 'Robert', 'Wilson', '1995-07-14', 'robert.w@email.com', '567-890-1234', 'pass202', '654 Maple Dr', 'http://pic5.com', 'Suspended'),
('C004', 'Emily', 'Taylor', '1991-04-20', 'emily.t@email.com', '678-901-2345', 'pass303', '987 Cedar Ln', 'http://pic6.com', 'Active'),
('C005', 'David', 'Anderson', '1987-09-05', 'david.a@email.com', '789-012-3456', 'pass404', '147 Birch St', 'http://pic7.com', 'Active'),
('V003', 'Lisa', 'Martinez', '1993-12-25', 'lisa.m@email.com', '890-123-4567', 'pass505', '258 Walnut Ave', 'http://pic8.com', 'Inactive'),
('C006', 'James', 'Garcia', '1989-06-18', 'james.g@email.com', '901-234-5678', 'pass606', '369 Spruce Rd', 'http://pic9.com', 'Active'),
('C007', 'Mary', 'Lopez', '1994-01-30', 'mary.l@email.com', '012-345-6789', 'pass707', '741 Oak Ln', 'http://pic10.com', 'Active'),
('V004', 'Thomas', 'Hernandez', '1986-10-12', 'thomas.h@email.com', '123-456-7891', 'pass808', '852 Pine St', 'http://pic11.com', 'Suspended'),
('C008', 'Patricia', 'Gonzalez', '1990-02-28', 'patricia.g@email.com', '234-567-8902', 'pass909', '963 Maple Ave', 'http://pic12.com', 'Active'),
('V005', 'Charles', 'Perez', '1992-08-15', 'charles.p@email.com', '345-678-9013', 'pass010', '174 Cedar Rd', 'http://pic13.com', 'Inactive'),
('C009', 'Barbara', 'Ramirez', '1988-04-09', 'barbara.r@email.com', '456-789-0124', 'pass111', '285 Walnut St', 'http://pic14.com', 'Active'),
('C010', 'Daniel', 'Torres', '1995-03-22', 'daniel.t@email.com', '567-890-1235', 'pass212', '396 Spruce Ln', 'http://pic15.com', 'Active'),
('V006', 'Nancy', 'Flores', '1991-07-07', 'nancy.f@email.com', '678-901-2346', 'pass313', '407 Oak Dr', 'http://pic16.com', 'Suspended'),
('C011', 'Paul', 'Rivera', '1987-11-19', 'paul.r@email.com', '789-012-3457', 'pass414', '518 Pine Ave', 'http://pic17.com', 'Active'),
('V007', 'Helen', 'Sanchez', '1993-05-03', 'helen.s@email.com', '890-123-4568', 'pass515', '629 Cedar St', 'http://pic18.com', 'Inactive'),
('C012', 'George', 'Cruz', '1989-09-25', 'george.c@email.com', '901-234-5679', 'pass616', '740 Maple Rd', 'http://pic19.com', 'Active'),
('C013', 'Karen', 'Ortiz', '1994-12-10', 'karen.o@email.com', '012-345-6790', 'pass717', '851 Walnut Ln', 'http://pic20.com', 'Active');

-- Customer table (only Cxxx IDs)
INSERT INTO Customer (customerId, dateJoin, membership) VALUES
('C001', '2023-01-15', TRUE),
('C002', '2023-02-20', FALSE),
('C003', '2023-03-10', TRUE),
('C004', '2023-04-05', FALSE),
('C005', '2023-05-12', TRUE),
('C006', '2023-06-18', FALSE),
('C007', '2023-07-25', TRUE),
('C008', '2023-08-30', FALSE),
('C009', '2023-09-15', TRUE),
('C010', '2023-10-20', FALSE),
('C011', '2023-11-05', TRUE),
('C012', '2023-12-10', FALSE),
('C013', '2024-01-15', TRUE);

-- Vendor table (only Vxxx IDs)
INSERT INTO Vendor (vendorId, hireDate, salary, shift, bonus, manageBy, status) VALUES
('V001', '2022-06-01', 50000.00, 'Morning', 1000.00, 'V005', 'ACTIVE'),
('V002', '2022-07-15', 55000.00, 'Afternoon', 1200.00, 'V005', 'ACTIVE'),
('V003', '2022-08-20', 48000.00, 'Night', 800.00, 'V006', 'INACTIVE'),
('V004', '2022-09-10', 52000.00, 'Morning', 900.00, 'V006', 'ACTIVE'),
('V005', '2022-10-05', 60000.00, 'Afternoon', 1500.00, 'V001', 'ACTIVE'),
('V006', '2022-11-12', 53000.00, 'Night', 1100.00, 'V001', 'ACTIVE'),
('V007', '2022-12-20', 49000.00, 'Morning', 850.00, 'V002', 'INACTIVE');
INSERT INTO Book (id, title, author, genre, publisher, publishedYear, isBn, language, cover_image_url) VALUES
('B001', 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 'Scribner', 1995, '978-0743273565', 'English', 'http://book1.com'),
('B002', '1984', 'George Orwell', 'Dystopian', 'Secker & Warburg', 1999, '978-0451524935', 'English', 'http://book2.com'),
('B003', 'To Kill a Mockingbird', 'Harper Lee', 'Classic', 'J.B. Lippincott', 1990, '978-0446310789', 'English', 'http://book3.com'),
('B004', 'Pride and Prejudice', 'Jane Austen', 'Romance', 'T. Egerton', 2013, '978-0141439518', 'English', 'http://book4.com'),
('B005', 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 'Allen & Unwin', 1997, '978-0547928227', 'English', 'http://book5.com'),
('B006', 'Dune', 'Frank Herbert', 'Science Fiction', 'Chilton Books', 1995, '978-0441172719', 'English', 'http://book6.com'),
('B007', 'The Catcher in the Rye', 'J.D. Salinger', 'Coming-of-Age', 'Little, Brown', 1991, '978-0316769488', 'English', 'http://book7.com'),
('B008', 'Brave New World', 'Aldous Huxley', 'Dystopian', 'Chatto & Windus', 1992, '978-0060850524', 'English', 'http://book8.com'),
('B009', 'Animal Farm', 'George Orwell', 'Satire', 'Secker & Warburg', 1995, '978-0451526342', 'English', 'http://book9.com'),
('B010', 'Lord of the Rings', 'J.R.R. Tolkien', 'Fantasy', 'Allen & Unwin', 1994, '978-0618640157', 'English', 'http://book10.com'),
('B011', 'The Da Vinci Code', 'Dan Brown', 'Thriller', 'Doubleday', 2003, '978-0385504201', 'English', 'http://book11.com'),
('B012', 'Harry Potter', 'J.K. Rowling', 'Fantasy', 'Bloomsbury', 1997, '978-0747532699', 'English', 'http://book12.com'),
('B013', 'The Alchemist', 'Paulo Coelho', 'Adventure', 'HarperTorch', 1988, '978-0061122415', 'English', 'http://book13.com'),
('B014', 'The Road', 'Cormac McCarthy', 'Post-Apocalyptic', 'Knopf', 2006, '978-0307387899', 'English', 'http://book14.com'),
('B015', 'Gone with the Wind', 'Margaret Mitchell', 'Historical', 'Macmillan', 1996, '978-0446365383', 'English', 'http://book15.com'),
('B016', 'The Shining', 'Stephen King', 'Horror', 'Doubleday', 1977, '978-0307743657', 'English', 'http://book16.com'),
('B017', 'Charlotte''s Web', 'E.B. White', 'Children', 'Harper & Brothers', 1992, '978-0064400558', 'English', 'http://book17.com'),
('B018', 'The Odyssey', 'Homer', 'Epic', 'Unknown', 2000, '978-0140268867', 'English', 'http://book18.com'),
('B019', 'The Hunger Games', 'Suzanne Collins', 'Dystopian', 'Scholastic', 2008, '978-0439023528', 'English', 'http://book19.com'),
('B020', 'A Brief History of Time', 'Stephen Hawking', 'Science', 'Bantam Books', 1988, '978-0553380163', 'English', 'http://book20.com');
INSERT INTO BookInventory (id, bookInventoryId, location, stock_qty, price, editions) VALUES
('B001', 'BI001', 'l1', 50, 15.99, '1st'),
('B002', 'BI002', 'l2', 45, 12.99, '2nd'),
('B003', 'BI003', 'l3', 60, 14.99, '1st'),
('B004', 'BI004', 'l4', 40, 13.99, '3rd'),
('B005', 'BI005', 'l5', 55, 16.99, '2nd'),
('B006', 'BI006', 'l6', 35, 19.99, '1st'),
('B007', 'BI007', 'l7', 50, 11.99, '4th'),
('B008', 'BI008', 'l8', 45, 14.99, '2nd'),
('B009', 'BI009', 'l9', 60, 10.99, '3rd'),
('B010', 'BI010', 'l10', 40, 18.99, '1st'),
('B011', 'BI011', 'l1', 55, 17.99, '2nd'),
('B012', 'BI012', 'l2', 70, 15.99, '1st'),
('B013', 'BI013', 'l3', 45, 13.99, '3rd'),
('B014', 'BI014', 'l4', 50, 16.99, '2nd'),
('B015', 'BI015', 'l5', 35, 14.99, '1st'),
('B016', 'BI016', 'l6', 60, 12.99, '4th'),
('B017', 'BI017', 'l7', 40, 9.99, '3rd'),
('B018', 'BI018', 'l8', 55, 11.99, '2nd'),
('B019', 'BI019', 'l9', 45, 15.99, '1st'),
('B020', 'BI020', 'l10', 50, 19.99, '2nd');
INSERT INTO review (reviewId, reviewBy, bookId, comment, sentiment, rate) VALUES
('R001', 'C001', 'B001', 'Great classic!', 'liked', 4.50),
('R002', 'C002', 'B002', 'Thought-provoking.', 'liked', 4.00),
('R003', 'C003', 'B003', 'Amazing story.', 'liked', 4.80),
('R004', 'C004', 'B004', 'Lovely romance.', 'liked', 4.20),
('R005', 'C005', 'B005', 'Epic adventure.', 'liked', 4.70),
('R006', 'C006', 'B006', 'Sci-fi masterpiece.', 'liked', 4.30),
('R007', 'C007', 'B007', 'Interesting read.', 'liked', 3.90),
('R008', 'C008', 'B008', 'Dark but good.', 'liked', 4.10),
('R009', 'C009', 'B009', 'Satirical gem.', 'liked', 4.40),
('R010', 'C010', 'B010', 'Fantasy epic.', 'liked', 4.60),
('R011', 'C011', 'B011', 'Thrilling plot.', 'liked', 4.00),
('R012', 'C012', 'B012', 'Magical world.', 'liked', 4.50),
('R013', 'C013', 'B013', 'Inspiring journey.', 'liked', 4.20),
('R014', 'C001', 'B014', 'Haunting tale.', 'liked', 4.30),
('R015', 'C002', 'B015', 'Historical epic.', 'liked', 4.10),
('R016', 'C003', 'B016', 'Spooky and good.', 'liked', 4.00),
('R017', 'C004', 'B017', 'Sweet story.', 'liked', 4.40),
('R018', 'C005', 'B018', 'Timeless epic.', 'liked', 4.60),
('R019', 'C006', 'B019', 'Exciting series.', 'liked', 4.50),
('R020', 'C007', 'B020', 'Mind-blowing.', 'liked', 4.70);
INSERT INTO `Order` (orderId, saleDateTime, totalprice, paymentMethod, vendorId, customerId, discounts, qty, bookId, veriflyNumber) VALUES
('OR001', '2025-06-01 10:00:00', 15.99, 'Credit Card', 'V001', 'C001', 0.00, 1, 'B001', 'VN001'),
('OR002', '2025-06-02 11:30:00', 12.99, 'PayPal', 'V002', 'C002', 5.00, 1, 'B002', 'VN002'),
('OR003', '2025-06-03 13:45:00', 14.99, 'Bank Transfer', 'V003', 'C003', 0.00, 1, 'B003', 'VN003'),
('OR004', '2025-06-04 09:15:00', 13.99, 'Credit Card', 'V004', 'C004', 2.00, 1, 'B004', 'VN004'),
('OR005', '2025-06-05 14:30:00', 16.99, 'PayPal', 'V005', 'C005', 0.00, 1, 'B005', 'VN005'),
('OR006', '2025-06-06 16:00:00', 19.99, 'Bank Transfer', 'V006', 'C006', 3.00, 1, 'B006', 'VN006'),
('OR007', '2025-06-07 08:45:00', 11.99, 'Credit Card', 'V007', 'C007', 0.00, 1, 'B007', 'VN007'),
('OR008', '2025-06-08 12:15:00', 14.99, 'PayPal', 'V001', 'C008', 5.00, 1, 'B008', 'VN008'),
('OR009', '2025-06-09 10:30:00', 10.99, 'Bank Transfer', 'V002', 'C009', 0.00, 1, 'B009', 'VN009'),
('OR010', '2025-06-10 15:00:00', 18.99, 'Credit Card', 'V003', 'C010', 2.00, 1, 'B010', 'VN010'),
('OR011', '2025-06-11 11:45:00', 17.99, 'PayPal', 'V004', 'C011', 0.00, 1, 'B011', 'VN011'),
('OR012', '2025-06-12 09:30:00', 15.99, 'Bank Transfer', 'V005', 'C012', 3.00, 1, 'B012', 'VN012'),
('OR013', '2025-06-13 14:15:00', 13.99, 'Credit Card', 'V006', 'C013', 0.00, 1, 'B013', 'VN013'),
('OR014', '2025-06-14 16:00:00', 16.99, 'PayPal', 'V007', 'C001', 5.00, 1, 'B014', 'VN014'),
('OR015', '2025-06-15 10:00:00', 14.99, 'Bank Transfer', 'V001', 'C002', 0.00, 1, 'B015', 'VN015'),
('OR016', '2025-06-15 11:30:00', 12.99, 'Credit Card', 'V002', 'C003', 2.00, 1, 'B016', 'VN016'),
('OR017', '2025-06-15 13:45:00', 9.99, 'PayPal', 'V003', 'C004', 0.00, 1, 'B017', 'VN017'),
('OR018', '2025-06-15 15:00:00', 11.99, 'Bank Transfer', 'V004', 'C005', 3.00, 1, 'B018', 'VN018'),
('OR019', '2025-06-15 16:30:00', 15.99, 'Credit Card', 'V005', 'C006', 0.00, 1, 'B019', 'VN019'),
('OR020', '2025-06-15 18:00:00', 19.99, 'PayPal', 'V006', 'C007', 5.00, 1, 'B020', 'VN020');
INSERT INTO OrderItem (orderId, bookInventoryId, pricePerItem, quantity) VALUES
('OR001', 'BI001', 15.99, 1),
('OR002', 'BI002', 12.99, 1),
('OR003', 'BI003', 14.99, 1),
('OR004', 'BI004', 13.99, 1),
('OR005', 'BI005', 16.99, 1),
('OR006', 'BI006', 19.99, 1),
('OR007', 'BI007', 11.99, 1),
('OR008', 'BI008', 14.99, 1),
('OR009', 'BI009', 10.99, 1),
('OR010', 'BI010', 18.99, 1),
('OR011', 'BI011', 17.99, 1),
('OR012', 'BI012', 15.99, 1),
('OR013', 'BI013', 13.99, 1),
('OR014', 'BI014', 16.99, 1),
('OR015', 'BI015', 14.99, 1),
('OR016', 'BI016', 12.99, 1),
('OR017', 'BI017', 9.99, 1),
('OR018', 'BI018', 11.99, 1),
('OR019', 'BI019', 15.99, 1),
('OR020', 'BI020', 19.99, 1);

INSERT INTO Payment (paymentId, orderId, amount, paymentDate, method, status) VALUES
('PM001', 'OR001', 15.99, '2025-06-01 10:05:00', 'Credit Card', 'Completed'),
('PM002', 'OR002', 12.34, '2025-06-02 11:35:00', 'PayPal', 'Completed'),
('PM003', 'OR003', 14.99, '2025-06-03 13:50:00', 'Bank Transfer', 'Pending'),
('PM004', 'OR004', 13.69, '2025-06-04 09:20:00', 'Credit Card', 'Completed'),
('PM005', 'OR005', 16.99, '2025-06-05 14:35:00', 'PayPal', 'Completed'),
('PM006', 'OR006', 19.39, '2025-06-06 16:05:00', 'Bank Transfer', 'Pending'),
('PM007', 'OR007', 11.99, '2025-06-07 08:50:00', 'Credit Card', 'Completed'),
('PM008', 'OR008', 14.24, '2025-06-08 12:20:00', 'PayPal', 'Completed'),
('PM009', 'OR009', 10.99, '2025-06-09 10:35:00', 'Bank Transfer', 'Pending'),
('PM010', 'OR010', 18.59, '2025-06-10 15:05:00', 'Credit Card', 'Completed'),
('PM011', 'OR011', 17.99, '2025-06-11 11:50:00', 'PayPal', 'Completed'),
('PM012', 'OR012', 15.59, '2025-06-12 09:35:00', 'Bank Transfer', 'Pending'),
('PM013', 'OR013', 13.99, '2025-06-13 14:20:00', 'Credit Card', 'Completed'),
('PM014', 'OR014', 16.14, '2025-06-14 16:05:00', 'PayPal', 'Completed'),
('PM015', 'OR015', 14.99, '2025-06-15 10:05:00', 'Bank Transfer', 'Pending'),
('PM016', 'OR016', 12.69, '2025-06-15 11:35:00', 'Credit Card', 'Completed'),
('PM017', 'OR017', 9.99, '2025-06-15 13:50:00', 'PayPal', 'Completed'),
('PM018', 'OR018', 11.64, '2025-06-15 15:05:00', 'Bank Transfer', 'Pending'),
('PM019', 'OR019', 15.99, '2025-06-15 16:35:00', 'Credit Card', 'Completed');

