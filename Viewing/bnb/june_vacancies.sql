CREATE VIEW june_vacancies AS
SELECT
    l.id,
    l.property_type,
    l.host_name,
    count(a.date) AS days_vacant
FROM
    listings AS l
INNER JOIN
    availabilities AS a
    ON l.id = a.listing_id
WHERE
    cast(strftime('%Y', a.date) AS INT) = 2023 AND
    cast(strftime('%m', a.date) AS INT) = 6 AND
    a.available = 'TRUE'
GROUP BY
    l.id,
    l.property_type,
    l.host_name;
