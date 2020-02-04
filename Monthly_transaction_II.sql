/*
Table: Transactions

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| id             | int     |
| country        | varchar |
| state          | enum    |
| amount         | int     |
| trans_date     | date    |
+----------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
Table: Chargebacks

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| trans_id       | int     |
| charge_date    | date    |
+----------------+---------+
Chargebacks contains basic information regarding incoming chargebacks from some transactions placed in Transactions table.
trans_id is a foreign key to the id column of Transactions table.
Each chargeback corresponds to a transaction made previously even if they were not approved.
 

Write an SQL query to find for each month and country, the number of approved transactions and their total amount, the number of chargebacks and their total amount.

Note: In your query, given the month and country, ignore rows with all zeros.

The query result format is in the following example:

Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 101  | US      | approved | 1000   | 2019-05-18 |
| 102  | US      | declined | 2000   | 2019-05-19 |
| 103  | US      | approved | 3000   | 2019-06-10 |
| 104  | US      | approved | 4000   | 2019-06-13 |
| 105  | US      | approved | 5000   | 2019-06-15 |
+------+---------+----------+--------+------------+

Chargebacks table:
+------------+------------+
| trans_id   | trans_date |
+------------+------------+
| 102        | 2019-05-29 |
| 101        | 2019-06-30 |
| 105        | 2019-09-18 |
+------------+------------+

Result table:
+----------+---------+----------------+-----------------+-------------------+--------------------+
| month    | country | approved_count | approved_amount | chargeback_count  | chargeback_amount  |
+----------+---------+----------------+-----------------+-------------------+--------------------+
| 2019-05  | US      | 1              | 1000            | 1                 | 2000               |
| 2019-06  | US      | 3              | 12000           | 1                 | 1000               |
| 2019-09  | US      | 0              | 0               | 1                 | 5000               |
+----------+---------+----------------+-----------------+-------------------+--------------------+
*/


# Write your MySQL query statement below


select c.month, c.country, c.approved_count, c.approved_amount, c.chargeback_count, c.chargeback_amount
from
(
select ifnull(a2.month,b2.month) as month, 
ifnull(a2.country,b2.country) as country,
ifnull(a2.approved_count,0) as approved_count, 
ifnull(a2.approved_amount,0) as approved_amount,
ifnull(b2.chargeback_count,0) as chargeback_count,
ifnull(b2.chargeback_amount,0) as chargeback_amount
from
(
    select left(trans_date,7) as month, 
    country,
    sum(case when state = "approved" then 1 else 0 end) as approved_count,
    sum(case when state = "approved" then amount else 0 end) as approved_amount
    from Transactions 
    group by month,country
)a2
left join
(
    select left(c.trans_date,7) as month, 
    t.country,
    sum(case when c.trans_date is not null then 1 else 0 end) as chargeback_count,
    sum(case when c.trans_date is not null then t.amount else 0 end) as chargeback_amount
    from Transactions t right join Chargebacks c
    on t.id = c.trans_id
    group by month, country
)b2
on a2.month = b2.month and a2.country = b2.country

union

select ifnull(a1.month,b1.month) as month, 
ifnull(a1.country,b1.country) as country,
ifnull(a1.approved_count,0) as approved_count, 
ifnull(a1.approved_amount,0) as approved_amount,
ifnull(b1.chargeback_count,0) as chargeback_count,
ifnull(b1.chargeback_amount,0) as chargeback_amount
from
(
    select left(trans_date,7) as month, 
    country,
    sum(case when state = "approved" then 1 else 0 end) as approved_count,
    sum(case when state = "approved" then amount else 0 end) as approved_amount
    from Transactions 
    group by month,country
)a1
right join
(
    select left(c.trans_date,7) as month, 
    t.country,
    sum(case when c.trans_date is not null then 1 else 0 end) as chargeback_count,
    sum(case when c.trans_date is not null then t.amount else 0 end) as chargeback_amount
    from Transactions t right join Chargebacks c
    on t.id = c.trans_id
    group by month, country
)b1
on a1.month = b1.month and a1.country = b1.country
)c
where c.approved_count!= 0 or c.chargeback_count!= 0
order by c.month, c.country
