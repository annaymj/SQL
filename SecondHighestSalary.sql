Write a SQL query to get the second highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.

+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+


# Write your MySQL query statement below
/*
Edge Case 1: if there is no 2nd highest salary
Edge Case 2: if there are only 2 same highest value
*/

/* Method 1
select
ifnull(
    (select distinct Salary
    from Employee
    order by Salary desc
    limit 1,1)
, null) as SecondHighestSalary
*/

-- Method 2
select
ifnull(
    (select Salary from Employee
    where Salary not in (select max(Salary) from Employee)
    order by Salary desc
    limit 1)
,null) as SecondHighestSalary






