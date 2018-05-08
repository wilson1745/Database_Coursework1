DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Photo;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Owner;

CREATE TABLE Owner (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL, 
	username VARCHAR(50) NOT NULL, 
	email VARCHAR(100) UNIQUE
);

CREATE TABLE Customer (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	username VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	delivery VARCHAR(100) NOT NULL
);

CREATE TABLE Category (
  id INTEGER PRIMARY KEY AUTO_INCREMENT, 
  heading VARCHAR(100) NOT NULL
);

CREATE TABLE Products (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	price DOUBLE NOT NULL,
	description VARCHAR(100) NULL, 
	owner INTEGER NOT NULL, 
	category INTEGER NOT NULL, 
  FOREIGN KEY (owner) REFERENCES Owner (id), 
  FOREIGN KEY (category) REFERENCES Category (id)
);

CREATE TABLE Photo (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
  dates DATETIME NOT NULL,
  products INTEGER NOT NULL,
  FOREIGN KEY (products) REFERENCES Products(id) 
);

CREATE TABLE Orders (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  dates DATETIME NOT NULL,
  quantity INTEGER NOT NULL,
  payment_method VARCHAR(100) NOT NULL,
  memo VARCHAR(100) NULL,
  products INTEGER NOT NULL,
  customer INTEGER NOT NULL,
  FOREIGN KEY (products) REFERENCES Products(id),
  FOREIGN KEY (customer) REFERENCES Customer(id)
);
