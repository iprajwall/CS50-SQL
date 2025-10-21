WITH per_hit AS (
    SELECT p.id
    FROM players AS p
    JOIN salaries AS s
      ON p.id = s.player_id
    JOIN performances AS pf
      ON p.id = pf.player_id
      AND s.year = pf.year
    WHERE s.year = 2001
      AND pf.year = 2001
      AND pf.H > 0
    ORDER BY (s.salary * 1.0 / pf.H) ASC
    LIMIT 10
),
per_rbi AS (
    SELECT p.id
    FROM players AS p
    JOIN salaries AS s
      ON p.id = s.player_id
    JOIN performances AS pf
      ON p.id = pf.player_id
      AND s.year = pf.year
    WHERE s.year = 2001
      AND pf.year = 2001
      AND pf.RBI > 0
    ORDER BY (s.salary * 1.0 / pf.RBI) ASC
    LIMIT 10
)
SELECT p.first_name,
       p.last_name
FROM players AS p
WHERE p.id IN (SELECT id FROM per_hit)
  AND p.id IN (SELECT id FROM per_rbi)
ORDER BY p.id ASC;
