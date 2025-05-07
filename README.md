
<body>
    <h1>E-Commerce Platform Database Schema</h1>
    <p>This repository contains the database schema for an e-commerce platform that includes user management, product listing, orders, payments, reviews, and more. The platform supports various user roles such as <strong>admin</strong>, <strong>customer</strong>, and <strong>vendor</strong>.</p>
    <h2 id="users-table">1. Users Table</h2>
    <p>This table stores information about the users of the platform. It supports the following roles: <strong>admin</strong>, <strong>customer</strong>, and <strong>vendor</strong>.</p>
    <pre>
CREATE TABLE Users (
    user_id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password_hash VARCHAR(255),
    phone_number VARCHAR(15),
    address TEXT,
    role ENUM('admin', 'customer', 'vendor')
);
    </pre>
    <ul>
        <li><strong>user_id</strong>: Unique identifier for the user.</li>
        <li><strong>name</strong>: Name of the user.</li>
        <li><strong>email</strong>: Email address of the user (unique).</li>
        <li><strong>password_hash</strong>: Encrypted password for authentication.</li>
        <li><strong>phone_number</strong>: Contact number of the user.</li>
        <li><strong>address</strong>: Address of the user.</li>
        <li><strong>role</strong>: Role of the user (admin, customer, vendor).</li>
    </ul>
    <h2 id="categories-table">2. Categories Table</h2>
    <p>This table stores different product categories.</p>
    <pre>
CREATE TABLE Categories (
    category_id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);
    </pre>
    <ul>
        <li><strong>category_id</strong>: Unique identifier for the category.</li>
        <li><strong>name</strong>: Name of the category.</li>
        <li><strong>description</strong>: Description of the category.</li>
    </ul>
    <h2 id="products-table">3. Products Table</h2>
    <p>This table stores the product details listed by vendors.</p>
    <pre>
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
    </pre>
    <ul>
        <li><strong>product_id</strong>: Unique identifier for the product.</li>
        <li><strong>vendor_id</strong>: ID of the vendor who sells the product.</li>
        <li><strong>name</strong>: Name of the product.</li>
        <li><strong>description</strong>: Description of the product.</li>
        <li><strong>price</strong>: Price of the product.</li>
        <li><strong>quantity_in_stock</strong>: Available stock quantity of the product.</li>
        <li><strong>category_id</strong>: ID of the category to which the product belongs.</li>
        <li><strong>created_at</strong>: Timestamp of when the product was created.</li>
        <li><strong>updated_at</strong>: Timestamp of when the product was last updated.</li>
    </ul>
    <h2 id="orders-table">4. Orders Table</h2>
    <p>This table records information about orders placed by customers.</p>
    <pre>
CREATE TABLE Orders (
    order_id VARCHAR(36) PRIMARY KEY,
    user_id VARCHAR(36),
    total_amount DECIMAL(10,2),
    order_date DATETIME,
    status ENUM('pending', 'confirmed', 'delivered', 'cancelled'),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
    </pre>
    <ul>
        <li><strong>order_id</strong>: Unique identifier for the order.</li>
        <li><strong>user_id</strong>: ID of the customer who placed the order.</li>
        <li><strong>total_amount</strong>: Total amount for the order.</li>
        <li><strong>order_date</strong>: Timestamp of when the order was placed.</li>
        <li><strong>status</strong>: Current status of the order (pending, confirmed, delivered, cancelled).</li>
    </ul>
    <h2 id="order-items-table">5. Order Items Table</h2>
    <p>This table stores details about each product in an order.</p>
    <pre>
CREATE TABLE Order_Items (
    order_item_id VARCHAR(36) PRIMARY KEY,
    order_id VARCHAR(36),
    product_id VARCHAR(36),
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
    </pre>
    <ul>
        <li><strong>order_item_id</strong>: Unique identifier for the order item.</li>
        <li><strong>order_id</strong>: ID of the order to which the product belongs.</li>
        <li><strong>product_id</strong>: ID of the product in the order.</li>
        <li><strong>quantity</strong>: Quantity of the product in the order.</li>
        <li><strong>price</strong>: Price of the product in the order.</li>
    </ul>
    <h2 id="payments-table">6. Payments Table</h2>
    <p>This table stores payment details for each order.</p>
    <pre>
CREATE TABLE Payments (
    payment_id VARCHAR(36) PRIMARY KEY,
    order_id VARCHAR(36),
    payment_method ENUM('credit_card', 'debit_card', 'paypal', 'upi'),
    payment_date DATETIME,
    amount_paid DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
    </pre>
    <ul>
        <li><strong>payment_id</strong>: Unique identifier for the payment.</li>
        <li><strong>order_id</strong>: ID of the order associated with the payment.</li>
        <li><strong>payment_method</strong>: Method used for payment (credit_card, debit_card, paypal, upi).</li>
        <li><strong>payment_date</strong>: Timestamp of when the payment was made.</li>
        <li><strong>amount_paid</strong>: Amount paid for the order.</li>
    </ul>
    <h2 id="reviews-table">7. Reviews Table</h2>
    <p>This table stores product reviews provided by customers.</p>
    <pre>
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
    </pre>
    <ul>
        <li><strong>review_id</strong>: Unique identifier for the review.</li>
        <li><strong>product_id</strong>: ID of the product being reviewed.</li>
        <li><strong>user_id</strong>: ID of the customer who provided the review.</li>
        <li><strong>rating</strong>: Rating given to the product (1 to 5).</li>
        <li><strong>comment</strong>: Customer's comment about the product.</li>
        <li><strong>created_at</strong>: Timestamp of when the review was created.</li>
    </ul>
    <h2>Setup</h2>
    <p>To set up this schema in your own database:</p>
    <ol>
        <li>Clone this repository.</li>
        <li>Run the SQL scripts in your preferred SQL client or database management system.</li>
        <li>Ensure your application connects to the database to handle CRUD operations for the users, products, orders, payments, and reviews.</li>
    </ol>
    <h2>Contributing</h2>
    <p>Feel free to fork this repository and submit pull requests. Any contributions to improve the database schema, design, or feature set are welcome!</p>
</body>
