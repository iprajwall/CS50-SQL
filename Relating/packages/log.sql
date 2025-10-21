
-- *** The Lost Letter ***

SELECT *
FROM addresses
WHERE id = (
    SELECT address_id
    FROM scans
    WHERE package_id = (
        SELECT id
        FROM packages
        WHERE contents = 'Congratulatory letter'
          AND from_address_id = (
              SELECT id
              FROM addresses
              WHERE address = '900 Somerville Avenue'
          )
    )
    AND action = 'Drop'
);


-- *** The Devious Delivery ***

SELECT * FROM packages
WHERE from_address_id is NULL;

SELECT *
FROM addresses
WHERE id = (
    SELECT from_address_id
    FROM packages
    WHERE from_address_id IS NULL
);

SELECT *
FROM addresses
WHERE id = (
    SELECT to_address_id
    FROM packages
    WHERE from_address_id IS NULL
);

SELECT *
FROM scans
WHERE package_id = (
    SELECT id
    FROM packages
    WHERE from_address_id IS NULL
)
AND action = 'Drop';

SELECT *
FROM addresses
WHERE id = (
    SELECT address_id
    FROM scans
    WHERE package_id = (
        SELECT id
        FROM packages
        WHERE from_address_id IS NULL
    )
    AND action = 'Drop'
);

-- *** The Forgotten Gift ***

SELECT *
FROM packages
WHERE from_address_id = (
    SELECT id
    FROM addresses
    WHERE address = '109 Tileston Street'
)
AND to_address_id = (
    SELECT id
    FROM addresses
    WHERE address = '728 Maple Place'
);

SELECT *
FROM scans
WHERE package_id = (
    SELECT id
    FROM packages
    WHERE from_address_id = (
        SELECT id
        FROM addresses
        WHERE address = '109 Tileston Street'
    )
    AND to_address_id = (
        SELECT id
        FROM addresses
        WHERE address = '728 Maple Place'
    )
);

SELECT *
FROM drivers
WHERE id = (
    SELECT driver_id
    FROM scans
    WHERE package_id = (
        SELECT id
        FROM packages
        WHERE from_address_id = (
            SELECT id
            FROM addresses
            WHERE address = '109 Tileston Street'
        )
        AND to_address_id = (
            SELECT id
            FROM addresses
            WHERE address = '728 Maple Place'
        )
    )
    ORDER BY timestamp DESC
    LIMIT 1
);
