/*
Table: Failed

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| fail_date    | date    |
+--------------+---------+
Primary key for this table is fail_date.
Failed table contains the days of failed tasks.
Table: Succeeded

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| success_date | date    |
+--------------+---------+
Primary key for this table is success_date.
Succeeded table contains the days of succeeded tasks.
 

A system is running one task every day. Every task is independent of the previous tasks. The tasks can fail or succeed.

Write an SQL query to generate a report of period_state for each continuous interval of days in the period from 2019-01-01 to 2019-12-31.

period_state is 'failed' if tasks in this interval failed or 'succeeded' if tasks in this interval succeeded. Interval of days are retrieved as start_date and end_date.

Order result by start_date.

The query result format is in the following example:

Failed table:
+-------------------+
| fail_date         |
+-------------------+
| 2018-12-28        |
| 2018-12-29        |
| 2019-01-04        |
| 2019-01-05        |
+-------------------+

Succeeded table:
+-------------------+
| success_date      |
+-------------------+
| 2018-12-30        |
| 2018-12-31        |
| 2019-01-01        |
| 2019-01-02        |
| 2019-01-03        |
| 2019-01-06        |
+-------------------+


Result table:
+--------------+--------------+--------------+
| period_state | start_date   | end_date     |
+--------------+--------------+--------------+
| succeeded    | 2019-01-01   | 2019-01-03   |
| failed       | 2019-01-04   | 2019-01-05   |
| succeeded    | 2019-01-06   | 2019-01-06   |
+--------------+--------------+--------------+

The report ignored the system state in 2018 as we care about the system in the period 2019-01-01 to 2019-12-31.
From 2019-01-01 to 2019-01-03 all tasks succeeded and the system state was "succeeded".
From 2019-01-04 to 2019-01-05 all tasks failed and system state was "failed".
From 2019-01-06 to 2019-01-06 all tasks succeeded and system state was "succeeded".
*/

-- Method 1
/* Write your T-SQL query statement below */

with combined_tb as
    (
        select fail_date as status_date, 'failed' as status
        from Failed
        where year(fail_date) = 2019
        union 
        select success_date as status_date, 'succeeded' as status
        from Succeeded
        where year(success_date) = 2019
    ),
prev_status as
(
    select tb1.*, tb2.status as prev_status, tb2.status_date as prev_date
    from
    (
        select status_date, status, row_number() over (order by status_date) as ord
        from combined_tb
    )tb1
    left join
    (
        select status_date, status, row_number() over (order by status_date) as ord
        from combined_tb
    )tb2
    on tb1.ord = tb2.ord + 1
),
next_status as
(
    select tb1.*, tb2.status as next_status, tb2.status_date as next_date
    from
    (
        select status_date, status, row_number() over (order by status_date) as ord
        from combined_tb
    )tb1
    left join
    (
        select status_date, status, row_number() over (order by status_date) as ord
        from combined_tb
    )tb2
    on tb1.ord = tb2.ord - 1
)


select p.period_state, p.start_date, n.end_date
from
(
    select status as period_state,  status_date as start_date,
    row_number() over(order by status_date) as ord
    from prev_status
    where status != prev_status or prev_status is null
 )p
 join 
 (
    select status as period_state,  status_date as end_date, 
    row_number() over(order by status_date) as ord
    from next_status
    where status != next_status or next_status is null
 )n
 on p.ord = n.ord