-- Company
INSERT INTO Company (Business_license, Co_name, Establishment_date, Co_address_street, Co_address_city, Co_address_province)
VALUES
  ('123456789012345678', 'Company 1', '2020-01-01', 'Street 1', 'City 1', 'Province 1'),
  ('234567890123456789', 'Company 2', '2019-05-15', 'Street 2', 'City 2', 'Province 2'),
  ('345678901234567890', 'Company 3', '2022-03-10', 'Street 3', 'City 3', 'Province 3'),
  ('456789012345678901', 'Company 4', '2021-09-20', 'Street 4', 'City 4', 'Province 4'),
  ('567890123456789012', 'Company 5', '2023-02-28', 'Street 5', 'City 5', 'Province 5'),
  ('678901234567890123', 'Company 6', '2020-11-12', 'Street 6', 'City 6', 'Province 6');

-- Brand
INSERT INTO Brand (Br_Name, Launch_date, Business_license)
VALUES
  ('Brand 1', '2021-01-01', '123456789012345678'),
  ('Brand 2', '2020-05-15', '234567890123456789'),
  ('Brand 3', '2022-03-10', '345678901234567890'),
  ('Brand 4', '2021-09-20', '456789012345678901'),
  ('Brand 5', '2023-02-28', '567890123456789012'),
  ('Brand 6', '2020-11-12', '678901234567890123'),
  ('Brand 7', '2022-07-01', '123456789012345678'),
  ('Brand 8', '2021-04-25', '234567890123456789');

-- Product
INSERT INTO Product (Barcode, Pr_name, Br_Name, Weight)
VALUES
  ('123456789012', 'Product 1', 'Brand 1', 1.5),
  ('234567890123', 'Product 2', 'Brand 2', 2.5),
  ('345678901234', 'Product 3', 'Brand 3', 3.5),
  ('456789012345', 'Product 4', 'Brand 4', 1.5),
  ('567890123456', 'Product 5', 'Brand 5', 2.5),
  ('678901234567', 'Product 6', 'Brand 6', 3.5),
  ('789012345678', 'Product 7', 'Brand 7', 1.5),
  ('890123456789', 'Product 8', 'Brand 8', 2.5),
  ('901234567890', 'Product 9', 'Brand 1', 3.5),
  ('012345678901', 'Product 10', 'Brand 2', 1.5),
  ('123456789210', 'Product 11', 'Brand 3', 2.5),
  ('234567890321', 'Product 12', 'Brand 4', 3.5);

UPDATE Product
SET Weight = ROUND(RAND() * 10, 2);

-- Type
INSERT INTO Type (Ty_name)
VALUES
  ('Type 1'),
  ('Type 2'),
  ('Type 3'),
  ('Type 4'),
  ('Type 5'),
  ('Type 6'),
  ('Type 7'),
  ('Type 8'),
  ('Type 9'),
  ('Type 10');

-- Pr_Ty
INSERT INTO Pr_Ty (Barcode, Ty_name)
VALUES
  ('123456789012', 'Type 1'),
  ('234567890123', 'Type 2'),
  ('345678901234', 'Type 3'),
  ('456789012345', 'Type 4'),
  ('567890123456', 'Type 5'),
  ('678901234567', 'Type 6'),
  ('789012345678', 'Type 7'),
  ('890123456789', 'Type 8'),
  ('901234567890', 'Type 9'),
  ('012345678901', 'Type 10'),
  ('123456789210', 'Type 1'),
  ('234567890321', 'Type 2');

-- Distributor
INSERT INTO Distributor (Di_username, Di_email, Di_address_street, Di_address_city, Di_address_province, Start_work, End_work)
VALUES
  ('Distributor 1', 'distributor1@example.com', 'Street 1', 'City 1', 'Province 1', '09:00:00', '18:00:00'),
  ('Distributor 2', 'distributor2@example.com', 'Street 2', 'City 2', 'Province 2', '08:00:00', '17:00:00'),
  ('Distributor 3', 'distributor3@example.com', 'Street 3', 'City 3', 'Province 3', '10:00:00', '19:00:00'),
  ('Distributor 4', 'distributor4@example.com', 'Street 4', 'City 4', 'Province 4', '08:30:00', '17:30:00');

-- Customer
INSERT INTO Customer (Cu_Firstname, Cu_Lastname, National_number, Cu_address_street, Cu_address_city, Cu_address_province, Phone_number)
VALUES
  ('John', 'Doe', '123456789012', 'Street 1', 'City 1', 'Province 1', '1234567890'),
  ('Jane', 'Smith', '234567890123', 'Street 2', 'City 2', 'Province 2', '9876543210'),
  ('Michael', 'Johnson', '345678901234', 'Street 3', 'City 3', 'Province 3', '5555555555'),
  ('Emily', 'Williams', '456789012345', 'Street 4', 'City 4', 'Province 4', '1111111111'),
  ('David', 'Brown', '567890123456', 'Street 5', 'City 5', 'Province 5', '9999999999');

-- Pr_Di
INSERT INTO Pr_Di (Barcode, Di_ID, Price, Quantity)
VALUES
  -- Distributor 1 - Products 1, 2, 3
  ('123456789012', 1, 10.99, 50),
  ('234567890123', 1, 8.99, 30),
  ('345678901234', 1, 5.99, 20),
  
  -- Distributor 2 - Products 4, 5, 6
  ('456789012345', 2, 12.99, 40),
  ('567890123456', 2, 9.99, 25),
  ('678901234567', 2, 7.99, 35),
  
  -- Distributor 3 - Products 7, 8, 9
  ('789012345678', 3, 11.99, 55),
  ('890123456789', 3, 6.99, 15),
  ('901234567890', 3, 4.99, 10),
  
  -- Distributor 4 - Products 10, 11, 12
  ('012345678901', 4, 14.99, 60),
  ('123456789210', 4, 7.99, 40),
  ('234567890321', 4, 5.99, 30);

-- Orders
INSERT INTO Orders (Or_Date, Cu_ID)
VALUES
  ('2023-06-01', 1),
  ('2023-06-02', 2),
  ('2023-06-03', 3);

-- Cu-Order
INSERT INTO Cu_Order (Order_ID, Distributor_ID, Barcode, Price, Quantity)
VALUES
  -- Order 1 - Customer 1
  (1, 1, '123456789012', 10.99, 5),
  (1, 2, '234567890123', 8.99, 3),
  (1, 3, '345678901234', 5.99, 2),
  
  -- Order 2 - Customer 2
  (2, 2, '456789012345', 12.99, 4),
  (2, 3, '567890123456', 9.99, 2),
  (2, 4, '678901234567', 7.99, 3),
  
  -- Order 3 - Customer 3
  (3, 3, '789012345678', 11.99, 6),
  (3, 4, '890123456789', 6.99, 1),
  (3, 1, '901234567890', 4.99, 3);
