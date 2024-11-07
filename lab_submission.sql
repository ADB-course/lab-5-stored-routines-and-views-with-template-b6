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


-- (iii) A View called VIEW_LAB5
