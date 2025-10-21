SELECT s.salary
FROM salaries AS s
JOIN performances AS pf
  ON s.player_id = pf.player_id
WHERE s.year = 2001
  AND pf.year = 2001
  AND pf.HR = (
    SELECT MAX(HR)
    FROM performances
    WHERE year = 2001
  );
