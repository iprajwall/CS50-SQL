SELECT d.name,
       e.per_pupil_expenditure,
       AVG(g.graduated) AS avg_grad_rate
FROM districts d
JOIN expenditures e
    ON d.id = e.district_id
JOIN schools s
    ON d.id = s.district_id
JOIN graduation_rates g
    ON s.id = g.school_id
GROUP BY d.name, e.per_pupil_expenditure
ORDER BY avg_grad_rate DESC
LIMIT 10;
