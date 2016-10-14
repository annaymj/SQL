CREATE OR REPLACE TRIGGER invoices_after_update
AFTER UPDATE OF payment_total
ON cp_invoices
FOR EACH ROW 
WHEN (new.payment_total > old.payment_total)
DECLARE
  vendor_name_var VARCHAR2(50);
BEGIN
  SELECT vendor_name
  INTO vendor_name_var
  FROM vendors
  WHERE vendor_id = :old.vendor_id;
  
  DBMS_OUTPUT.PUT_LINE('vendor_name:    ' || vendor_name_var);
  DBMS_OUTPUT.PUT_LINE('invoice_number: ' || :new.invoice_number);
  DBMS_OUTPUT.PUT_LINE('payment_total:  ' || :new.payment_total);
END;
/
SET SERVEROUTPUT ON;
UPDATE cp_invoices
SET payment_total = 100
WHERE invoice_id = 112;