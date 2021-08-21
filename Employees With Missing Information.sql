```
Table: Employees

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
+-------------+---------+
employee_id is the primary key for this table.
Each row of this table indicates the name of the employee whose ID is employee_id.
 

Table: Salaries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| salary      | int     |
+-------------+---------+
employee_id is the primary key for this table.
Each row of this table indicates the salary of the employee whose ID is employee_id.
```
# Write your MySQL query statement below
SELECT employee_id FROM
(
    SELECT employee_id FROM Employees
    UNION 
    SELECT employee_id FROM Salaries
)t
WHERE employee_id NOT IN 
(SELECT e.employee_id FROM Employees e INNER JOIN Salaries s ON e.employee_id = s.employee_id)
ORDER BY employee_id
