SELECT
    t.name,
    SUM(pf.H) AS "total hits"
FROM teams AS t
JOIN performances AS pf
  ON t.id = pf.team_id
WHERE pf.year = 2001
GROUP BY t.name
ORDER BY "total hits" DESC
LIMIT 5;
