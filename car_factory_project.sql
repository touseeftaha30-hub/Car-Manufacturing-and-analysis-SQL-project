-- Cars and parts Manufacturing factory and sales analysis
CREATE DATABASE CAR_FAC;
USE CAR_FAC;
--  Tables 

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20),
    email VARCHAR(100),
    region VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE plants (
    plant_id INT PRIMARY KEY AUTO_INCREMENT,
    plant_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    plant_type VARCHAR(20)
);

CREATE TABLE parts (
    part_id INT PRIMARY KEY AUTO_INCREMENT,
    part_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    source_type VARCHAR(20)
);

CREATE TABLE car_models (
    model_id INT PRIMARY KEY AUTO_INCREMENT,
    model_name VARCHAR(100) NOT NULL,
    variant VARCHAR(50),
    category VARCHAR(50),
    base_price DECIMAL(12,2)
);

CREATE TABLE dealers (
    dealer_id INT PRIMARY KEY AUTO_INCREMENT,
    dealer_name VARCHAR(100) NOT NULL,
    region VARCHAR(50),
    city VARCHAR(50)
);


-- Linking Tables
CREATE TABLE part_production (
    part_production_id INT PRIMARY KEY AUTO_INCREMENT,
    part_id INT NOT NULL,
    plant_id INT NOT NULL,
    production_date DATE NOT NULL,
    quantity_produced INT NOT NULL,
    FOREIGN KEY (part_id) REFERENCES parts(part_id),
    FOREIGN KEY (plant_id) REFERENCES plants(plant_id)
);

CREATE TABLE part_supply (
    supply_id INT PRIMARY KEY AUTO_INCREMENT,
    part_id INT NOT NULL,
    supplier_id INT NOT NULL,
    plant_id INT NOT NULL,
    supply_date DATE NOT NULL,
    quantity INT NOT NULL,
    cost_per_unit DECIMAL(10,2),
    FOREIGN KEY (part_id) REFERENCES parts(part_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (plant_id) REFERENCES plants(plant_id)
);

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    part_id INT NOT NULL,
    plant_id INT NOT NULL,
    stock_quantity INT NOT NULL,
    last_updated DATE,
    FOREIGN KEY (part_id) REFERENCES parts(part_id),
    FOREIGN KEY (plant_id) REFERENCES plants(plant_id)
);

CREATE TABLE car_production (
    production_id INT PRIMARY KEY AUTO_INCREMENT,
    model_id INT NOT NULL,
    plant_id INT NOT NULL,
    production_date DATE NOT NULL,
    batch_no VARCHAR(30),
    quantity_produced INT NOT NULL,
    FOREIGN KEY (model_id) REFERENCES car_models(model_id),
    FOREIGN KEY (plant_id) REFERENCES plants(plant_id)
);

CREATE TABLE car_parts_mapping (
    mapping_id INT PRIMARY KEY AUTO_INCREMENT,
    model_id INT NOT NULL,
    part_id INT NOT NULL,
    quantity_required INT NOT NULL,
    FOREIGN KEY (model_id) REFERENCES car_models(model_id),
    FOREIGN KEY (part_id) REFERENCES parts(part_id)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    model_id INT NOT NULL,
    dealer_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity_sold INT NOT NULL,
    price DECIMAL(12,2),
    revenue DECIMAL(14,2),
    FOREIGN KEY (model_id) REFERENCES car_models(model_id),
    FOREIGN KEY (dealer_id) REFERENCES dealers(dealer_id)
);
-- Data for tables
INSERT INTO suppliers (supplier_name, contact_number, email, region, city) VALUES
('AutoParts Traders', '03001234567', 'info@autoparts.com', 'Punjab', 'Lahore'),
('Steel Core Industries', '03211234567', 'sales@steelcore.com', 'Sindh', 'Karachi'),
('Rubber Tech Ltd', '03331234567', 'contact@rubbertech.com', 'Punjab', 'Faisalabad'),
('PowerCell Batteries', '03451234567', 'info@powercell.com', 'Punjab', 'Sargodha'),
('Glass & Frame Co', '03011234567', 'sales@glassframe.com', 'Sindh', 'Hyderabad');

INSERT INTO plants (plant_name, location, plant_type) VALUES
('Lahore Assembly Plant', 'Lahore', 'assembly'),
('Karachi Parts Plant', 'Karachi', 'parts'),
('Faisalabad Combined Plant', 'Faisalabad', 'both'),
('Sargodha Parts Unit', 'Sargodha', 'parts');

INSERT INTO parts (part_name, category, source_type) VALUES
('Engine Block V4', 'engine', 'produced'),
('Chassis Frame', 'chassis', 'produced'),
('Tyre 15-inch', 'tyre', 'supplied'),
('Car Battery 60Ah', 'battery', 'produced'),
('Windshield Glass', 'glass', 'supplied'),
('Gearbox Manual', 'transmission', 'produced'),
('Headlight Assembly', 'lighting', 'supplied'),
('Seat Set Fabric', 'interior', 'supplied');

INSERT INTO car_models (model_name, variant, category, base_price) VALUES
('Falcon 1000', 'Base', 'Hatchback', 2200000.00),
('Falcon 1000', 'VXR', 'Hatchback', 2600000.00),
('Voyager Sedan', 'Standard', 'Sedan', 3500000.00),
('Voyager Sedan', 'Premium', 'Sedan', 4200000.00),
('Titan SUV', 'Base', 'SUV', 5500000.00),
('Titan SUV', 'Sport', 'SUV', 6300000.00);

INSERT INTO dealers (dealer_name, region, city) VALUES
('Prime Motors', 'Punjab', 'Lahore'),
('City Auto Hub', 'Sindh', 'Karachi'),
('Speedway Dealership', 'Punjab', 'Sargodha'),
('Highway Cars', 'KPK', 'Peshawar'),
('National Auto Gallery', 'Punjab', 'Faisalabad');


INSERT INTO part_production (part_id, plant_id, production_date, quantity_produced) VALUES
(1, 2, '2025-01-05', 500),
(1, 2, '2025-02-05', 480),
(2, 2, '2025-01-06', 600),
(2, 3, '2025-02-06', 550),
(4, 4, '2025-01-10', 800),
(4, 4, '2025-02-10', 750),
(6, 3, '2025-01-15', 400),
(6, 3, '2025-02-15', 420);

INSERT INTO part_supply (part_id, supplier_id, plant_id, supply_date, quantity, cost_per_unit) VALUES
(3, 3, 1, '2025-01-08', 1000, 4500.00),
(3, 3, 3, '2025-02-08', 950, 4600.00),
(5, 5, 1, '2025-01-09', 400, 8000.00),
(5, 5, 3, '2025-02-09', 380, 8200.00),
(7, 1, 1, '2025-01-11', 600, 3200.00),
(7, 1, 3, '2025-02-11', 580, 3300.00),
(8, 1, 1, '2025-01-12', 500, 6000.00),
(8, 1, 3, '2025-02-12', 470, 6100.00);

INSERT INTO inventory (part_id, plant_id, stock_quantity, last_updated) VALUES
(1, 2, 120, '2025-02-28'),
(2, 2, 150, '2025-02-28'),
(3, 1, 300, '2025-02-28'),
(4, 4, 200, '2025-02-28'),
(5, 1, 90, '2025-02-28'),
(6, 3, 110, '2025-02-28'),
(7, 1, 130, '2025-02-28'),
(8, 1, 95, '2025-02-28');

INSERT INTO car_production (model_id, plant_id, production_date, batch_no, quantity_produced) VALUES
(1, 1, '2025-01-15', 'B-101', 100),
(2, 1, '2025-01-16', 'B-102', 80),
(3, 3, '2025-01-18', 'B-103', 60),
(4, 3, '2025-01-19', 'B-104', 50),
(5, 1, '2025-01-20', 'B-105', 40),
(6, 1, '2025-01-21', 'B-106', 30),
(1, 1, '2025-02-15', 'B-107', 110),
(2, 1, '2025-02-16', 'B-108', 90),
(3, 3, '2025-02-18', 'B-109', 65),
(5, 1, '2025-02-20', 'B-110', 45);

INSERT INTO car_parts_mapping (model_id, part_id, quantity_required) VALUES
(1, 1, 1), (1, 2, 1), (1, 3, 4), (1, 4, 1), (1, 5, 1),
(2, 1, 1), (2, 2, 1), (2, 3, 4), (2, 4, 1), (2, 5, 1), (2, 7, 2),
(3, 1, 1), (3, 2, 1), (3, 3, 4), (3, 4, 1), (3, 6, 1), (3, 8, 5),
(5, 1, 1), (5, 2, 1), (5, 3, 4), (5, 4, 1), (5, 6, 1), (5, 7, 2), (5, 8, 5);

INSERT INTO sales (model_id, dealer_id, sale_date, quantity_sold, price, revenue) VALUES
(1, 1, '2025-01-20', 10, 2200000, 22000000),
(2, 2, '2025-01-21', 8, 2600000, 20800000),
(3, 3, '2025-01-22', 5, 3500000, 17500000),
(4, 1, '2025-01-23', 3, 4200000, 12600000),
(5, 4, '2025-01-24', 4, 5500000, 22000000),
(6, 5, '2025-01-25', 2, 6300000, 12600000),
(1, 2, '2025-02-20', 12, 2200000, 26400000),
(2, 3, '2025-02-21', 9, 2600000, 23400000),
(3, 1, '2025-02-22', 6, 3500000, 21000000),
(5, 5, '2025-02-24', 5, 5500000, 27500000);

-- Analysis quries 

-- 1. Total revenue by car model
SELECT car_models.model_id, model_name, SUM(revenue) AS total_revenue
FROM sales
RIGHT JOIN car_models ON car_models.model_id = sales.model_id
GROUP BY car_models.model_id, model_name;

-- 2. Dealer ranking based on revenue generation (CTE and Window Function)
WITH dealer_rank AS (
    SELECT dealer_id, SUM(quantity_sold) AS total_qty, SUM(revenue) AS total_rev
    FROM sales
    GROUP BY dealer_id
)
SELECT *,
    RANK() OVER (ORDER BY total_rev DESC) AS dealer_rank
FROM dealer_rank;

-- 3. Part wise production per plant
SELECT plant_id, part_id, SUM(quantity_produced) AS total_produced
FROM part_production
GROUP BY plant_id, part_id;

-- 4. Best selling model by dealer
SELECT sales.dealer_id, dealer_name, sales.model_id, model_name,
    SUM(quantity_sold) AS total_qty, SUM(revenue) AS total_revenue
FROM sales
RIGHT JOIN dealers ON sales.dealer_id = dealers.dealer_id
RIGHT JOIN car_models ON sales.model_id = car_models.model_id
GROUP BY model_name, sales.dealer_id, dealer_name, sales.model_id;

-- 5. Dealer performance category using CASE statement
SELECT sales.dealer_id, dealer_name, SUM(revenue) AS total_rev,
CASE
    WHEN SUM(revenue) > 50000000 THEN 'High Performer'
    WHEN SUM(revenue) <= 50000000 AND SUM(revenue) > 20000000 THEN 'Average Performer'
    WHEN SUM(revenue) <= 20000000 THEN 'Low Performer'
END AS status
FROM sales
JOIN dealers ON sales.dealer_id = dealers.dealer_id
GROUP BY sales.dealer_id, dealer_name;

-- 6. Stock status at each plant using CASE statement
SELECT inventory.plant_id, plant_name, stock_quantity,
CASE
    WHEN stock_quantity > 100 THEN 'Good Stock'
    WHEN stock_quantity <= 100 AND stock_quantity >= 95 THEN 'Normal Stock'
    WHEN stock_quantity < 95 THEN 'Low Stock'
END AS stock_status
FROM inventory
RIGHT JOIN  plants ON inventory.plant_id = plants.plant_id;

-- 7. Total cost spent per supplier
SELECT suppliers.supplier_id, supplier_name,
    COALESCE(SUM(cost_per_unit * quantity), 0) AS total_cost
FROM part_supply
RIGHT JOIN suppliers ON part_supply.supplier_id = suppliers.supplier_id
GROUP BY suppliers.supplier_id, supplier_name;

-- 8. Month-wise sales revenue trend
SELECT MONTH(sale_date) AS sale_month, SUM(revenue) AS total_revenue
FROM sales
GROUP BY MONTH(sale_date);
