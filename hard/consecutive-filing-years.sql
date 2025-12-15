-- https://datalemur.com/questions/consecutive-filing-years
-- Goal: identify the user IDs of individuals who have filed their taxes using any version of TurboTax for three or more consecutive years
-- Approach: when we want to find consecutive entries, we rank the entries and then subtract the rank from the entry
-- If entries are consecutive, the subtraction will be the same for each entry

WITH ranked AS (
SELECT 
  user_id,
  filing_date,
  ROW_NUMBER() OVER (
    PARTITION BY user_id
    ORDER BY filing_date ASC
  ) AS ra
FROM filed_taxes
where product LIKE '%TurboTax%'
),
grouped AS (
SELECT
  user_id,
  extract(year from filing_date) - ra AS consecutive
from ranked
)

SELECT DISTINCT user_id
from grouped
group by user_id, consecutive
having count(user_id) >= 3
