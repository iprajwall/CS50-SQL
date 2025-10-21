SELECT COUNT(*) AS eastern_capital_count
FROM views
WHERE artist = 'Hiroshige'
AND english_title LIKE '%Eastern Capital%';
