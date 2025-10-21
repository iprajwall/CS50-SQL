CREATE TABLE users (
    id INTEGER,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE schools_university (
    id INTEGER,
    name TEXT NOT NULL,
    type TEXT NOT NULL CHECK(type IN ('Elementary School', 'Middle School',
    'High School', 'Lower School', 'Upper School', 'College', 'Univeristy')),
    location TEXT NOT NULL,
    date_founded INTEGER,
    PRIMARY KEY (id)
);

CREATE TABLE companies (
    id INTEGER,
    name TEXT NOT NULL,
    industry TEXT NOT NULL,
    location TEXT,
    PRIMARY KEY (id)
);

CREATE TABLE connections (
    id INTEGER,
    user_id INTEGER UNIQUE,
    user_connect_id INTEGER UNIQUE,
    school_id INTEGER,
    degree TEXT,
    type_degree TEXT,
    company_id INTEGER,
    title TEXT,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES user(id)
    FOREIGN KEY (user_connect_id) REFERENCES users(id)
    FOREIGN KEY (school_id) REFERENCES school_university(id)
    FOREIGN KEY (company_id) REFERENCES companies(id)
);
