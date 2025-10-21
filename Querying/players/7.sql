SELECT COUNT(*) AS mismatch_count
FROM players
WHERE (bats = 'R' AND throws = 'L')
   OR (bats = 'L' AND throws = 'R');
