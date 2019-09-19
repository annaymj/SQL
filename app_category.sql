/* 
Table 1: app_store
date
app_id
user_id
ui(web, device)
action(dow‍‍‍‌‍‍‍‍‍‍‍‌‌‍‌‍‍‍nload, view)

Table 2: app_developer
app_id
category
price
developer_name
developer_location


*/

-- Q1:Find the number of unique users that have downloaded an app on the web store over the past 7 days
select count(distinct user_id)
from app_store
where date between curdate() and date_sub(curdate(),interval 7 day);

-- Q2:Using the two tables, can you find the number of downloads per category?

select d.category, count(*) as "number of downloads"
from app_store s join app_developer d 
on s.app_id = d.app_id
where s.action = "download"
group by d.category



