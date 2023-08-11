-- Number 1
CREATE TRIGGER prd_CheckBarcode
ON Product
AFTER INSERT
AS
BEGIN
IF EXISTS (
	SELECT P1.Barcode, P1.Pr_name, P2.Pr_name
	FROM Product P1
	JOIN Product P2 ON P1.Barcode = P2.Barcode
	WHERE P1.Pr_name <> P2.Pr_name
	)
	BEGIN 
		RAISERROR ('The requested insert is not available because of same barcode exists!', 16, 1);
		ROLLBACK;
	END
END;

-- Number 2
CREATE TRIGGER trg_CheckDuplicateOrder
ON Cu_Order
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT Barcode
        FROM inserted
        GROUP BY Barcode
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR ('Duplicate orders for the same product are not allowed!', 16, 1);
        ROLLBACK;
    END
END;
