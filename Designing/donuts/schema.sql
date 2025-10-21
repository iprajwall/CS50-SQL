CREATE TABLE ingredients (
    id INTEGER,
    flour INTEGER,
    yeast INTEGER,
    oil INTEGER,
    butter INTEGER,
    price INTEGER,
    PRIMARY KEY (id)
);

CREATE TABLE donuts (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    gluten_free INTEGER NOT NULL CHECK (gluten_free IN ('1', '0')),
    sell_price INTEGER NOT NULL,
    ingredients TEXT NOT NULL
);

CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    donuts TEXT,
    customer_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES customers (id)
);

CREATE TABLE customers (
    id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    order_id INTEGER,
    FOREIGN KEY (order_id) REFERENCES orders (id)
);
