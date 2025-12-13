-- https://datalemur.com/questions/sql-third-transaction
-- Goal: obtain the third transaction of every user
-- Approach: Use ROW_NUMBER() to visually order transaction_date per user_id.
-- Group by user_id cannot be used here because group by aggregates rows into one blob per user_id, meaning we cannot get the row associated with the third transaction.

WITH ranked AS (
SELECT 
  user_id,
  spend,
  transaction_date,
  ROW_NUMBER() OVER (
    PARTITION BY user_id
    ORDER BY transaction_date ASC
  ) AS transaction_rank
  FROM transactions
)

select user_id, spend, transaction_date
from ranked
where transaction_rank = 3