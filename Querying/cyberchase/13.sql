SELECT title, topic
FROM episodes
WHERE season = 3
  AND (topic LIKE '%geometry%' OR topic LIKE '%fraction%');
