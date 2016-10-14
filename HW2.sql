/*
Homework 2
Name: Mengjie Yu
UTEID: my3852, UTCS username:annayu12
CS f347, Summer 2013, Dr. P. Cannata
Department of Computer Science, The University of Texas at Austin
*/
--Problem1
SELECT * 
FROM vendors INNER JOIN invoices
ON vendors.vendor_id=invoices.vendor_id;

--Problem2
SELECT vendor_name,invoice_number,invoice_date,(invoice_total-payment_total-credit_total) AS balance_due
FROM invoices i JOIN vendors v
ON i.vendor_id=v.vendor_id
WHERE (invoice_total-payment_total-credit_total)<> 0
ORDER BY vendor_name;

--Problem4
SELECT vendor_name,invoice_date,invoice_number,invoice_sequence AS li_sequence,line_item_amt AS li_amount
FROM vendors Ven
    JOIN invoices Inv
    ON Ven.vendor_id=Inv.vendor_id
    JOIN invoice_line_items LI
    ON Inv.invoice_id=LI.invoice_id
ORDER BY vendor_name,invoice_date,invoice_number,invoice_sequence;

--Problem6
SELECT g.account_number,account_description
FROM general_ledger_accounts g
FULL JOIN invoice_line_items i
ON g.account_number=i.account_number
WHERE i.line_item_amt is NULL
ORDER BY g.account_number;

--Problem7
SELECT 'CA'AS vendor_state,vendor_name
FROM vendors
WHERE vendor_state ='CA'
UNION
SELECT 'Outside CA' AS vendor_state, vendor_name
FROM vendors
WHERE vendor_state <> 'CA'
ORDER BY vendor_name;

