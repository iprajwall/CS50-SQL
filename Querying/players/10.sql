SELECT first_name, last_name, weight AS "Player Weight"
FROM players
WHERE birth_state = 'CA'
ORDER BY weight DESC, first_name
LIMIT 20;
