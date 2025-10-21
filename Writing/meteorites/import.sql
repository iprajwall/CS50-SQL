-- Create a temporary table for raw CSV import
CREATE TABLE meteorites_temp (
    name TEXT,
    id TEXT,
    nametype TEXT,
    class TEXT,
    mass REAL,
    fall TEXT,
    year TEXT,
    lat REAL,
    long REAL
);

-- Import CSV into temporary table
.import --csv meteorites.csv meteorites_temp

-- Clean the data

-- a) Remove rows where nametype = 'Relict'
DELETE FROM meteorites_temp
WHERE LOWER(TRIM(nametype)) = 'relict';

-- b) Standardize discovery/fall column
UPDATE meteorites_temp
SET fall = CASE
    WHEN LOWER(TRIM(fall)) = 'fell' THEN 'Fell'
    WHEN LOWER(TRIM(fall)) = 'found' THEN 'Found'
    ELSE NULL
END;

-- c) Replace empty strings in numeric columns with NULL
UPDATE meteorites_temp
SET mass = NULL
WHERE mass = '';

UPDATE meteorites_temp
SET year = NULL
WHERE year = '';

UPDATE meteorites_temp
SET lat = NULL
WHERE lat = '';

UPDATE meteorites_temp
SET long = NULL
WHERE long = '';

-- d) Round decimals to nearest hundredth
UPDATE meteorites_temp
SET mass = ROUND(mass, 2)
WHERE mass IS NOT NULL;

UPDATE meteorites_temp
SET lat = ROUND(lat, 2)
WHERE lat IS NOT NULL;

UPDATE meteorites_temp
SET long = ROUND(long, 2)
WHERE long IS NOT NULL;

-- e) Convert year to integer
UPDATE meteorites_temp
SET year = CAST(year AS INTEGER)
WHERE year IS NOT NULL;

-- Create the final cleaned table
CREATE TABLE meteorites (
    id INTEGER PRIMARY KEY,
    name TEXT,
    class TEXT,
    mass REAL,
    discovery TEXT,
    year INTEGER,
    lat REAL,
    long REAL
);

-- Insert cleaned and sorted data into final table
INSERT INTO meteorites (name, class, mass, discovery, year, lat, long)
SELECT name, class, mass, fall, year, lat, long
FROM meteorites_temp
ORDER BY year ASC, name ASC;

-- Drop temporary table
DROP TABLE meteorites_temp;
