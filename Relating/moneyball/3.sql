SELECT year, HR as home_runs
FROM performances
WHERE player_id = (
	SELECT id
	FROM players
	WHERE first_name = 'Ken' and
	last_name = 'Griffey' and
	birth_year = 1969
)

ORDER BY year DESC;
