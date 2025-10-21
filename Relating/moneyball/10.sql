SELECT p.first_name,
       p.last_name,
       s.salary,
       pf.HR,
       s.year
FROM players AS p
JOIN salaries AS s
  ON p.id = s.player_id
JOIN performances AS pf
  ON p.id = pf.player_id
  AND s.year = pf.year
ORDER BY p.id ASC,
         s.year DESC,
         pf.HR DESC,
         s.salary DESC;
