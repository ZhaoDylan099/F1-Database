use F1Database;

INSERT INTO Team(name, fullname, country, engine)
VALUES
('Mercedes', 'Mercedes', 'United Kingdom', 'Mercedes'),
('Red Bull Racing', 'Red Bull Racing Honda RBPT', 'United Kingdom', 'Honda RBPT'),
('Aston Martin', 'Aston Martin Aramco Mercedes', 'United Kingdom', 'Mercedes'),
('Ferrari', 'Ferrari', 'Italy', 'Ferrari'),
('McLaren', 'McLaren Mercedes', 'United Kingdom', 'Mercedes'),
('Alpine', 'Alpine Renault', 'United Kingdom', 'Renault'),
('AlphaTauri', 'AlphaTauri Honda RBPT', 'Italy', 'Honda RBPT'),
('Alfa Romeo', 'Alfa Romeo Ferrari', 'Switzerland', 'Ferrari'),
('Haas', 'Haas Ferrari', 'United Kingdom', 'Ferrari'),
('Williams', 'Williams Mercedes', 'United Kingdom', 'Mercedes')


INSERT INTO Driver(tID, fname, lname, dob, nationality, carNum)
VALUES
(1, 'Lewis', 'Hamilton', '1985-01-07', 'British', 44),
(1, 'George', 'Russell', '1998-02-15', 'British', 63),
(2, 'Max', 'Verstappen', '1997-09-30', 'Dutch', 1),
(2, 'Sergio', 'Perez', '1990-01-26', 'Mexican', 11),
(3, 'Fernando', 'Alonso', '1981-07-29', 'Spanish', 14),
(3, 'Lance', 'Stroll', '1998-10-29', 'Canadian', 18),
(4, 'Charles', 'Leclerc', '1997-10-16', 'Monegasque', 16),
(4, 'Carlos', 'Sainz', '1994-09-01', 'Spanish', 55),
(5, 'Lando', 'Norris', '1999-11-13', 'British', 4),
(5, 'Oscar', 'Piastri', '2001-04-06', 'Australian', 81),
(6, 'Esteban', 'Ocon', '1996-09-17', 'French', 31),
(6, 'Pierre', 'Gasly', '1996-02-07', 'French', 10),
(7, 'Nyck', 'de Vries', '1995-02-06', 'Dutch', 21),
(7, 'Yuki', 'Tsunoda', '2000-05-11', 'Japanese', 22),
(8, 'Valtteri', 'Bottas', '1989-08-28', 'Finnish', 77),
(8, 'Zhou', 'Guanyu', '1999-05-30', 'Chinese', 24),
(9, 'Kevin', 'Magnussen', '1992-10-05', 'Danish', 20),
(9, 'Nico', 'Hülkenberg', '1987-08-19', 'German', 27),
(10, 'Alexander', 'Albon', '1996-03-23', 'Thai', 23),
(10, 'Logan', 'Sargeant', '2000-12-31', 'American', 2);




INSERT INTO cChampionship (tID, season, points, position)
VALUES
(2, 2023, 175, 1),  -- Red Bull
(1, 2023, 165, 2),  -- Mercedes
(4, 2023, 90, 3),   -- Ferrari
(3, 2023, 45, 4),   -- Aston Martin
(5, 2023, 30, 5),   -- McLaren
(6, 2023, 0, 6),    -- Alpine
(7, 2023, 0, 7),    -- AlphaTauri
(8, 2023, 0, 8),    -- Alfa Romeo
(9, 2023, 0, 9),    -- Haas
(10, 2023, 0, 10);  -- Williams

INSERT INTO dChampionship (dID, season, points, position)
VALUES
(3, 2023, 25, 1),   -- Max
(1, 2023, 18, 2),    -- Hamilton
(2, 2023, 15, 3),    -- George
(8, 2023, 12, 4),    -- Carlos
(4, 2023, 10, 5),    -- Perez
(5, 2023, 8, 6),    -- Fernando
(7, 2023, 6, 7),    -- Charles
(9, 2023, 4, 8),    -- Lando
(10, 2023, 2, 9),   -- Oscar
(6, 2023, 1, 10),    -- Stroll
(11, 2023, 0, 11),   -- Esteban
(12, 2023, 0, 12),   -- Pierre
(13, 2023, 0, 13),   -- Nyck
(14, 2023, 0, 14),   -- Yuki
(15, 2023, 0, 15),   -- Valtteri
(16, 2023, 0, 16),   -- Zhou
(17, 2023, 0, 17),   -- Kevin
(18, 2023, 0, 18),   -- Nico
(19, 2023, 0, 19),   -- Alexander
(20, 2023, 0, 20);   -- Logan



INSERT INTO Circuit (name, country, city, length) 
VALUES
('Silverstone Circuit', 'United Kingdom', 'Silverstone', 5891),
('Autodromo Nazionale Monza', 'Italy', 'Monza', 5793),
('Circuit de Spa-Francorchamps', 'Belgium', 'Stavelot', 7004),
('Circuit de Monaco', 'Monaco', 'Monte Carlo', 3337),
('Suzuka International Racing Circuit', 'Japan', 'Suzuka', 5807);

INSERT INTO Race (cID, season, round, date) 
VALUES
(1, 2023, 1, '2023-04-06'), 
(2, 2023, 2, '2023-04-20'), 
(3, 2023, 3, '2023-05-04'),
(4, 2023, 4, '2023-05-25'),
(5, 2023, 5, '2023-11-02');

INSERT INTO DriverRace (dID, rID)
SELECT d.dID, r.rID
FROM Driver   AS d
CROSS JOIN Race AS r;

INSERT INTO LapTime (rID, dID, lap, time)
VALUES
(1, 1, 1, 87092), (1, 1, 2, 87092), (1, 1, 3, 87092), (1, 1, 4, 87092), (1, 1, 5, 87092),
(1, 2, 1, 87087), (1, 2, 2, 87087), (1, 2, 3, 87087), (1, 2, 4, 87087), (1, 2, 5, 87087),
(1, 3, 1, 87097), (1, 3, 2, 87097), (1, 3, 3, 87097), (1, 3, 4, 87097), (1, 3, 5, 87097),
(1, 4, 1, 87077), (1, 4, 2, 87077), (1, 4, 3, 87077), (1, 4, 4, 87077), (1, 4, 5, 87077),
(1, 5, 1, 87072), (1, 5, 2, 87072), (1, 5, 3, 87072), (1, 5, 4, 87072), (1, 5, 5, 87072),
(1, 6, 1, 87052), (1, 6, 2, 87052), (1, 6, 3, 87052), (1, 6, 4, 87052), (1, 6, 5, 87052),
(1, 7, 1, 87067), (1, 7, 2, 87067), (1, 7, 3, 87067), (1, 7, 4, 87067), (1, 7, 5, 87067),
(1, 8, 1, 87082), (1, 8, 2, 87082), (1, 8, 3, 87082), (1, 8, 4, 87082), (1, 8, 5, 87082),
(1, 9, 1, 87062), (1, 9, 2, 87062), (1, 9, 3, 87062), (1, 9, 4, 87062), (1, 9, 5, 87062),
(1, 10, 1, 87057), (1, 10, 2, 87057), (1, 10, 3, 87057), (1, 10, 4, 87057), (1, 10, 5, 87057),
(1, 11, 1, 87047), (1, 11, 2, 87047), (1, 11, 3, 87047), (1, 11, 4, 87047), (1, 11, 5, 87047),
(1, 12, 1, 87042), (1, 12, 2, 87042), (1, 12, 3, 87042), (1, 12, 4, 87042), (1, 12, 5, 87042),
(1, 13, 1, 87037), (1, 13, 2, 87037), (1, 13, 3, 87037), (1, 13, 4, 87037), (1, 13, 5, 87037),
(1, 14, 1, 87032), (1, 14, 2, 87032), (1, 14, 3, 87032), (1, 14, 4, 87032), (1, 14, 5, 87032),
(1, 15, 1, 87027), (1, 15, 2, 87027), (1, 15, 3, 87027), (1, 15, 4, 87027), (1, 15, 5, 87027),
(1, 16, 1, 87022), (1, 16, 2, 87022), (1, 16, 3, 87022), (1, 16, 4, 87022), (1, 16, 5, 87022),
(1, 17, 1, 87017), (1, 17, 2, 87017), (1, 17, 3, 87017), (1, 17, 4, 87017), (1, 17, 5, 87017),
(1, 18, 1, 87012), (1, 18, 2, 87012), (1, 18, 3, 87012), (1, 18, 4, 87012), (1, 18, 5, 87012),
(1, 19, 1, 87007), (1, 19, 2, 87007), (1, 19, 3, 87007), (1, 19, 4, 87007), (1, 19, 5, 87007),
(1, 20, 1, 87002), (1, 20, 2, 87002), (1, 20, 3, 87002), (1, 20, 4, 87002), (1, 20, 5, 87002);

INSERT INTO Result (rID, dID, points, position, status, time)
VALUES
(1, 3, 25, 1, 'finished', 435485),
(1, 1, 18, 2, 'finished', 435460),
(1, 2, 15, 3, 'finished', 435435),
(1, 8, 12, 4, 'finished', 435410),
(1, 4, 10, 5, 'finished', 435385),
(1, 5, 8, 6, 'finished', 435360),
(1, 7, 6, 7, 'finished', 435335),
(1, 9, 4, 8, 'finished', 435310),
(1, 10, 2, 9, 'finished', 435285),
(1, 6, 1, 10, 'finished', 435260),
(1, 11, 0, 11, 'finished', 435235),
(1, 12, 0, 12, 'finished', 435210),
(1, 13, 0, 13, 'finished', 435185),
(1, 14, 0, 14, 'finished', 435160),
(1, 15, 0, 15, 'finished', 435135),
(1, 16, 0, 16, 'finished', 435110),
(1, 17, 0, 17, 'finished', 435085),
(1, 18, 0, 18, 'finished', 435060),
(1, 19, 0, 19, 'finished', 435035),
(1, 20, 0, 20, 'finished', 435010);