-- https://datalemur.com/questions/sql-histogram-tweets
-- Goal: group the users by the number of tweets they posted in 2022 and count the number of users in each group
-- Approach: First, count the number of posts by each user, then group by the number of posts so that you can count a number of users in each tweet number bracket

with tc AS(
SELECT user_id, count(user_id) as tweet_bucket FROM tweets
where extract(year from tweet_date) = 2022
group by user_id
)

select tweet_bucket, count(user_id) as users_num from tc
group by tweet_bucket
order by tweet_bucket ASC