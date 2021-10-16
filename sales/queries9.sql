SELECT * FROM sales
ORDER BY continent, country, city;

SELECT continent, SUM(units_sold)
FROM sales
GROUP BY continent;

SELECT country, SUM(units_sold)
FROM sales
GROUP BY country;

SELECT city, SUM(units_sold)
FROM sales
GROUP BY city;

-- GROUPING SETS
SELECT continent, country, city,
		SUM(units_sold)
FROM sales
GROUP BY GROUPING SETS(continent, country, city, () );

-- ROLL UP groups by combining the specified columns
-- removing the column for grouping from right to left
-- continent, country, city
-- continent, country
-- continent
SELECT 	continent, country, city,
		SUM(units_sold)
FROM sales
GROUP BY ROLLUP(continent, country, city);
 
-- CUBE All 
-- Creates all the different combinations of grouping columns
SELECT 	continent, country, city,
		SUM(units_sold)
FROM sales
GROUP BY CUBE(continent, country, city);