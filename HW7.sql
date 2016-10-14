/*
Homework 7
Name: Mengjie Yu
UTEID: my3852, UTCS username:annayu12
CS f347, Summer 2013, Dr. P. Cannata
Department of Computer Science, The University of Texas at Austin
*/
--Problem5-1
SELECT vendor_id, SUM(invoice_total) AS Invoice_total
FROM invoices
GROUP BY vendor_id
ORDER BY vendor_id;
--Problem5-3
SELECT vendor_name, COUNT(*) AS invoice_number, SUM(invoice_total) AS invoice_total
FROM vendors NATURAL JOIN invoices
GROUP BY vendor_name
ORDER BY invoice_number DESC;
--Problem5-5
SELECT account_description,COUNT(*) AS entry_number, SUM(line_item_amt) AS Invoice_item_amount
FROM general_ledger_accounts g
  JOIN invoice_line_items il
    ON il.account_number = g.account_number
  JOIN invoices i
    ON i.invoice_id=il.invoice_id
WHERE  i.invoice_date BETWEEN '01-APR-2008' AND'30-JUN-2008'
GROUP BY g.account_description
HAVING COUNT(*)>1
ORDER BY Invoice_item_amount DESC;
--Problem6-1
SELECT DISTINCT vendor_name
FROM vendors 
WHERE vendor_id IN
  (SELECT vendor_id FROM invoices)
ORDER BY vendor_name;
--Problem6-3
SELECT account_number,account_description
FROM general_ledger_accounts
WHERE NOT EXISTS
  (SELECT * FROM invoice_line_items
  WHERE general_ledger_accounts.account_number=invoice_line_items.account_number)
ORDER BY account_number;

