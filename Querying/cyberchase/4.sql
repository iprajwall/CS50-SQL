SELECT title
FROM episodes
WHERE topic IS NULL OR topic = '';
