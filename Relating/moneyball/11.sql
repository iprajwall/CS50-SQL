SELECT p.first_name,
       p.last_name,
       (s.salary / pf.H) AS "dollars per hit"
FROM players AS p
JOIN salaries AS s
  ON p.id = s.player_id
JOIN performances AS pf
  ON p.id = pf.player_id
  AND s.year = pf.year
WHERE s.year = 2001
  AND pf.year = 2001
  AND pf.H > 0
ORDER BY "dollars per hit" ASC,
         p.first_name ASC,
         p.last_name ASC
LIMIT 10;
