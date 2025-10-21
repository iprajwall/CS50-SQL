SELECT d.name
FROM districts d
JOIN expenditures e
    ON d.id = e.district_id
ORDER BY e.pupils
LIMIT 1;
