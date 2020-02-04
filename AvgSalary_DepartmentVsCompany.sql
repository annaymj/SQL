Given two tables as below, write a query to display the comparison result (higher/lower/same) of the average salary of employees 
in a department to the company's average salary.
 

Table: salary
| id | employee_id | amount | pay_date   |
|----|-------------|--------|------------|
| 1  | 1           | 9000   | 2017-03-31 |
| 2  | 2           | 6000   | 2017-03-31 |
| 3  | 3           | 10000  | 2017-03-31 |
| 4  | 1           | 7000   | 2017-02-28 |
| 5  | 2           | 6000   | 2017-02-28 |
| 6  | 3           | 8000   | 2017-02-28 |
 

The employee_id column refers to the employee_id in the following table employee.
 
| employee_id | department_id |
|-------------|---------------|
| 1           | 1             |
| 2           | 2             |
| 3           | 2             |
 

So for the sample data above, the result is:
| pay_month | department_id | comparison  |
|-----------|---------------|-------------|
| 2017-03   | 1             | higher      |
| 2017-03   | 2             | lower       |
| 2017-02   | 1             | same        |
| 2017-02   | 2             | same        |

select tb1.pay_month, tb1.department_id,
case when tb1.department_avg > tb2.company_avg then "higher"
     when tb1.department_avg = tb2.company_avg then "same"
else "lower" end as comparison
from
(
select e.department_id, left(pay_date,7) as pay_month
,avg(amount) as department_avg
from salary s join employee e
on s.employee_id = e.employee_id
group by e.department_id, left(pay_date,7)
)tb1
left join
(
select left(pay_date,7) as pay_month, avg(amount) as company_avg
from salary 
group by left(pay_date,7)
 )tb2
 on tb1.pay_month = tb2.pay_month
 order by tb1.pay_month desc, tb1.department_id
 