-- SELECT p.first_name, p.last_name
-- FROM players p
-- WHERE id = (
--     SELECT player_id
--     FROM salaries
--     WHERE salary = (
--         SELECT MAX(salary)
--         FROM salaries
--     )
-- );

SELECT players.first_name,
       players.last_name
FROM players
JOIN salaries
  ON players.id = salaries.player_id
WHERE salaries.salary = (
    SELECT MAX(salary)
    FROM salaries
);

