INSERT INTO Customer (Cu_Firstname, Cu_Lastname, National_number, Cu_address_street, Cu_address_city, Cu_address_province, Phone_number)
VALUES ('Harry', 'Kane', '123456781011', '212 Baker Street', 'London', 'London', '+44796268462');

INSERT INTO Orders (Or_Date, Cu_ID)
VALUES (CAST(GETDATE() AS Date), 6);

INSERT INTO Cu_Order (Order_ID, Distributor_ID, Barcode, Price, Quantity)
VALUES
  (4, 1, '123456789012', 10.99, 5),
  (4, 2, '234567890123', 8.99, 3),
  (4, 3, '345678901234', 5.99, 2);

UPDATE Customer
SET Phone_number = '447342780080'
WHERE Cu_Firstname = 'Harry' AND Cu_Lastname = 'Kane';

DELETE FROM Customer
WHERE Cu_ID NOT IN (SELECT Cu_ID FROM Orders);

