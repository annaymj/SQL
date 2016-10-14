/*
Homework 8
Name: Mengjie Yu
UTEID: my3852, UTCS username:annayu12
CS f347, Summer 2013, Dr. P. Cannata
Department of Computer Science, The University of Texas at Austin
*/
--Problem8-1
SET SERVEROUTPUT ON;
BEGIN
  UPDATE invoices
  SET vendor_id=(SELECT vendor_id FROM vendors where vendor_name='Federal Express Corporation')
  WHERE vendor_id=(SELECT vendor_id FROM vendors where vendor_name='United Parcel Service');
--  
  UPDATE vendors
  SET vendor_name='FedUP'
  WHERE vendor_name='Federal Express Corporation'; 
--  
  DELETE FROM vendors
  WHERE vendor_name='United Parcel Service';
--
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('The transaction was committed.');
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('The transaction was rolled back.');
END;
/
--Problem8-2
SET SERVEROUTPUT ON;
BEGIN
  DELETE FROM invoice_line_items
  WHERE invoice_id=114;
--
  DELETE FROM invoices
  WHERE invoice_id=114;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('The delete was committed.');
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('The delete was rolled back.');
END;
/
  