SELECT  *  FROM fruit_imports;

SELECT state, SUM(supply) as supply_state
FROM fruit_imports
GROUP BY state
ORDER BY supply_state DESC
LIMIT 1;

SELECT season, MAX(cost_per_unit)
FROM fruit_imports
GROUP BY season;

SELECT state, name, COUNT(*)
FROM fruit_imports
GROUP BY state, name
HAVING COUNT(*)>1;

SELECT season, COUNT(*)
FROM fruit_imports
GROUP BY season
HAVING COUNT(*)=3 OR COUNT(*)=4;

SELECT state,  SUM(supply*cost_per_unit) AS total_cost
from fruit_imports
GROUP BY state
ORDER BY total_cost DESC
LIMIT 1;