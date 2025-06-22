DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Order_Books;

DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Genres;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Orders;

CREATE TABLE Authors (
	id INT PRIMARY KEY,
	name TEXT UNIQUE NOT NULL
	);
CREATE TABLE Genres (
	id INT PRIMARY KEY,
	name TEXT UNIQUE NOT NULL
	);
CREATE TABLE Books (
	id INT PRIMARY KEY,
	name TEXT UNIQUE NOT NULL,
	author_id INT NOT NULL,
	genre_id INT NOT NULL,
	FOREIGN KEY (author_id) REFERENCES Authors(id) ON DELETE CASCADE,
	FOREIGN KEY (genre_id) REFERENCES Genres(id) ON DELETE CASCADE
	);
	
INSERT INTO Authors (id, name) VALUES 
	(1, 'J.K. Rowling'),
	(2, 'George Orwell'),
	(3, 'Agatha Christie'),
	(4, 'J.R.R. Tolkien'),
	(5, 'Jane Austen');
INSERT INTO Genres (id, name) VALUES 
	(1, 'Fantasy'),
	(2, 'Dystopian'),
	(3, 'Mystery'),
	(4, 'Classic'),
	(5, 'Romance');
INSERT INTO Books (id, name, author_id, genre_id) VALUES 
	(1, 'Harry Potter and the Philosopher''s Stone', 1, 1),
	(2, '1984', 2, 2),
	(3, 'Murder on the Orient Express', 3, 3),
	(4, 'The Hobbit', 4, 1),
	(5, 'Pride and Prejudice', 5, 5),
	(6, 'The Lord of the Rings', 4, 1),
	(7, 'Animal Farm', 2, 2),
	(8, 'Emma', 5, 4),
	(9, 'Harry Potter and the Chamber of Secrets', 1, 1),
	(10, 'And Then There Were None', 3, 3);
	
CREATE TABLE Users (
	id INT PRIMARY KEY,
	name TEXT UNIQUE NOT NULL
	);
CREATE TABLE Orders (
	id INT PRIMARY KEY,
	user_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
	);
CREATE TABLE Order_Books (
	order_id INT NOT NULL,
	book_id INT NOT NULL,
	amount INT NOT NULL CHECK (amount > 0) DEFAULT 1,
	PRIMARY KEY (order_id, book_id),
	FOREIGN KEY (order_id) REFERENCES Orders(id) ON DELETE CASCADE,
	FOREIGN KEY (book_id) REFERENCES Books(id) ON DELETE CASCADE
	);
	
INSERT INTO Users (id, name) VALUES 
	(1, 'Иван Петров'),
	(2, 'Мария Сидорова'),
	(3, 'Алексей Иванов'),
	(4, 'Елена Кузнецова'),
	(5, 'Дмитрий Смирнов');
INSERT INTO Orders (id, user_id) VALUES 
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 1),
	(5, 4);
INSERT INTO Order_Books (order_id, book_id, amount) VALUES 
	(1, 1, 1),
	(1, 5, 2),
	(2, 3, 1),
	(3, 6, 1),
	(3, 4, 1),
	(4, 2, 3),
	(5, 9, 1),
	(5, 10, 1);
INSERT INTO Order_Books (order_id, book_id) VALUES 
	(1, 7);
	
SELECT 
	Users.name AS user,
	Books.name 	AS book,
	Authors.name AS author,
	Genres.name AS genre,
	Order_Books.amount
FROM Users
JOIN Orders ON Users.id = Orders.user_id
JOIN Order_Books ON Orders.id = Order_Books.order_id
JOIN Books ON Order_Books.book_id = Books.id
JOIN Genres ON Books.genre_id = Genres.id
JOIN Authors ON Books.author_id = Authors.id
ORDER BY Users.name