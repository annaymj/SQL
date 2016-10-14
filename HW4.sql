/*
Homework 4
Name: Mengjie Yu
UTEID: my3852, UTCS username:annayu12
CS f347, Summer 2013, Dr. P. Cannata
Department of Computer Science, The University of Texas at Austin
*/
--Problem1
SET SERVEROUTPUT ON;
DECLARE
count_invoice_id NUMBER;
BEGIN
SELECT COUNT(invoice_id) 
INTO count_invoice_id
FROM invoices
WHERE (invoice_total-payment_total-credit_total>=5000);
DBMS_OUTPUT.PUT_LINE(count_invoice_id||' invoices exceed $5,000.');
END;
/
--problem 2
SET SERVEROUTPUT ON;
DECLARE
num_balance NUMBER;
sum_balance invoices.invoice_total%TYPE;
BEGIN
SELECT COUNT(invoice_id),SUM(invoice_total-payment_total-credit_total)
INTO num_balance,sum_balance
FROM invoices
WHERE (invoice_total-payment_total-credit_total)<>0;
DBMS_OUTPUT.PUT_LINE('Number of unpaid invoices is '||num_balance||'.');
IF sum_balance>=5000 THEN
DBMS_OUTPUT.PUT_LINE('Total balance due is '||TO_CHAR(sum_balance,'$99,999.99')||'.');
ELSE
DBMS_OUTPUT.PUT_LINE('Total balance due is less than $50,000.');
END IF;
END;
/
--Problem 3
SET SERVEROUTPUT ON;
DECLARE
CURSOR invoices_cursor IS
  SELECT vendor_name,invoice_number, invoice_total-payment_total-credit_total AS balance_due 
  FROM invoices NATURAL JOIN vendors
  WHERE (invoice_total-payment_total-credit_total)>=5000
  ORDER BY balance_due DESC;
BEGIN
FOR vendor_row IN invoices_cursor LOOP
DBMS_OUTPUT.PUT_LINE(RPAD(TO_CHAR(vendor_row.balance_due,'$99,999.99'),15)||RPAD(vendor_row.invoice_number,15)||RPAD(vendor_row.vendor_name,30));
END LOOP;
END;
/
--Problem 4
SET SERVEROUTPUT ON;
DECLARE
CURSOR invoices_cursor IS
  SELECT vendor_name,invoice_number, invoice_total-payment_total-credit_total AS balance_due 
  FROM invoices NATURAL JOIN vendors
  WHERE (invoice_total-payment_total-credit_total)>=5000
  ORDER BY balance_due DESC;
BEGIN
FOR vendor_row IN invoices_cursor LOOP
  IF (vendor_row.balance_due>=5000 AND vendor_row.balance_due<10000) THEN
  DBMS_OUTPUT.PUT_LINE(RPAD(TO_CHAR(vendor_row.balance_due,'$99,999.99'),15)||RPAD(vendor_row.invoice_number,15)||RPAD(vendor_row.vendor_name,30));
  DBMS_OUTPUT.PUT_LINE(' ');
  
  ELSIF (vendor_row.balance_due>=10000 AND vendor_row.balance_due<20000) THEN
  DBMS_OUTPUT.PUT_LINE(RPAD('$10,000 to $20,000',30)||RPAD(TO_CHAR(vendor_row.balance_due,'$99,999.99'),15)||RPAD(vendor_row.invoice_number,15)||RPAD(vendor_row.vendor_name,30));

  ELSIF (vendor_row.balance_due>=20000) THEN
  DBMS_OUTPUT.PUT_LINE(RPAD('$20,000 or More',30)||RPAD(TO_CHAR(vendor_row.balance_due,'$99,999.99'),15)||RPAD(vendor_row.invoice_number,15)||RPAD(vendor_row.vendor_name,30));
  DBMS_OUTPUT.PUT_LINE(' ');
  ELSE
  DBMS_OUTPUT.PUT_LINE(RPAD(TO_CHAR(vendor_row.balance_due,'$99,999.99'),15)||RPAD(vendor_row.invoice_number,15)||RPAD(vendor_row.vendor_name,30));  
  DBMS_OUTPUT.PUT_LINE(' ');
  END IF;
END LOOP;
END;
/
--Problem 5
SET SERVEROUTPUT ON;
VARIABLE balance_due NUMBER;
BEGIN
:balance_due :=&invoice_amount;
END;
/
DECLARE
CURSOR invoices_cursor IS
  SELECT vendor_name,invoice_number, invoice_total-payment_total-credit_total AS balance_due 
  FROM invoices NATURAL JOIN vendors
  WHERE (invoice_total-payment_total-credit_total)>=5000
  ORDER BY balance_due DESC;
BEGIN
DBMS_OUTPUT.PUT_LINE('Invoice amounts greater than or equal to $'||:balance_due);
DBMS_OUTPUT.PUT_LINE('========================================================');
FOR vendor_row IN invoices_cursor LOOP
IF vendor_row.balance_due >=:balance_due THEN
DBMS_OUTPUT.PUT_LINE(RPAD(TO_CHAR(vendor_row.balance_due,'$99,999.99'),15)||RPAD(vendor_row.invoice_number,15)||RPAD(vendor_row.vendor_name,30));
END IF;
END LOOP;
END;
/