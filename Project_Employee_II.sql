/*
Table: Project

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.
Table: Employee

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table.
 

Write an SQL query that reports all the projects that have the most employees.

The query result format is in the following example:

Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+

Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+

Result table:
+-------------+
| project_id  |
+-------------+
| 1           |
+-------------+
The first project has 3 employees while the second one has 2.
*/

# Write your MySQL query statement below

/* method 1*/
select p1.project_id from
(
    select project_id, count(employee_id) as cnt
    from Project 
    group by project_id
 )p1
join 
(
    select project_id, count(distinct employee_id) as max_cnt
    from Project
    group by project_id
    order by count(employee_id) desc
    limit 1
)p2
on  p1.cnt = p2.max_cnt

/* method 2*/
select project_id
from Project 
group by project_id
having count(employee_id) = (select count(distinct employee_id)
                             from Project 
                             group by project_id
                             order by count(distinct employee_id) desc
                             limit 1)
  
 

