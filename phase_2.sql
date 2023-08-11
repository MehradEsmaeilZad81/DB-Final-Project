-- Create the Company table
CREATE TABLE Company (
  Business_license NVARCHAR(18) PRIMARY KEY,
  Co_name VARCHAR(50),
  Establishment_date DATE,
  Co_address_street VARCHAR(50),
  Co_address_city VARCHAR(50),
  Co_address_province VARCHAR(50)
);

-- Create the Brand table
CREATE TABLE Brand (
  Br_Name VARCHAR(50) PRIMARY KEY,
  Launch_date DATE NOT NULL,
  Business_license NVARCHAR(18),
  FOREIGN KEY (Business_license) REFERENCES Company(Business_license)
);

-- Create the Type table
CREATE TABLE Type (
  Ty_name VARCHAR(50) PRIMARY KEY
);

-- Create the Product table
CREATE TABLE Product (
  Barcode NVARCHAR(12) PRIMARY KEY,
  Pr_name VARCHAR(50),
  Br_Name VARCHAR(50),
  FOREIGN KEY (Br_Name) REFERENCES Brand(Br_Name)
);

ALTER TABLE Product
ADD Weight DECIMAL(10, 2);


-- Create the Pr_Ty table
CREATE TABLE Pr_Ty (
  Barcode NVARCHAR(12),
  Ty_name VARCHAR(50),
  PRIMARY KEY (Barcode, Ty_name),
  FOREIGN KEY (Barcode) REFERENCES Product(Barcode),
  FOREIGN KEY (Ty_name) REFERENCES Type(Ty_name)
);

-- Create the Distributor table
CREATE TABLE Distributor (
  Di_ID INT IDENTITY(1,1) PRIMARY KEY,
  Di_username VARCHAR(50),
  Di_email VARCHAR(50),
  Di_address_street VARCHAR(50),
  Di_address_city VARCHAR(50),
  Di_address_province VARCHAR(50),
  Start_work TIME,
  End_work TIME
);

-- Create the Customer table
CREATE TABLE Customer (
  Cu_ID INT IDENTITY(1,1) PRIMARY KEY,
  Cu_Firstname VARCHAR(50),
  Cu_Lastname VARCHAR(50),
  National_number VARCHAR(12),
  Cu_address_street VARCHAR(50),
  Cu_address_city VARCHAR(50),
  Cu_address_province VARCHAR(50),
  Phone_number VARCHAR(12)
);

-- Create the Orders table
CREATE TABLE Orders (
  Or_ID INT IDENTITY(1,1) PRIMARY KEY,
  Or_Date DATE NOT NULL,
  Cu_ID INT,
  FOREIGN KEY (Cu_ID) REFERENCES Customer(Cu_ID)
);

-- Create the Pr_Di table
CREATE TABLE Pr_Di (
  Barcode NVARCHAR(12),
  Di_ID INT,
  Price DECIMAL(10,2) NOT NULL,
  Quantity INT NOT NULL,
  PRIMARY KEY (Barcode, Di_ID),
  FOREIGN KEY (Barcode) REFERENCES Product(Barcode),
  FOREIGN KEY (Di_ID) REFERENCES Distributor(Di_ID)
);

-- Create the Cu_Order table
CREATE TABLE Cu_Order (
  Order_ID INT,
  Distributor_ID INT,
  Barcode NVARCHAR(12),
  Price DECIMAL(10,2) NOT NULL,
  Quantity INT NOT NULL,
  PRIMARY KEY (Order_id, Distributor_ID, Barcode),
  FOREIGN KEY (Order_ID) REFERENCES Orders(Or_ID),
  FOREIGN KEY (Distributor_ID) REFERENCES Distributor(Di_ID),
  FOREIGN KEY (Barcode) REFERENCES Product(Barcode)
);

CREATE TRIGGER trg_CheckQuantity
ON Cu_Order
AFTER INSERT
AS
BEGIN
    -- Check the requested quantity against the available quantity in the distributor's inventory
    IF EXISTS (
        SELECT CO.Barcode, CO.Quantity
        FROM inserted CO
        INNER JOIN Pr_Di PD ON CO.Barcode = PD.Barcode
        WHERE CO.Distributor_ID = PD.Di_ID
        AND CO.Quantity > PD.Quantity
    )
    BEGIN
        -- Raise an error if the requested quantity is not available
        RAISERROR ('The requested quantity is not available in the distributor''s inventory.', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        -- Reduce the quantity in the distributor's inventory
        UPDATE Pr_Di
        SET Quantity = Pr_Di.Quantity - CO.Quantity
        FROM inserted CO
        WHERE Pr_Di.Barcode = CO.Barcode
        AND Pr_Di.Di_ID = CO.Distributor_ID;
    END
END;
