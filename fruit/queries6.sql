SELECT name, 
(CASE WHEN SUM(SUPPLY)<20000 THEN 'LOW' ELSE NULL END) as LOW,
(CASE WHEN SUM(SUPPLY)>20000 and SUM(SUPPLY)<50000 THEN 'ENOUGH' ELSE NULL END) as MID,
(CASE WHEN SUM(SUPPLY)>50000 THEN 'FULL' ELSE NULL END) as HIGH
FROM fruit_imports
GROUP BY name;

SELECT season, SUM(supply*cost_per_unit) as Total_Cost
FROM fruit_imports
GROUP BY season;


SELECT 
CASE WHEN season = 'Winter' THEN  total_cost END as Winter_Cost,
CASE WHEN season = 'Summer' THEN  total_cost END as Summer_Cost,
CASE WHEN season = 'Spring' THEN  total_cost END as Spring_total
CASE WHEN season = 'Fall' THEN  total_cost END as Fall_total
FROM (
	SELECT season, SUM(supply * cost_per_unit) AS total_cost
	FROM fruit_imports
	GROUP BY season
) A


