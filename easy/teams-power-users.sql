-- https://datalemur.com/questions/teams-power-users
-- Goal: find the top 2 Power Users who sent the most messages on Microsoft Teams in August 2022
-- Approach: LIMIT 2 to get the top 2

SELECT 
  sender_id,
  count(sender_id) as message_count
FROM messages
where extract(year from sent_date) = 2022
and extract(month from sent_date) = 8
group by sender_id
order by message_count DESC
LIMIT 2