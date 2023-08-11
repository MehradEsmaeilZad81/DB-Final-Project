-- Top 10 product of each Distributor
DECLARE @DistributorID INT;
DECLARE @SQL NVARCHAR(MAX);
DECLARE distributor_cursor CURSOR FOR
SELECT DISTINCT Distributor_ID
FROM Cu_Order;
OPEN distributor_cursor;
FETCH NEXT FROM distributor_cursor INTO @DistributorID;
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = N'
    SELECT TOP 10 P.Barcode, P.Pr_name, SUM(CO.Quantity) AS TotalQuantity, D.Di_username AS DistributorName
    FROM Product P
    INNER JOIN Cu_Order CO ON P.Barcode = CO.Barcode
    INNER JOIN Orders O ON CO.Order_ID = O.Or_ID
    INNER JOIN Distributor D ON CO.Distributor_ID = D.Di_ID
    WHERE CO.Distributor_ID = ' + CAST(@DistributorID AS NVARCHAR(10)) + '
    GROUP BY P.Barcode, P.Pr_name, D.Di_username
    ORDER BY TotalQuantity DESC;
    ';
    EXEC sp_executesql @SQL;
    FETCH NEXT FROM distributor_cursor INTO @DistributorID;
END;
CLOSE distributor_cursor;
DEALLOCATE distributor_cursor;

-- Top 10 product of each City
DECLARE @City VARCHAR(50);
DECLARE @SQL NVARCHAR(MAX);
DECLARE city_cursor CURSOR FOR
SELECT DISTINCT Di_address_city
FROM Distributor;
OPEN city_cursor;
FETCH NEXT FROM city_cursor INTO @City;
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = N'
    SELECT TOP 10 P.Barcode, P.Pr_name, SUM(CO.Quantity) AS TotalQuantity, D.Di_address_city AS City
    FROM Product P
    INNER JOIN Cu_Order CO ON P.Barcode = CO.Barcode
    INNER JOIN Distributor D ON CO.Distributor_ID = D.Di_ID
    WHERE D.Di_address_city = ''' + @City + '''
    GROUP BY P.Barcode, P.Pr_name, D.Di_address_city
    ORDER BY TotalQuantity DESC;
    ';
    EXEC sp_executesql @SQL;
    FETCH NEXT FROM city_cursor INTO @City;
END;
CLOSE city_cursor;
DEALLOCATE city_cursor;

-- TOP SELLERS IN 2023
SELECT TOP 5 D.Di_ID, D.Di_username, SUM(CO.Quantity) AS TotalQuantity
FROM Distributor D
INNER JOIN Cu_Order CO ON D.Di_ID = CO.Distributor_ID
INNER JOIN Orders O ON O.Or_ID = CO.Order_ID
WHERE YEAR(O.Or_Date) = YEAR(GETDATE())
GROUP BY D.Di_ID, D.Di_username
ORDER BY TotalQuantity DESC;

-- One Product more than that other product
SELECT COUNT(*) AS DistributorCount
FROM (
    SELECT CO.Distributor_ID
    FROM Cu_Order CO
	INNER JOIN Product PR ON PR.Barcode = CO.Barcode
    WHERE PR.Pr_name = 'Product 1' AND CO.Quantity > ISNULL(
        (SELECT SUM(CO2.Quantity)
        FROM Cu_Order CO2
		INNER JOIN Product PR ON PR.Barcode = CO2.Barcode
        WHERE CO2.Distributor_ID = CO.Distributor_ID AND PR.Pr_name = 'Product 2'
        GROUP BY CO2.Distributor_ID), 0)
    GROUP BY CO.Distributor_ID
) AS Subquery;


