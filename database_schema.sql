-- ============================================================
-- KIA GARAGE FINTECH SYSTEM - DATABASE SCHEMA
-- ============================================================
-- This file shows HOW the database would be set up in real life.
-- In our React app we simulate this data using JavaScript objects.
-- You can run this in MySQL, PostgreSQL, or SQLite to create
-- a real backend later.
-- ============================================================


-- 1. CUSTOMERS TABLE
-- Stores every person who bought a KIA car
CREATE TABLE customers (
  customer_id     INT PRIMARY KEY AUTO_INCREMENT,
  full_name       VARCHAR(100)  NOT NULL,
  email           VARCHAR(100)  UNIQUE NOT NULL,
  phone           VARCHAR(15),
  address         TEXT,
  joined_date     DATE          NOT NULL DEFAULT (CURRENT_DATE),
  loyalty_points  INT           DEFAULT 0    -- points earned from purchases
);


-- 2. CARS TABLE
-- Every KIA car registered in the garage
CREATE TABLE cars (
  car_id          INT PRIMARY KEY AUTO_INCREMENT,
  customer_id     INT           NOT NULL,
  model           VARCHAR(50),   -- e.g. KIA Seltos, Sonet, Carens
  variant         VARCHAR(30),   -- e.g. HTX, GTX+
  color           VARCHAR(20),
  reg_number      VARCHAR(20)   UNIQUE,
  purchase_date   DATE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


-- 3. SERVICES TABLE
-- Every service job done in the garage
CREATE TABLE services (
  service_id      INT PRIMARY KEY AUTO_INCREMENT,
  car_id          INT           NOT NULL,
  service_type    VARCHAR(50),   -- e.g. Oil Change, Wheel Alignment
  description     TEXT,
  service_date    DATE          NOT NULL,
  cost            DECIMAL(10,2) NOT NULL,
  status          ENUM('Pending','In Progress','Completed') DEFAULT 'Pending',
  mechanic_name   VARCHAR(50),
  FOREIGN KEY (car_id) REFERENCES cars(car_id)
);


-- 4. PAYMENTS TABLE
-- All payments made by customers (for car purchase or service)
CREATE TABLE payments (
  payment_id      INT PRIMARY KEY AUTO_INCREMENT,
  customer_id     INT           NOT NULL,
  service_id      INT,           -- NULL if this is a car purchase payment
  amount          DECIMAL(10,2) NOT NULL,
  payment_method  ENUM('Cash','Card','UPI','Loan','Bank Transfer'),
  payment_date    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status          ENUM('Paid','Pending','Refunded') DEFAULT 'Paid',
  invoice_number  VARCHAR(30)   UNIQUE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (service_id)  REFERENCES services(service_id)
);


-- 5. CASHBACKS TABLE
-- Cashbacks given to customers on purchases or services
CREATE TABLE cashbacks (
  cashback_id     INT PRIMARY KEY AUTO_INCREMENT,
  customer_id     INT           NOT NULL,
  payment_id      INT           NOT NULL,
  cashback_amount DECIMAL(10,2) NOT NULL,
  reason          VARCHAR(100), -- e.g. "Festival Offer", "First Service Free"
  applied_date    DATE,
  is_redeemed     BOOLEAN       DEFAULT FALSE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (payment_id)  REFERENCES payments(payment_id)
);


-- ============================================================
-- SAMPLE DATA (for testing)
-- ============================================================

INSERT INTO customers (full_name, email, phone, address, loyalty_points) VALUES
  ('Ravi Sharma',     'ravi@email.com',   '9876543210', 'Mumbai, Maharashtra',     120),
  ('Priya Mehta',     'priya@email.com',  '9123456789', 'Pune, Maharashtra',        80),
  ('Arjun Singh',     'arjun@email.com',  '9012345678', 'Delhi, NCR',              200),
  ('Sneha Patil',     'sneha@email.com',  '9654321087', 'Nagpur, Maharashtra',      50);

INSERT INTO cars (customer_id, model, variant, color, reg_number, purchase_date) VALUES
  (1, 'KIA Seltos',  'HTX+',  'Steel Silver', 'MH12-AB-1234', '2024-01-15'),
  (2, 'KIA Sonet',   'GTX',   'Gravity Grey',  'MH14-CD-5678', '2024-03-20'),
  (3, 'KIA Carens',  'Prestige+', 'Aurora Black Pearl', 'DL01-EF-9012', '2023-11-10'),
  (4, 'KIA EV6',     'GT Line', 'Snow White',  'MH31-GH-3456', '2024-05-01');

INSERT INTO services (car_id, service_type, description, service_date, cost, status, mechanic_name) VALUES
  (1, 'Oil Change',        'Engine oil replaced - 5W30 synthetic', '2024-06-10', 1800.00, 'Completed', 'Manoj Kumar'),
  (2, 'AC Service',        'AC gas refill and filter cleaning',     '2024-06-12', 2500.00, 'Completed', 'Deepak Rao'),
  (3, 'Wheel Alignment',   'Four wheel alignment + balancing',      '2024-06-15', 1200.00, 'In Progress','Suresh Nair'),
  (4, 'Annual Service',    'Full vehicle checkup and service',      '2024-06-18', 5500.00, 'Pending',   'Ramesh Joshi');

INSERT INTO payments (customer_id, service_id, amount, payment_method, payment_date, status, invoice_number) VALUES
  (1, 1, 1800.00, 'UPI',  '2024-06-10 10:30:00', 'Paid',    'INV-2024-001'),
  (2, 2, 2500.00, 'Card', '2024-06-12 14:00:00', 'Paid',    'INV-2024-002'),
  (3, 3, 1200.00, 'Cash', '2024-06-15 11:00:00', 'Pending', 'INV-2024-003'),
  (4, 4, 5500.00, 'UPI',  '2024-06-18 09:00:00', 'Pending', 'INV-2024-004');

INSERT INTO cashbacks (customer_id, payment_id, cashback_amount, reason, applied_date, is_redeemed) VALUES
  (1, 1, 180.00, 'Loyal Customer 10% Back',    '2024-06-10', TRUE),
  (2, 2, 250.00, 'Weekend Special Offer',       '2024-06-12', FALSE),
  (3, 3,  60.00, 'First Time Service Discount', '2024-06-15', FALSE);


-- ============================================================
-- USEFUL QUERIES (run these to see the data)
-- ============================================================

-- See all customers and their cars
SELECT c.full_name, c.loyalty_points, cr.model, cr.reg_number
FROM customers c
JOIN cars cr ON c.customer_id = cr.customer_id;

-- See all pending services
SELECT s.service_type, s.cost, s.status, cu.full_name
FROM services s
JOIN cars ca ON s.car_id = ca.car_id
JOIN customers cu ON ca.customer_id = cu.customer_id
WHERE s.status != 'Completed';

-- Total cashback per customer
SELECT cu.full_name, SUM(cb.cashback_amount) AS total_cashback
FROM cashbacks cb
JOIN customers cu ON cb.customer_id = cu.customer_id
GROUP BY cu.full_name;
