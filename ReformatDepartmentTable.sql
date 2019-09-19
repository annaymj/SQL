/*Table: Department

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| revenue       | int     |
| month         | varchar |
+---------------+---------+
(id, month) is the primary key of this table.
The table has information about the revenue of each department per month.
The month has values in ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].
 

Write an SQL query to reformat the table such that there is a department id column and a revenue column for each month.

The query result format is in the following example:

Department table:
+------+---------+-------+
| id   | revenue | month |
+------+---------+-------+
| 1    | 8000    | Jan   |
| 2    | 9000    | Jan   |
| 3    | 10000   | Feb   |
| 1    | 7000    | Feb   |
| 1    | 6000    | Mar   |
+------+---------+-------+

Result table:
+------+-------------+-------------+-------------+-----+-------------+
| id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
+------+-------------+-------------+-------------+-----+-------------+
| 1    | 8000        | 7000        | 6000        | ... | null        |
| 2    | 9000        | null        | null        | ... | null        |
| 3    | null        | 10000       | null        | ... | null        |
+------+-------------+-------------+-------------+-----+-------------+

Note that the result table has 13 columns (1 for the department id + 12 for the months).
*/

# Write your MySQL query statement below

select t2.id,
sum(Jan_Revenue) as Jan_Revenue,
sum(Feb_Revenue) as Feb_Revenue,
sum(Mar_Revenue) as Mar_Revenue,
sum(Apr_Revenue) as Apr_Revenue,
sum(May_Revenue) as May_Revenue,
sum(Jun_Revenue) as Jun_Revenue,
sum(Jul_Revenue) as Jul_Revenue,
sum(Aug_Revenue) as Aug_Revenue,
sum(Sep_Revenue) as Sep_Revenue,
sum(Oct_Revenue) as Oct_Revenue,
sum(Nov_Revenue) as Nov_Revenue,
sum(Dec_Revenue) as Dec_Revenue
from
(select d.id,
(case when d.month = 'Jan' then d.revenue end) as Jan_Revenue,
(case when d.month = 'Feb' then d.revenue end) as Feb_Revenue,
(case when d.month = 'Mar' then d.revenue end) as Mar_Revenue,
(case when d.month = 'Apr' then d.revenue end) as Apr_Revenue,
(case when d.month = 'May' then d.revenue end) as May_Revenue,
(case when d.month = 'Jun' then d.revenue end) as Jun_Revenue,
(case when d.month = 'Jul' then d.revenue end) as Jul_Revenue,
(case when d.month = 'Aug' then d.revenue end) as Aug_Revenue,
(case when d.month = 'Sep' then d.revenue end) as Sep_Revenue,
(case when d.month = 'Oct' then d.revenue end) as Oct_Revenue,
(case when d.month = 'Nov' then d.revenue end) as Nov_Revenue,
(case when d.month = 'Dec' then d.revenue end) as Dec_Revenue
from Department as d ) t2
group by t2.id




select a.id,
case when d1.revenue is not null then d1.revenue else null end as "Jan_Revenue",
case when d2.revenue is not null then d2.revenue else null end as "Feb_Revenue",
case when d3.revenue is not null then d3.revenue else null end as "Mar_Revenue",
case when d4.revenue is not null then d4.revenue else null end as "Apr_Revenue",
case when d5.revenue is not null then d5.revenue else null end as "May_Revenue",
case when d6.revenue is not null then d6.revenue else null end as "Jun_Revenue",
case when d7.revenue is not null then d7.revenue else null end as "Jul_Revenue",
case when d8.revenue is not null then d8.revenue else null end as "Aug_Revenue",
case when d9.revenue is not null then d9.revenue else null end as "Sep_Revenue",
case when d10.revenue is not null then d10.revenue else null end as "Oct_Revenue",
case when d11.revenue is not null then d11.revenue else null end as "Nov_Revenue",
case when d12.revenue is not null then d12.revenue else null end as "Dec_Revenue"

from
(select distinct id from Department)a 
left join (select * from Department where month = "Jan")d1 on a.id = d1.id
left join (select * from Department where month = "Feb")d2 on a.id = d2.id
left join (select * from Department where month = "Mar")d3 on a.id = d3.id
left join (select * from Department where month = "Apr")d4 on a.id = d4.id
left join (select * from Department where month = "May")d5 on a.id = d5.id
left join (select * from Department where month = "Jun")d6 on a.id = d6.id
left join (select * from Department where month = "Jul")d7 on a.id = d7.id
left join (select * from Department where month = "Aug")d8 on a.id = d8.id
left join (select * from Department where month = "Sep")d9 on a.id = d9.id
left join (select * from Department where month = "Oct")d10 on a.id = d10.id
left join (select * from Department where month = "Nov")d11 on a.id = d11.id
left join (select * from Department where month = "Dec")d12 on a.id = d12.id
