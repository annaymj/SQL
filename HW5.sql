/*
Homework 5
Name: Mengjie Yu
UTEID: my3852, UTCS username:annayu12
CS f347, Summer 2013, Dr. P. Cannata
Department of Computer Science, The University of Texas at Austin
*/
--Problem1
CREATE OR REPLACE PROCEDURE insert_glaccount
(
  new_num general_ledger_accounts.account_number%TYPE,
  new_des general_ledger_accounts.account_description%TYPE
)
AS
BEGIN
  INSERT INTO general_ledger_accounts
  VALUES(new_num,new_des);
END;
/
CALL insert_glaccount(710,'Software Inventory Advanced');
--Problem 2
SET SERVEROUTPUT ON;
BEGIN
  insert_glaccount(
    new_num=>130,
    new_des=>'Software Inventory Advanced');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('A DUP_VAL_ON_INDEX error occurred.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unknown exception occurred.');
END;
/
--Problem 3
CREATE OR REPLACE FUNCTION test_glaccounts_description
(
    test_des general_ledger_accounts.account_description%TYPE
)
RETURN NUMBER
AS
    exist_des NUMBER;
BEGIN
    SELECT 1
    INTO  exist_des
    FROM general_ledger_accounts
    WHERE account_description = test_des;
    RETURN exist_des;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        SELECT 0
        INTO  exist_des
        FROM general_ledger_accounts;
        RETURN exist_des;
END;
/
--Problem 4
BEGIN
  IF test_glaccounts_description('Book Inventory') = 1 THEN
    DBMS_OUTPUT.PUT_LINE('Account description is already in use');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Account description is available.');
  END IF;
END;
/
--Problem 5
CREATE OR REPLACE PROCEDURE insert_glaccount_with_test
(
  new_num general_ledger_accounts.account_number%TYPE,
  new_des general_ledger_accounts.account_description%TYPE
)
AS
BEGIN
  IF test_glaccounts_description(new_des)=1 THEN
    RAISE_APPLICATION_ERROR(-20002,'Duplicate account description');
  ELSE
    INSERT INTO general_ledger_accounts VALUES(new_num,new_des);
  END IF;
END;
/
