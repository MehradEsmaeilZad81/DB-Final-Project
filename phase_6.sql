-- View Number 1
CREATE VIEW distributor_distributes AS
SELECT D.Di_ID, D.Di_username, D.Di_email, D.Di_address_street, D.Di_address_city, D.Di_address_province, D.Start_work, D.End_work, PR.Pr_name, PD.Price, PD.Quantity
FROM Distributor D
INNER JOIN Pr_Di PD ON D.Di_ID = PD.Di_ID
INNER JOIN Product PR ON PD.Barcode = PR.Barcode;

SELECT *
FROM distributor_distributes;

-- View Number 2
CREATE VIEW customer_orders AS
SELECT C.Cu_ID, C.Cu_Firstname, C.Cu_Lastname, C.National_number, C.Cu_address_street, C.Cu_address_city, C.Cu_address_province, C.Phone_number, O.Or_ID, O.Or_Date, PR.Pr_name, CO.Price, CO.Quantity
FROM Customer C
INNER JOIN Orders O ON C.Cu_ID = O.Cu_ID
INNER JOIN Cu_Order CO ON O.Or_ID = CO.Order_ID
INNER JOIN Product PR ON CO.Barcode = PR.Barcode;

SELECT *
FROM customer_orders;

-- View Number 3
CREATE VIEW product_type_brand_company AS
SELECT P.Barcode, P.Pr_name, P.Br_Name, B.Launch_date, B.Business_license, T.Ty_name, C.Co_name, C.Establishment_date, C.Co_address_street, C.Co_address_city, C.Co_address_province
FROM Product P
INNER JOIN Brand B ON P.Br_Name = B.Br_Name
INNER JOIN Pr_Ty PT ON P.Barcode = PT.Barcode
INNER JOIN Type T ON PT.Ty_name = T.Ty_name
INNER JOIN Company C ON B.Business_license = C.Business_license;

SELECT *
FROM product_type_brand_company;