-- Up Migration
CREATE TABLE tournaments (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL, 
    location TEXT,
    start_date DATE,
    end_date DATE,
    CHECK (end_date >= start_date)
);

CREATE TABLE draws (
    id SERIAL PRIMARY KEY,
    tournament_id INTEGER NOT NULL REFERENCES tournaments(id),
    level NUMERIC(2, 1) CHECK (level BETWEEN 2.0 AND 5.5 AND level % 0.5 = 0),
    format TEXT NOT NULL CHECK (format IN ('singles', 'doubles')),
    max_players INTEGER CHECK (max_players > 0),
    min_age INTEGER,
    max_age INTEGER,
    CHECK (min_age <= max_age)
);

CREATE INDEX draws_tournament_id_idx ON draws (tournament_id);
-- Down Migration
DROP TABLE draws;
DROP TABLE tournaments;