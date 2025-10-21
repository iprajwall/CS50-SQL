-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- Basic SELECT
SELECT * FROM platforms;

-- JOIN Example
-- Show top 10 movies with their platform and genre names
SELECT
    c.title,
    c.avg_user_rating,
    g.name AS genre,
    p.name AS platform
FROM content c
JOIN genres g ON c.genre_id = g.id
JOIN platforms p ON c.platform_id = p.id
WHERE c.content_type = 'Movie'
ORDER BY c.avg_user_rating DESC
LIMIT 10;

-- Aggregate Function + GROUP BY
-- Count how many titles are available per platform
SELECT
    p.name AS platform,
    COUNT(a.content_id) AS total_titles
FROM availability a
JOIN platforms p ON a.platform_id = p.id
GROUP BY p.name
ORDER BY total_titles DESC;

-- Subquery Example
-- Find content above average rating across all titles
SELECT
    title, rating, avg_user_rating
FROM content
WHERE avg_user_rating > (SELECT AVG(avg_user_rating) FROM content)
ORDER BY avg_user_rating DESC;

-- Multi-table JOIN
-- List users with the platforms they’re subscribed to
SELECT
    u.name AS user_name,
    p.name AS platform_name,
    s.start_date,
    s.is_active
FROM subscriptions s
JOIN users u ON s.user_id = u.id
JOIN platforms p ON s.platform_id = p.id
ORDER BY u.name;

-- Aggregates + HAVING
-- Show average rating per genre (only genres with > 5 titles)
SELECT
    g.name AS genre,
    ROUND(AVG(c.avg_user_rating), 1) AS avg_rating,
    COUNT(c.id) AS total_titles
FROM content c
JOIN genres g ON c.genre_id = g.id
GROUP BY g.name
HAVING COUNT(c.id) > 5
ORDER BY avg_rating DESC;


-- Subquery + JOIN
-- Find the highest-rated title on each platform
SELECT
    c.title,
    c.avg_user_rating,
    p.name AS platform
FROM content c
JOIN platforms p ON c.platform_id = p.id
JOIN (
    SELECT platform_id, MAX(avg_user_rating) AS max_rating
    FROM content
    GROUP BY platform_id
) m ON c.platform_id = m.platform_id AND c.avg_user_rating = m.max_rating;


-- Trigger Test
-- Insert a new rating and verify content rating auto-updates
INSERT INTO user_watch_history (user_id, content_id, watch_time, rating_given)
VALUES (2, 101, 90, 3.4);

SELECT id, title, rating, avg_user_rating FROM content WHERE id = 101;


-- View Query
-- Select from the created view (top-rated movies)
SELECT * FROM top_rated_movies;

-- Active subscriptions
SELECT * FROM active_subscriptions;

-- User subscription count
SELECT * FROM user_subscription_count;

-- Platform subscribers
SELECT * FROM platform_subscribers;

-- User watch summary
SELECT * FROM user_watch_summary;

-- Realistic Analytical Query
-- Find top 3 users who have watched the most content
SELECT
    u.name AS user_name,
    COUNT(uw.content_id) AS total_watched
FROM user_watch_history uw
JOIN users u ON uw.user_id = u.id
GROUP BY u.name
ORDER BY total_watched DESC
LIMIT 3;

-- Average watch time per user
SELECT
    u.name AS user_name,
    ROUND(AVG(uw.watch_time),1) AS avg_watch_time
FROM user_watch_history uw
JOIN users u ON uw.user_id = u.id
GROUP BY u.id
ORDER BY avg_watch_time DESC;

-- Total revenue per platform assuming all active subscriptions pay full fee
SELECT
    p.name AS platform_name,
    COUNT(s.id) * p.subscription_fee AS total_revenue
FROM subscriptions s
JOIN platforms p ON s.platform_id = p.id
WHERE s.is_active = 1
GROUP BY p.id
ORDER BY total_revenue DESC;

-- Users who rated content above 4.5
SELECT
    u.name AS user_name,
    c.title AS content_title,
    uw.rating_given
FROM user_watch_history uw
JOIN users u ON uw.user_id = u.id
JOIN content c ON uw.content_id = c.id
WHERE uw.rating_given > 4.5
ORDER BY uw.rating_given DESC;
