SELECT DISTINCT t.name
FROM teams AS t
JOIN performances AS pf
  ON t.id = pf.team_id
JOIN players AS pl
  ON pl.id = pf.player_id
WHERE pl.first_name = 'Satchel'
  AND pl.last_name = 'Paige';
