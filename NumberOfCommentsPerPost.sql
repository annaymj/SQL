# Write your MySQL query statement below

select t1.sub_id as post_id, 
ifnull(t2.number_of_comments,0) as number_of_comments
from (select distinct sub_id from Submissions where parent_id is null)t1
left join
(
    select s1.parent_id as post_id, 
    count(*) as number_of_comments
    from 
    (select distinct s.* from Submissions s where parent_id is not null)s1
    group by s1.parent_id
)t2
on t1.sub_id = t2.post_id
order by t1.sub_id asc