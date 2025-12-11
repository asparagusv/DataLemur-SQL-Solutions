-- https://datalemur.com/questions/matching-skills
-- Goal: find candidates who are proficient in Python, Tableau, and PostgreSQL
-- Approach: filter out the candidates without any required skills to get the list of candidates with at least one required skill

SELECT candidate_id FROM candidates
where skill in ('Python', 'Tableau', 'PostgreSQL')
group by candidate_id
having count(candidate_id) = 3