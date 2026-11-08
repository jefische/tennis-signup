-- Up Migration
CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL,
    level NUMERIC(2, 1) CHECK (level BETWEEN 2.0 AND 5.5 AND level % 0.5 = 0),
    birth_date DATE NOT NULL,
    gender TEXT NOT NULL CHECK (gender IN ('male', 'female'))
);

CREATE UNIQUE INDEX players_email_lower_idx ON players (lower(email));
-- Down Migration
DROP TABLE players;