SELECT * FROM world_conflicts
order by deaths DESC
LIMIT 10;


--TOP 10 YEARS BY TOTAL CONFLICT DEATHS
SELECT 
    year,
    SUM(deaths) AS total_deaths
FROM world_conflicts
GROUP BY year
ORDER BY total_deaths DESC
LIMIT 10;

--TOP 10 COUNTRIES BY TOTAL CONFLICT DEATHS
SELECT 
    country,
    SUM(deaths) AS total_deaths
FROM world_conflicts
GROUP BY country
ORDER BY total_deaths DESC
LIMIT 10;


--COUNTRIES WITH CONTINUOUS CONFLICTS
WITH conflict_flags AS (
    SELECT 
        country,
        year,
        CASE WHEN deaths > 0 THEN 1 ELSE 0 END AS has_conflict
    FROM world_conflicts
),
grouped AS (
    SELECT 
        country,
        year,
        SUM(has_conflict) OVER (PARTITION BY country ORDER BY year 
                                ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS conflict_streak
    FROM conflict_flags
)
SELECT country, COUNT(*) AS years_in_conflict
FROM grouped
WHERE conflict_streak > 0
GROUP BY country
ORDER BY years_in_conflict DESC

--DEADLIEST DECADES
SELECT 
    (year / 10) * 10 AS decade,
    SUM(deaths) AS total_deaths
FROM world_conflicts
GROUP BY decade
ORDER BY total_deaths DESC;

-- Top 10 most peaceful countries (least deaths, ignoring 0)
SELECT 
    country,
    SUM(deaths) AS total_deaths
FROM world_conflicts
GROUP BY country
HAVING SUM(deaths) > 0
ORDER BY total_deaths ASC
LIMIT 10;
