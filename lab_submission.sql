-- (i) A Procedure called PROC_LAB5
DELIMITER //

CREATE PROCEDURE PROC_LAB5()
BEGIN
    SELECT 
        c.customerNumber,
        c.customerName,
        o.orderNumber,
        o.orderDate,
        o.status AS orderStatus,
        SUM(od.quantityOrdered * od.priceEach) AS totalOrderAmount,
        IFNULL(SUM(p.amount), 0) AS totalPaid,
        IF(SUM(od.quantityOrdered * od.priceEach) = IFNULL(SUM(p.amount), 0), 'Paid', 'Outstanding') AS paymentStatus
    FROM 
        customers c
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    LEFT JOIN payments p ON c.customerNumber = p.customerNumber
    GROUP BY c.customerNumber, o.orderNumber;
END //

DELIMITER ;

-- (ii) A Function called FUNC_LAB5
DELIMITER //

CREATE FUNCTION FUNC_LAB5(empNumber INT) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE totalRevenue DECIMAL(10, 2);
    
    SELECT 
        SUM(od.quantityOrdered * od.priceEach) INTO totalRevenue
    FROM 
        orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    JOIN customers c ON o.customerNumber = c.customerNumber
    WHERE 
        c.salesRepEmployeeNumber = empNumber;
    
    RETURN IFNULL(totalRevenue, 0);
END //

DELIMITER ;


-- (iii) A View called VIEW_LAB5
CREATE VIEW VIEW_LAB5 AS
SELECT 
    c.customerName,
    c.country AS customerCountry,
    o.orderNumber,
    o.orderDate,
    p.productName,
    od.quantityOrdered,
    od.priceEach,
    (od.quantityOrdered * od.priceEach) AS lineTotal
FROM 
    customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode;

