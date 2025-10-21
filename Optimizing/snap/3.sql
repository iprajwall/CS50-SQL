SELECT m.to_user_id
FROM messages AS m
JOIN users AS u
    ON m.from_user_id = u.id
WHERE u.username = 'creativewisdom377'
GROUP BY m.to_user_id
ORDER BY COUNT(m.id) DESC
LIMIT 3;
