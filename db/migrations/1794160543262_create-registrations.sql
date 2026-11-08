-- Up Migration
CREATE TABLE registrations(
    id SERIAL PRIMARY KEY,
    player_id INTEGER NOT NULL REFERENCES players(id),
    draw_id INTEGER NOT NULL REFERENCES draws(id),
    partner_id INTEGER REFERENCES players(id),
    status TEXT NOT NULL DEFAULT 'pending' 
        CHECK (status IN ('pending', 'confirmed', 'waitlisted', 'withdrawn')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (player_id, draw_id),
    CHECK (partner_id <> player_id)
);

CREATE INDEX registrations_draw_id_idx on registrations (draw_id);
-- Down Migration
DROP TABLE registrations;