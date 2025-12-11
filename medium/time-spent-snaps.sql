-- https://datalemur.com/questions/time-spent-snaps
-- Goal: obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group
-- Approach: Group by age_bucket then sum the time spent for each activity while using case when to separate activity type

WITH a AS (
  SELECT 
    ab.age_bucket,
    SUM(CASE WHEN a.activity_type = 'open' THEN a.time_spent ELSE 0 END) AS open_time,
    SUM(CASE WHEN a.activity_type = 'send' THEN a.time_spent ELSE 0 END) AS send_time
  FROM activities a
  LEFT JOIN age_breakdown ab 
    ON a.user_id = ab.user_id
  GROUP BY ab.age_bucket
)
SELECT 
  age_bucket,
  ROUND(send_time * 1.0 / (send_time + open_time)*100.0, 2) AS send_perc,
  ROUND(open_time * 1.0 / (send_time + open_time)*100.0, 2) AS open_perc
FROM a
ORDER BY age_bucket;