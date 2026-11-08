TRUNCATE tournaments, draws, players, registrations RESTART IDENTITY CASCADE;

INSERT INTO tournaments (name, location) VALUES ('Frisco Fall Open', 'Frisco');
INSERT INTO draws (tournament_id, level, format) VALUES (1, '3.5', 'doubles');
INSERT INTO players (first_name, last_name, email, level, birth_date, gender)
VALUES ('Test', 'Player', 'test@example.com', 3.5, '1990-01-01', 'male');

INSERT INTO registrations (player_id, draw_id) VALUES (1, 1);
