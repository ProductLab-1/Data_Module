CREATE TABLE famous_people (
    person_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    profession TEXT NOT NULL
);

CREATE TABLE movies (
    movie_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    release_year INTEGER
);

CREATE TABLE movie_star_relationship (
    movie_id INTEGER,
    person_id INTEGER,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (person_id) REFERENCES famous_people(person_id),
    PRIMARY KEY (movie_id, person_id)
);

CREATE TABLE marriages (
    person1_id INTEGER,
    person2_id INTEGER,
    marriage_date INTEGER,
    FOREIGN KEY (person1_id) REFERENCES famous_people(person_id),
    FOREIGN KEY (person2_id) REFERENCES famous_people(person_id),
    PRIMARY KEY (person1_id, person2_id)
);

-- Inserting famous people
INSERT INTO famous_people (name, profession) VALUES ('Leonardo DiCaprio', 'Movie Star');
INSERT INTO famous_people (name, profession) VALUES ('Kate Winslet', 'Movie Star');

-- Inserting movies
INSERT INTO movies (title, release_year) VALUES ('Titanic', 1997);

-- Inserting relationship of movie stars and movies
INSERT INTO movie_star_relationship (movie_id, person_id) VALUES (1, 1);  -- Leonardo DiCaprio in Titanic
INSERT INTO movie_star_relationship (movie_id, person_id) VALUES (1, 2);  -- Kate Winslet in Titanic

-- Inserting marriage (for example purposes, as they are not really married)
INSERT INTO marriages (person1_id, person2_id, marriage_date) VALUES (1, 2, '2000-01-01');

-- Inserting more famous people
INSERT INTO famous_people (name, profession) VALUES ('Brad Pitt', 'Movie Star');
INSERT INTO famous_people (name, profession) VALUES ('Angelina Jolie', 'Movie Star');
INSERT INTO famous_people (name, profession) VALUES ('Keanu Reeves', 'Movie Star');
INSERT INTO famous_people (name, profession) VALUES ('Sandra Bullock', 'Movie Star');

-- Inserting more movies
INSERT INTO movies (title, release_year) VALUES ('Fight Club', 1999);
INSERT INTO movies (title, release_year) VALUES ('Mr. & Mrs. Smith', 2005);
INSERT INTO movies (title, release_year) VALUES ('The Matrix', 1999);
INSERT INTO movies (title, release_year) VALUES ('Speed', 1994);

-- Inserting relationship of movie stars and new movies
INSERT INTO movie_star_relationship (movie_id, person_id) VALUES (2, 3);  -- Brad Pitt in Fight Club
INSERT INTO movie_star_relationship (movie_id, person_id) VALUES (3, 3);  -- Brad Pitt in Mr. & Mrs. Smith
INSERT INTO movie_star_relationship (movie_id, person_id) VALUES (3, 4);  -- Angelina Jolie in Mr. & Mrs. Smith
INSERT INTO movie_star_relationship (movie_id, person_id) VALUES (4, 5);  -- Keanu Reeves in The Matrix
INSERT INTO movie_star_relationship (movie_id, person_id) VALUES (5, 5);  -- Keanu Reeves in Speed
INSERT INTO movie_star_relationship (movie_id, person_id) VALUES (5, 6);  -- Sandra Bullock in Speed

-- Inserting marriage (for example purposes)
INSERT INTO marriages (person1_id, person2_id, marriage_date) VALUES (3, 4, '2005-01-01');  -- Brad Pitt and Angelina Jolie


-- some queries

-- List all famous people and the number of movies they've acted in
SELECT 
    fp.name,
    COUNT(msr.movie_id) AS number_of_movies
FROM famous_people fp
LEFT JOIN movie_star_relationship msr ON fp.person_id = msr.person_id
GROUP BY fp.name;

-- list of all movies and their cast
SELECT 
    m.title,
    GROUP_CONCAT(fp.name) AS cast
FROM movies m
JOIN movie_star_relationship msr ON m.movie_id = msr.movie_id
JOIN famous_people fp ON msr.person_id = fp.person_id
GROUP BY m.title;

-- all movie stars who have worked together in more than one movie
SELECT 
    fp1.name AS star_1,
    fp2.name AS star_2,
    COUNT(DISTINCT msr1.movie_id) AS number_of_movies_together
FROM movie_star_relationship msr1
JOIN movie_star_relationship msr2 ON msr1.movie_id = msr2.movie_id AND msr1.person_id < msr2.person_id
JOIN famous_people fp1 ON msr1.person_id = fp1.person_id
JOIN famous_people fp2 ON msr2.person_id = fp2.person_id
GROUP BY star_1, star_2
HAVING number_of_movies_together > 1;

-- all unmarried movie stars
SELECT 
    fp.name
FROM famous_people fp
WHERE fp.person_id NOT IN (SELECT person1_id FROM marriages) 
AND fp.person_id NOT IN (SELECT person2_id FROM marriages);

-- movies released in 1999
SELECT 
    title
FROM movies
WHERE release_year = 1999;

-- Find the marriage date of a specific couple, say Brad Pitt and Angelina Jolie:
SELECT 
    marriage_date
FROM marriages
WHERE 
    (person1_id = (SELECT person_id FROM famous_people WHERE name = 'Brad Pitt') AND
     person2_id = (SELECT person_id FROM famous_people WHERE name = 'Angelina Jolie'))
OR
    (person2_id = (SELECT person_id FROM famous_people WHERE name = 'Brad Pitt') AND
     person1_id = (SELECT person_id FROM famous_people WHERE name = 'Angelina Jolie'));

-- List all movies not starring Leonardo DiCaprio:
SELECT 
    m.title
FROM movies m
WHERE m.movie_id NOT IN (SELECT movie_id FROM movie_star_relationship WHERE person_id = (SELECT person_id FROM famous_people WHERE name = 'Leonardo DiCaprio'));

