-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- 1. Platforms Table
-- Stores information about streaming platforms

CREATE TABLE IF NOT EXISTS platforms (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    region TEXT,
    subscription_fee REAL
);

-- 2. Genres Table
-- Stores unique genres for content classification

CREATE TABLE IF NOT EXISTS genres (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);


-- 3. Content Table (Unified Movies & Shows)
-- Stores all movies and TV shows

CREATE TABLE IF NOT EXISTS content (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    content_type TEXT CHECK (content_type IN ('Movie','Show')),
    release_year INTEGER,
    genre_id INTEGER,
    rating REAL DEFAULT 0,
    duration INTEGER,
    seasons INTEGER,
    episodes INTEGER,
    platform_id INTEGER,
    avg_user_rating REAL,
    FOREIGN KEY (genre_id) REFERENCES genres(id),
    FOREIGN KEY (platform_id) REFERENCES platforms(id)
);

-- 4. Users Table
-- Stores platform users

CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    country TEXT
);

-- 5. Availability Table
-- Links content to platform availability

CREATE TABLE IF NOT EXISTS availability (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content_id INTEGER NOT NULL,
    platform_id INTEGER NOT NULL,
    is_available INTEGER DEFAULT 1 CHECK (is_available IN (0,1)),
    price REAL DEFAULT 0,
    FOREIGN KEY (content_id) REFERENCES content(id),
    FOREIGN KEY (platform_id) REFERENCES platforms(id)
);

-- 6. User Watch History Table
-- Tracks what content users have watched

CREATE TABLE IF NOT EXISTS user_watch_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    content_id INTEGER NOT NULL,
    watch_time INTEGER,
    rating_given REAL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (content_id) REFERENCES content(id)
);

-- 7. Subscriptions Table
-- Tracks which user subscribes to which platform

CREATE TABLE IF NOT EXISTS subscriptions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    platform_id INTEGER NOT NULL,
    start_date DATE DEFAULT CURRENT_DATE,
    end_date DATE,
    is_active INTEGER DEFAULT 1 CHECK (is_active IN (0,1)),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (platform_id) REFERENCES platforms(id)
);

-- Indexes for Performance
CREATE INDEX idx_content_title ON content(title);
CREATE INDEX idx_user_watch ON user_watch_history(user_id, content_id);
CREATE INDEX idx_genre_name ON genres(name);
CREATE INDEX idx_platform_name ON platforms(name);

-- Views for Common Queries
CREATE VIEW top_rated_content AS
SELECT title, content_type, rating, avg_user_rating, platform_id
FROM content
ORDER BY avg_user_rating DESC
LIMIT 20;

CREATE VIEW top_rated_movies AS
SELECT title, rating, avg_user_rating, platform_id
FROM content
WHERE content_type = 'Movie'
ORDER BY avg_user_rating DESC
LIMIT 20;

CREATE VIEW top_rated_shows AS
SELECT title, rating, avg_user_rating, platform_id
FROM content
WHERE content_type = 'Show'
ORDER BY avg_user_rating DESC
LIMIT 20;

CREATE VIEW active_subscribers AS
SELECT u.name, p.name AS platform, s.start_date
FROM subscriptions s
JOIN users u ON s.user_id = u.id
JOIN platforms p ON s.platform_id = p.id
WHERE s.is_active = 1;

CREATE VIEW top_watched_content AS
SELECT
    c.title,
    COUNT(w.id) AS total_views,
    ROUND(AVG(w.rating_given), 2) AS avg_rating
FROM user_watch_history w
JOIN content c ON w.content_id = c.id
GROUP BY c.id
ORDER BY total_views DESC
LIMIT 20;

-- Active Subscriptions
-- Shows all users with their active platform subscriptions
CREATE VIEW active_subscriptions AS
SELECT
    u.name AS user_name,
    u.email,
    p.name AS platform_name,
    s.start_date,
    s.end_date
FROM subscriptions s
JOIN users u ON s.user_id = u.id
JOIN platforms p ON s.platform_id = p.id
WHERE s.is_active = 1;

-- User Subscription Count
-- Counts how many active subscriptions each user has
CREATE VIEW user_subscription_count AS
SELECT
    u.id AS user_id,
    u.name AS user_name,
    COUNT(DISTINCT s.platform_id) AS total_active_subscriptions
FROM users u
LEFT JOIN subscriptions s
    ON u.id = s.user_id AND s.is_active = 1
GROUP BY u.id, u.name
ORDER BY total_active_subscriptions DESC;

-- Platform Subscribers
-- Shows number of active users subscribed to each platform
CREATE VIEW platform_subscribers AS
SELECT
    p.name AS platform_name,
    COUNT(s.id) AS total_active_users
FROM platforms p
LEFT JOIN subscriptions s ON p.id = s.platform_id AND s.is_active = 1
GROUP BY p.name
ORDER BY total_active_users DESC;

-- Users & Watched Content Summary
-- Shows each user, total content watched, and average rating given
CREATE VIEW user_watch_summary AS
SELECT
    u.name AS user_name,
    COUNT(uw.content_id) AS total_watched,
    ROUND(AVG(uw.rating_given),1) AS avg_rating_given
FROM users u
LEFT JOIN user_watch_history uw ON u.id = uw.user_id
GROUP BY u.id, u.name
ORDER BY total_watched DESC;

-- Trigger: Update average content rating
CREATE TRIGGER update_avg_user_rating
AFTER INSERT ON user_watch_history
FOR EACH ROW
BEGIN
    UPDATE content
    SET avg_user_rating = ROUND(
        (SELECT AVG(rating_given)
         FROM user_watch_history
         WHERE content_id = NEW.content_id),
        2
    )
    WHERE id = NEW.content_id;
END;


