CREATE TABLE world_conflicts
(
    country VARCHAR(255),
    country_abr VARCHAR(4),
    year INT,
    deaths INT
);

ALTER TABLE world_conflicts
ALTER COLUMN country_abr TYPE VARCHAR(10);

COPY world_conflicts(country, country_abr, year, deaths)
FROM 'D:\Data Analytics\Projects\Conflict\countries-in-conflict-data-clean.csv'
DELIMITER ','
CSV HEADER;

select * from world_conflicts limit 10;