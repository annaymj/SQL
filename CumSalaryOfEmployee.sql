 -- The Employee table holds the salary information in a year.

/*
Write a SQL to get the cumulative sum of an employee's salary over a period of 3 months but exclude the most recent month.

The result should be displayed by 'Id' ascending, and then by 'Month' descending.

Example
Input

| Id | Month | Salary |
|----|-------|--------|
| 1  | 1     | 20     |
| 2  | 1     | 20     |
| 1  | 2     | 30     |
| 2  | 2     | 30     |
| 3  | 2     | 40     |
| 1  | 3     | 40     |
| 3  | 3     | 60     |
| 1  | 4     | 60     |
| 3  | 4     | 70     |
Output

| Id | Month | Salary |
|----|-------|--------|
| 1  | 3     | 90     |
| 1  | 2     | 50     |
| 1  | 1     | 20     |
| 2  | 1     | 20     |
| 3  | 3     | 100    |
| 3  | 2     | 40     |
 

Explanation
Employee '1' has 3 salary records for the following 3 months except the most recent month '4': salary 40 for month '3', 30 for month '2' and 20 for month '1'
So the cumulative sum of salary of this employee over 3 months is 90(40+30+20), 50(30+20) and 20 respectively.

| Id | Month | Salary |
|----|-------|--------|
| 1  | 3     | 90     |
| 1  | 2     | 50     |
| 1  | 1     | 20     |
Employee '2' only has one salary record (month '1') except its most recent month '2'.
| Id | Month | Salary |
|----|-------|--------|
| 2  | 1     | 20     |
 

Employee '3' has two salary records except its most recent pay month '4': month '3' with 60 and month '2' with 40. So the cumulative salary is as following.
| Id | Month | Salary |
|----|-------|--------|
| 3  | 3     | 100    |
| 3  | 2     | 40     |
*/

/*
First, I want to find out the lastest month for each employee
Id | last_month
1 | 4 
2 | 2
3 | 4

*/


select tb1.Id, tb1.Month, tb1.Salary + tb1.Salary2 + tb1.Salary3 as Salary
from (
	select e1.Id, e1.Month, e1.Salary,
	ifnull(e2.Salary,0) as Salary2,
	ifnull(e3.Salary,0) as Salary3
	from Employee e1 
	left join Employee e2 on e1.Id = e2.Id and e1.Month - 1 = e2.Month 
	left join Employee e3 on e1.Id = e3.Id and e1.Month - 2 = e3.Month 
)tb1
join 
(
 select Id, max(month) as max_month from Employee group by Id
)tb2
on tb1.Id = tb2.Id and tb1.Month < tb2.max_month
order by tb1.Id asc, tb1.month desc



