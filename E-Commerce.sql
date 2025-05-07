-- USERS TABLE
CREATE TABLE Users (
    user_id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password_hash VARCHAR(255),
    phone_number VARCHAR(15),
    address TEXT,
    role ENUM('admin', 'customer', 'vendor')
);

-- CATEGORIES TABLE
CREATE TABLE Categories (
    category_id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);

-- PRODUCTS TABLE
CREATE TABLE Products (
    product_id VARCHAR(36) PRIMARY KEY,
    vendor_id VARCHAR(36),
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10,2),
    quantity_in_stock INT,
    category_id VARCHAR(36),
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (vendor_id) REFERENCES Users(user_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- ORDERS TABLE
CREATE TABLE Orders (
    order_id VARCHAR(36) PRIMARY KEY,
    user_id VARCHAR(36),
    total_amount DECIMAL(10,2),
    order_date DATETIME,
    status ENUM('pending', 'confirmed', 'delivered', 'cancelled'),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- ORDER ITEMS TABLE
CREATE TABLE Order_Items (
    order_item_id VARCHAR(36) PRIMARY KEY,
    order_id VARCHAR(36),
    product_id VARCHAR(36),
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- PAYMENTS TABLE
CREATE TABLE Payments (
    payment_id VARCHAR(36) PRIMARY KEY,
    order_id VARCHAR(36),
    payment_method ENUM('credit_card', 'debit_card', 'paypal', 'upi'),
    payment_date DATETIME,
    amount_paid DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- REVIEWS TABLE
CREATE TABLE Reviews (
    review_id VARCHAR(36) PRIMARY KEY,
    product_id VARCHAR(36),
    user_id VARCHAR(36),
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at DATETIME,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Admin
INSERT INTO Users VALUES 
('U001', 'Admin User', 'admin@freshharvest.com', 'hash_admin', '1234567890', 'HQ Address', 'admin');

-- Vendors
INSERT INTO Users VALUES 
('V001', 'Vendor One', 'vendor1@fh.com', 'hash_v1', '1111111111', 'Vendor One Address', 'vendor'),
('V002', 'Vendor Two', 'vendor2@fh.com', 'hash_v2', '1111111112', 'Vendor Two Address', 'vendor'),
('V003', 'Vendor Three', 'vendor3@fh.com', 'hash_v3', '1111111113', 'Vendor Three Address', 'vendor'),
('V004', 'Vendor Four', 'vendor4@fh.com', 'hash_v4', '1111111114', 'Vendor Four Address', 'vendor'),
('V005', 'Vendor Five', 'vendor5@fh.com', 'hash_v5', '1111111115', 'Vendor Five Address', 'vendor');

-- Customers
INSERT INTO Users VALUES 
('C001', 'Customer 1', 'cust1@fh.com', 'hash_c1', '9000000001', 'Cust 1 Address', 'customer'),
('C002', 'Customer 2', 'cust2@fh.com', 'hash_c2', '9000000002', 'Cust 2 Address', 'customer'),
('C003', 'Customer 3', 'cust3@fh.com', 'hash_c3', '9000000003', 'Cust 3 Address', 'customer'),
('C004', 'Customer 4', 'cust4@fh.com', 'hash_c4', '9000000004', 'Cust 4 Address', 'customer'),
('C005', 'Customer 5', 'cust5@fh.com', 'hash_c5', '9000000005', 'Cust 5 Address', 'customer'),
('C006', 'Customer 6', 'cust6@fh.com', 'hash_c6', '9000000006', 'Cust 6 Address', 'customer'),
('C007', 'Customer 7', 'cust7@fh.com', 'hash_c7', '9000000007', 'Cust 7 Address', 'customer'),
('C008', 'Customer 8', 'cust8@fh.com', 'hash_c8', '9000000008', 'Cust 8 Address', 'customer'),
('C009', 'Customer 9', 'cust9@fh.com', 'hash_c9', '9000000009', 'Cust 9 Address', 'customer'),
('C010', 'Customer 10', 'cust10@fh.com', 'hash_c10', '9000000010', 'Cust 10 Address', 'customer'),
('C011', 'Customer 11', 'cust11@fh.com', 'hash_c11', '9000000011', 'Cust 11 Address', 'customer'),
('C012', 'Customer 12', 'cust12@fh.com', 'hash_c12', '9000000012', 'Cust 12 Address', 'customer'),
('C013', 'Customer 13', 'cust13@fh.com', 'hash_c13', '9000000013', 'Cust 13 Address', 'customer'),
('C014', 'Customer 14', 'cust14@fh.com', 'hash_c14', '9000000014', 'Cust 14 Address', 'customer'),
('C015', 'Customer 15', 'cust15@fh.com', 'hash_c15', '9000000015', 'Cust 15 Address', 'customer'),
('C016', 'Customer 16', 'cust16@fh.com', 'hash_c16', '9000000016', 'Cust 16 Address', 'customer'),
('C017', 'Customer 17', 'cust17@fh.com', 'hash_c17', '9000000017', 'Cust 17 Address', 'customer'),
('C018', 'Customer 18', 'cust18@fh.com', 'hash_c18', '9000000018', 'Cust 18 Address', 'customer'),
('C019', 'Customer 19', 'cust19@fh.com', 'hash_c19', '9000000019', 'Cust 19 Address', 'customer'),
('C020', 'Customer 20', 'cust20@fh.com', 'hash_c20', '9000000020', 'Cust 20 Address', 'customer');

-- Categories
INSERT INTO Categories VALUES
('CAT01', 'Fruits', 'Fresh seasonal fruits'),
('CAT02', 'Vegetables', 'Organic green vegetables'),
('CAT03', 'Snacks', 'Homemade and traditional snacks');

-- Products
INSERT INTO Products VALUES
('P001', 'V001', 'Apple', 'Fresh red apples', 120.00, 50, 'CAT01', NOW(), NOW()),
('P002', 'V002', 'Spinach', 'Organic spinach bunch', 40.00, 100, 'CAT02', NOW(), NOW()),
('P003', 'V003', 'Banana', 'Local bananas per dozen', 60.00, 80, 'CAT01', NOW(), NOW()),
('P004', 'V004', 'Potato Chips', 'Homemade potato chips', 50.00, 30, 'CAT03', NOW(), NOW()),
('P005', 'V005', 'Carrot', 'Fresh carrots', 45.00, 60, 'CAT02', NOW(), NOW());

-- Orders
INSERT INTO Orders VALUES 
('O001', 'C001', 240.00, '2025-04-01 12:00:00', 'confirmed'),
('O002', 'C002', 100.00, '2025-04-02 14:00:00', 'pending'),
('O003', 'C003', 180.00, '2025-04-05 09:30:00', 'delivered'),
('O004', 'C004', 120.00, '2025-04-03 10:45:00', 'cancelled'),
('O005', 'C005', 200.00, '2025-04-06 15:20:00', 'confirmed'),
('O006', 'C006', 250.00, '2025-04-07 13:10:00', 'confirmed'),
('O007', 'C007', 150.00, '2025-04-08 11:00:00', 'pending'),
('O008', 'C008', 230.00, '2025-04-09 17:20:00', 'confirmed'),
('O009', 'C009', 120.00, '2025-04-10 14:15:00', 'delivered'),
('O010', 'C010', 250.00, '2025-04-11 13:50:00', 'confirmed'),
('O011', 'C011', 300.00, '2025-04-12 16:00:00', 'pending'),
('O012', 'C012', 220.00, '2025-04-13 09:30:00', 'cancelled'),
('O013', 'C013', 190.00, '2025-04-14 18:00:00', 'confirmed'),
('O014', 'C014', 240.00, '2025-04-15 12:45:00', 'delivered'),
('O015', 'C015', 280.00, '2025-04-16 14:10:00', 'pending'),
('O016', 'C016', 160.00, '2025-04-17 11:50:00', 'confirmed'),
('O017', 'C017', 200.00, '2025-04-18 13:15:00', 'confirmed'),
('O018', 'C018', 220.00, '2025-04-19 14:25:00', 'delivered'),
('O019', 'C019', 190.00, '2025-04-20 15:30:00', 'confirmed'),
('O020', 'C020', 230.00, '2025-04-21 10:45:00', 'pending');

-- Order Items
INSERT INTO Order_Items VALUES 
('OI001', 'O001', 'P001', 2, 120.00),
('OI002', 'O001', 'P002', 1, 40.00),
('OI003', 'O002', 'P003', 1, 60.00),
('OI004', 'O003', 'P004', 2, 50.00),
('OI005', 'O003', 'P005', 1, 45.00),
('OI006', 'O004', 'P001', 1, 120.00),
('OI007', 'O005', 'P002', 1, 40.00),
('OI008', 'O005', 'P004', 2, 50.00),
('OI009', 'O006', 'P003', 3, 60.00),
('OI010', 'O006', 'P005', 2, 45.00),
('OI011', 'O007', 'P001', 1, 120.00),
('OI012', 'O008', 'P002', 2, 40.00),
('OI013', 'O009', 'P003', 2, 60.00),
('OI014', 'O010', 'P004', 3, 50.00),
('OI015', 'O010', 'P005', 2, 45.00),
('OI016', 'O011', 'P003', 1, 60.00),
('OI017', 'O012', 'P002', 1, 40.00),
('OI018', 'O013', 'P001', 2, 120.00),
('OI019', 'O014', 'P002', 3, 40.00),
('OI020', 'O015', 'P003', 2, 60.00);

-- Payments
INSERT INTO Payments VALUES 
('PM001', 'O001', 'credit_card', '2025-04-01 12:00:00', 240.00),
('PM002', 'O002', 'debit_card', '2025-04-02 14:00:00', 100.00),
('PM003', 'O003', 'paypal', '2025-04-05 09:30:00', 180.00),
('PM004', 'O004', 'upi', '2025-04-03 10:45:00', 120.00),
('PM005', 'O005', 'credit_card', '2025-04-06 15:20:00', 200.00),
('PM006', 'O006', 'debit_card', '2025-04-07 13:10:00', 250.00),
('PM007', 'O007', 'paypal', '2025-04-08 11:00:00', 150.00),
('PM008', 'O008', 'upi', '2025-04-09 17:20:00', 230.00),
('PM009', 'O009', 'credit_card', '2025-04-10 14:15:00', 120.00),
('PM010', 'O010', 'debit_card', '2025-04-11 13:50:00', 250.00),
('PM011', 'O011', 'paypal', '2025-04-12 16:00:00', 300.00),
('PM012', 'O012', 'upi', '2025-04-13 09:30:00', 220.00),
('PM013', 'O013', 'credit_card', '2025-04-14 18:00:00', 190.00),
('PM014', 'O014', 'debit_card', '2025-04-15 12:45:00', 240.00),
('PM015', 'O015', 'paypal', '2025-04-16 14:10:00', 280.00),
('PM016', 'O016', 'upi', '2025-04-17 11:50:00', 160.00),
('PM017', 'O017', 'credit_card', '2025-04-18 13:15:00', 200.00),
('PM018', 'O018', 'debit_card', '2025-04-19 14:25:00', 220.00),
('PM019', 'O019', 'paypal', '2025-04-20 15:30:00', 190.00),
('PM020', 'O020', 'upi', '2025-04-21 10:45:00', 230.00);

-- Reviews
INSERT INTO Reviews VALUES 
('R001', 'P001', 'C001', 5, 'Good quality product!', '2025-04-01 12:00:00'),
('R002', 'P002', 'C002', 4, 'Nice fresh spinach.', '2025-04-02 14:00:00'),
('R003', 'P003', 'C003', 5, 'Bananas were ripe and tasty.', '2025-04-05 09:30:00'),
('R004', 'P004', 'C004', 3, 'Could be crisper, but still good.', '2025-04-03 10:45:00'),
('R005', 'P005', 'C005', 4, 'Carrots were fresh and crunchy.', '2025-04-06 15:20:00'),
('R006', 'P001', 'C006', 5, 'Excellent apples!', '2025-04-07 13:10:00'),
('R007', 'P003', 'C007', 4, 'Sweet bananas.', '2025-04-08 11:00:00'),
('R008', 'P002', 'C008', 3, 'Spinach was a bit wilted.', '2025-04-09 17:20:00'),
('R009', 'P004', 'C009', 5, 'Loved the chips!', '2025-04-10 14:15:00'),
('R010', 'P005', 'C010', 4, 'Good carrots but a bit expensive.', '2025-04-11 13:50:00'),
('R011', 'P001', 'C011', 5, 'Best apples I’ve ever had!', '2025-04-12 16:00:00'),
('R012', 'P002', 'C012', 4, 'Fresh spinach.', '2025-04-13 09:30:00'),
('R013', 'P003', 'C013', 5, 'Tasty and ripe.', '2025-04-14 18:00:00'),
('R014', 'P004', 'C014', 3, 'Not crispy enough.', '2025-04-15 12:45:00'),
('R015', 'P005', 'C015', 4, 'Good quality carrots.', '2025-04-16 14:10:00'),
('R016', 'P001', 'C016', 5, 'Delicious apples!', '2025-04-17 11:50:00'),
('R017', 'P002', 'C017', 4, 'Good spinach.', '2025-04-18 13:15:00'),
('R018', 'P003', 'C018', 5, 'Great bananas.', '2025-04-19 14:25:00'),
('R019', 'P004', 'C019', 3, 'Not crispy enough.', '2025-04-20 15:30:00'),
('R020', 'P005', 'C020', 4, 'Good carrots.', '2025-04-21 10:45:00');

-- Users
select * from users;

-- Categories
select * from categories;

-- Products
select * from products;

-- Orders
select * from orders;

-- Order Items
select * from order_items;

-- Payments
select * from payments;

-- Reviews
select * from reviews;

-- SQL query to list all users who are customers.
select * from users where role = "customer";

-- SQL query to get the total number of products available in the store.
select count(*) as No_of_Products from products;

-- SQL query to find the total revenue generated from all orders.
select sum(total_amount) as Total_Revenue from orders;

-- SQL query to list all orders placed by a specific customer.
select * from users join orders on users.user_id = orders.user_id;

-- SQL query to find the most expensive product in the store.
select name as expensive_product from products group by name having max(price) limit 1;

-- SQL query to list all products in a specific category.
select * from products join categories on products.category_id = categories.category_id;

-- SQL query to get the average rating for a specific product.
select products.name, avg(reviews.rating) as average_rating from reviews join products 
                  on reviews.product_id = products.product_id group by products.name;
                  
-- SQL query to find the number of orders for a specific product
select products.name, count(*) as Orders_No from orders join order_items
                               on orders.order_id = order_items.order_id join
                                     products on products.product_id = order_items.product_id 
                                                  group by products.name;

-- SQL query to find products with no reviews.
select * from reviews left join products on reviews.product_id = products.product_id
                                        where reviews.product_id is null;
                                        
-- SQL query to find the total number of orders for each user.
select users.name, count(*) as Orders_No from orders join users
                               on orders.user_id = users.user_id group by users.name;
                               
-- SQL query to list all products with their category names.
select products.*, categories.name from products join categories 
                   on products.category_id = categories.category_id;
                   
-- SQL query to find the total number of products sold in each category
select categories.name, count(*) as noof_sold_Products from categories join products on
                           categories.category_id = products.category_id join
                                    order_items on products.product_id = order_items.product_id 
                                                        group by categories.name;
                                      
-- SQL query to find the average price of products in each category.
select categories.name, avg(products.price) as average_Product_Price
                         from products join categories on
                               categories.category_id = products.category_id
                                             group by categories.name;
                                             
-- SQL query to find all orders with a total amount greater than 200 
select * from orders where orders.total_amount > 200; 

-- SQL query to find the most popular product (based on order count).
select products.name as popular_product from orders, products, order_items
                               where orders.order_id = order_items.order_id 
                                      and products.product_id = order_items.product_id 
                                           group by products.name order by count(orders.order_id) desc limit 1;  
                                           
-- SQL query to list the total revenue generated by each product.
select products.name, sum(order_items.price) as revenue from products 
                                 join order_items on products.product_id = order_items.product_id 
                                         group by products.name;
                                         
-- SQL query to update the stock quantity of a product after an order is placed.                                         
UPDATE Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
SET p.quantity_in_stock = p.quantity_in_stock - oi.quantity
WHERE oi.order_id = "OI002" ;
select * from order_items;
select * from products;

-- SQL query to find the top 3 highest-grossing products.
select products.name, sum(order_items.price) as revenue from products 
                                 join order_items on products.product_id = order_items.product_id 
                                         group by products.name order by revenue desc limit 3;                                        

-- SQL query to get the percentage of orders delivered, cancelled, and pending.
select 
    status,
    count(*) * 100.0 / total.total_count as percentage
from 
    orders,
    (select count(*) as total_count from orders) as total
group by 
    status, total.total_count;

-- SQL query to find the total revenue per vendor.
select users.name, sum(order_items.price) as revenue from products 
                                 join order_items on products.product_id = order_items.product_id 
                                 join users on products.vendor_id = users.user_id
                                         group by users.name;

-- SQL query to find the products with the highest average review rating
  select products.name from products join reviews 
                  on products.product_id = reviews.product_id group by products.name
                          having avg(reviews.rating) ;                                       

-- SQL query to find products have been ordered the most and how many times.

select name, count(*) as times_ordered
from order_items oi
join products p on oi.product_id = p.product_id
group by oi.product_id;  

-- SQL query to find average order value for each month

select oi.order_id, month(order_date) as month, (quantity * price) as total
from order_items oi
 join orders o on o.order_id = oi.order_id;
 
 
                                         