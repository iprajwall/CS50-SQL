SELECT u.username
FROM messages AS m
JOIN users AS u
  ON m.to_user_id = u.id
GROUP BY m.to_user_id
ORDER BY COUNT(m.id) DESC
LIMIT 1;
