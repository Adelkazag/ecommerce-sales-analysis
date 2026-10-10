-- Run ONCE in an EMPTY database named ecommerce_analysis.
CREATE TABLE customers (
 customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 first_name VARCHAR(100) NOT NULL, last_name VARCHAR(100) NOT NULL,
 email VARCHAR(255) UNIQUE NOT NULL, registration_date DATE NOT NULL
);
CREATE TABLE products (
 product_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 product_name VARCHAR(255) NOT NULL, category VARCHAR(100) NOT NULL,
 price NUMERIC(10,2) NOT NULL CHECK(price >= 0),
 cost NUMERIC(10,2) NOT NULL CHECK(cost >= 0)
);
CREATE TABLE orders (
 order_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
 order_date DATE NOT NULL, status VARCHAR(30) NOT NULL
);
CREATE TABLE order_items (
 order_item_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 order_id INTEGER NOT NULL REFERENCES orders(order_id),
 product_id INTEGER NOT NULL REFERENCES products(product_id),
 quantity INTEGER NOT NULL CHECK(quantity > 0),
 unit_price NUMERIC(10,2) NOT NULL CHECK(unit_price >= 0)
);
INSERT INTO customers(first_name,last_name,email,registration_date) VALUES
('Иван','Петров','ivan.petrov@example.com','2025-01-10'),
('Анна','Смирнова','anna.smirnova@example.com','2025-01-15'),
('Павел','Иванов','pavel.ivanov@example.com','2025-02-01'),
('Мария','Кузнецова','maria.k@example.com','2025-02-10'),
('Дмитрий','Соколов','d.sokolov@example.com','2025-03-05'),
('Елена','Попова','elena.popova@example.com','2025-03-12'),
('Алексей','Лебедев','alex.lebedev@example.com','2025-04-01'),
('Ольга','Новикова','olga.novikova@example.com','2025-04-15');
INSERT INTO products(product_name,category,price,cost) VALUES
('Ноутбук','Электроника',80000,62000),('Смартфон','Электроника',50000,38000),
('Наушники','Аксессуары',8000,4500),('Клавиатура','Аксессуары',5000,2800),
('Монитор','Электроника',25000,18000),('Мышь','Аксессуары',3000,1200),
('Планшет','Электроника',35000,27000),('Веб-камера','Аксессуары',6000,3500);
INSERT INTO orders(customer_id,order_date,status) VALUES
(1,'2025-01-20','delivered'),(2,'2025-01-25','delivered'),
(1,'2025-02-15','delivered'),(3,'2025-02-20','delivered'),
(4,'2025-03-01','delivered'),(5,'2025-03-10','delivered'),
(2,'2025-03-15','delivered'),(6,'2025-04-05','delivered'),
(7,'2025-04-12','delivered'),(1,'2025-04-20','delivered'),
(8,'2025-05-02','processing'),(3,'2025-05-10','cancelled'),
(4,'2025-05-15','delivered'),(5,'2025-06-01','delivered'),
(2,'2025-06-10','delivered');
INSERT INTO order_items(order_id,product_id,quantity,unit_price) VALUES
(1,1,1,80000),(1,3,1,8000),(2,2,1,50000),(2,6,2,3000),
(3,3,2,8000),(3,4,1,5000),(4,5,1,25000),(4,6,1,3000),
(5,7,1,35000),(5,8,1,6000),(6,1,1,80000),(6,4,1,5000),
(7,2,1,50000),(7,3,1,8000),(8,6,3,3000),(8,8,1,6000),
(9,5,2,25000),(10,4,2,5000),(10,6,1,3000),(11,7,1,35000),
(12,2,1,50000),(13,3,1,8000),(13,8,2,6000),(14,1,1,80000),
(14,5,1,25000),(15,2,1,50000),(15,6,1,3000);
