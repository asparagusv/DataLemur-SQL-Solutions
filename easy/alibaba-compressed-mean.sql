-- https://datalemur.com/questions/alibaba-compressed-mean
-- Goal: find the mean number of items per order on Alibaba
-- Approach: I checked the answer because I wasn't aware how to calculate item_count * order_occurrences row by row

SELECT round(sum(item_count::DECIMAL*order_occurrences) / sum(order_occurrences), 1) AS mean FROM items_per_order
