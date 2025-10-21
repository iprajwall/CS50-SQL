SELECT t.name,
       ROUND(AVG(s.salary), 2) AS "average salary"
FROM teams AS t
JOIN performances AS pf
  ON t.id = pf.team_id
JOIN salaries AS s
  ON pf.player_id = s.player_id
  AND pf.year = s.year
WHERE s.year = 2001
GROUP BY t.name
ORDER BY "average salary" ASC
LIMIT 5;
