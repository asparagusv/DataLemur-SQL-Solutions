-- https://datalemur.com/questions/repeated-payments
-- Goal: identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other
-- Approach: use LAG() while partitioning by merchant_id, credit_card_id, and amount to get the difference in minutes between the last transaction and the next transaction

WITH difference AS (
SELECT
  merchant_id,
  credit_card_id,
  amount,
  transaction_timestamp,
  extract(epoch from (transaction_timestamp - LAG(transaction_timestamp) OVER (
    PARTITION BY merchant_id, credit_card_id, amount
    ORDER BY transaction_timestamp ASC
  ))) / 60 AS diff
FROM transactions
)

select count(*) as payment_count from difference
where diff <= 10 