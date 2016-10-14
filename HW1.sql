/*
Homework 1
Name: Mengjie Yu
UTEID: my3852, UTCS username:annayu12
CS f347, Summer 2013, Dr. P. Cannata
Department of Computer Science, The University of Texas at Austin
*/
--Problem 5
SELECT vendor_name, vendor_contact_last_name,vendor_contact_first_name
FROM vendors
ORDER BY  vendor_contact_last_name||vendor_contact_first_name;

--Problem 6
SELECT vendor_contact_last_name ||','||vendor_contact_first_name AS full_name
FROM vendors
--ORDER BY vendor_contact_last_name||vendor_contact_first_name
WHERE  SUBSTR(vendor_contact_last_name,1,1) IN ('A','B','C','E')
ORDER BY vendor_contact_last_name||vendor_contact_first_name;

--Problem 7
SELECT invoice_due_date AS "Due Date",
invoice_total AS "Invoice Total",
invoice_total*0.1 AS "10%",
invoice_total*1.1 AS "Plus 10%"
FROM invoices
WHERE invoice_total BETWEEN 500 AND 1000
ORDER BY invoice_due_date DESC;

--Problem 8
SELECT invoice_number AS "Number",
invoice_total AS "Total",
(payment_total+credit_total) AS "Credits",
(invoice_total-payment_total-credit_total) AS "Balance Due"
FROM (SELECT * FROM invoices
ORDER BY (invoice_total-payment_total-credit_total) DESC)
WHERE (invoice_total-payment_total-credit_total) >=500 and ROWNUM<=10;


--Problem 9
SELECT (invoice_total-payment_total-credit_total) AS "Balance Due",
payment_date AS "Payment Date"
FROM invoices
WHERE payment_date is NULL AND (invoice_total-payment_total-credit_total)=0;


--Problem 10
SELECT  51000 AS "Starting Principal",
51000*1.1 AS "New Principal",
51000*1.1*0.065 AS "Interest",
51000+51000*1.1*0.065 AS "Principal+Interest",
To_Char(SYSDATE,'dd-mon-yyyy hh24-mi-ss') AS "System Date"
FROM Dual;
