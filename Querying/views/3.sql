SELECT COUNT(*) AS fuji_count
FROM views
WHERE artist = 'Hokusai'
AND english_title LIKE '%Fuji%';
