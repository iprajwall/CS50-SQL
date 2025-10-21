SELECT english_title, brightness AS Darkness_Level
FROM views
WHERE artist = 'Hiroshige'
ORDER BY brightness ASC
LIMIT 5;
