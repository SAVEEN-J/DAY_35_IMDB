-- IMDB Design a DB for IMDB 

-- 1. Movie should have multiple media(Video or Image) 
-- 2. Movie can belongs to multiple Genre 
-- 3. Movie can have multiple reviews and Review can belongs to a user 
-- 4. Artist can have multiple skills 
-- 5. Artist can perform multiple role in a single film


show databases;

--createdb
create database imdb; 

--select db
use imdb;
-- select database() 
show databases;

-- creating table for movie
CREATE TABLE movie (
    movie_id INT NOT NULL AUTO_INCREMENT,
    movie_title VARCHAR(255) NOT NULL,
    movie_year INT NOT NULL,
    PRIMARY KEY (movie_id)
);
-- movie data
INSERT INTO movie (movie_id,movie_title,movie_year) VALUES 
	(1,'Venom',2021),
    (2,'The Flash',2023),
    (3,'No Time to Die',2021),
    (4,'Halloween Kills',2021),
    (5,'The Last Duel ',2021),

-- creating table for media
CREATE TABLE media (
    media_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    movie_id INT NOT NULL,
    media_type VARCHAR(255) NOT NULL,
    media_url VARCHAR(255) NOT NULL,
    FOREIGN KEY (movie_id)
    REFERENCES movie (movie_id)
);
   
-- image and video data
INSERT INTO media (media_id,movie_id,media_type,media_url) VALUES 
	(1,1,'image','https://Venom/img.png'),
	(2,1,'video','https://Venom/video.mp4'),
	(3,2,'image','https://Flash/img.png'),
	(4,2,'video','https://Flash/video.mp4'),
	(5,3,'image','https://Die/img.png'),
	(6,3,'video','https://Die/video.mp4'),	
    (7,4,'image','https://Halloween/img.png'),	
    (8,4,'video','https://Halloween/video.mp4'),
	(9,5,'image','https://Duel/img.png'),
    (10,5,'video','https://Duel/video.mp4');
    
  
-- select query with join

 SELECT movie.movie_id, movie.movie_title,movie.movie_year,media.media_url
  FROM  movie INNER JOIN media ON movie.movie_id = media.movie_id;
   

-- creating table for genre
CREATE TABLE genre (
	genre_id INT NOT NULL,
	genre_name VARCHAR(255) NOT NULL,
	PRIMARY KEY(genre_id)
);

--genre data
INSERT INTO genre (genre_id,genre_name) VALUES 
	(1,'Action'),
	(2,'Thriller'),
	(3,'Adventure'),
	(4,'Crime'),
	(5,'Drama'),
	(6,'Romance'),
	(7,'Comedy');
    
    
-- creating table for movie genre
CREATE TABLE movie_genre (
	movie_genre_id INT NOT NULL,
	movie_id INT NOT NULL,
	genre_id INT NOT NULL,
	FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
	FOREIGN KEY (genre_id) REFERENCES genre(genre_id),
	PRIMARY KEY(movie_genre_id)
);

--  movie genre data
INSERT INTO movie_genre (movie_genre_id,movie_id,genre_id) VALUES
	(1,1,1),
	(2,1,2),
	(3,1,4),
	(4,1,7),
	(5,2,1),
	(6,2,2),
	(7,2,4),
	(8,2,7),
	(9,3,1),
	(10,3,2),
	(11,3,4),
	(12,3,6),
	(13,3,7),
	(14,4,1),
	(15,4,2),
	(16,4,3),
	(17,4,7),
	(18,5,1),
	(19,5,2),
	(20,5,3),
	(21,5,6),
	(22,5,7);
	

    
--  movie and genre 
 
SELECT movie.movie_id,movie.movie_title,movie.movie_year,genre.genre_name FROM movie INNER JOIN movie_genre ON movie.movie_id = movie_genre.movie_id
  INNER JOIN  genre ON genre.genre_id = movie_genre.genre_id;
    
 
-- creating table for user
CREATE TABLE user (
  user_id INT NOT NULL,
  username VARCHAR(255),
  PRIMARY KEY(user_id)
); 

--  user data
INSERT INTO user (user_id,username) VALUES 
(1,'1_username'),
(2,'2_username'),
(3,'3_username'),
(4,'4_username'),
(5,'5_username');

-- creating table for review
CREATE TABLE review (
  review_id INT NOT NULL,
  movie_id INT NOT NULL,
  user_id INT NOT NULL,
  review_text VARCHAR(255) NOT NULL,
  review_rating INT NOT NULL,
  FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id),
  PRIMARY KEY(review_id)
); 

-- review data
INSERT INTO review (review_id,movie_id,user_id,review_text,review_rating) VALUES 
(1,1,1,'Block Buster',2),
(2,2,2,'Super Hit',4),
(3,3,3,'Block Buster',4),
(4,4,4,'Super Hit',4),
(5,5,5,'Block Buster',5),
(6,6,1,'Block Buster',3),
(7,1,2,'Ultimate',5),
(8,2,3,'Block Buster',5),
(9,3,4,'Ultimate',5),
(10,4,5,'Block Buster',5),
(11,5,2,'Ultimate',5),
(12,6,3,'Super Hit',4);

--   
--  movie and review 
SELECT  movie.movie_title,review.review_text AS review,review.review_rating AS rating,user.username FROM movie INNER JOIN review ON movie.movie_id = review.movie_id INNER JOIN user ON user.user_id = review.user_id;
 
-- creating table for artist
CREATE TABLE artist (
	artist_id INT NOT NULL,
    movie_id INT NOT NULL,
	artist_name VARCHAR(255) NOT NULL,
	FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
	PRIMARY KEY(artist_id)
);

-- loading artist data
INSERT INTO artist (artist_id,movie_id,artist_name) VALUES 
	(1,1,'siva'),
	(2,2,'Suriya'),
	(3,3,'ajith'),
	(4,4,'vijay'),
	(5,5,'karthick'),
	(6,6,'prakesh');

-- creating table for skill 
CREATE TABLE skill (
	skill_id INT NOT NULL,
	skill_name VARCHAR(255) NOT NULL,
	PRIMARY KEY(skill_id)
);

--  skill data
INSERT INTO skill (skill_id,skill_name) VALUES 
	(1,'Stunt'),
	(2,'Comedy'),
	(3,'Direction'),
	(4,'Acting'),
	(5,'Dance');

	
    
-- creating table for artist skill 
CREATE TABLE artist_skill (
	artist_id INT NOT NULL,
	skill_id INT NOT NULL,
	movie_id INT NOT NULL,
	FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
	FOREIGN KEY (skill_id) REFERENCES skill(skill_id),
	FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

-- loading artist_skill data's
INSERT INTO artist_skill (artist_id,skill_id,movie_id) VALUES 
(1,1,1),
(1,2,1),
(1,5,1),

(2,1,1),
(2,5,1),

(3,1,1),
(3,2,1),
(3,3,1),
(3,5,1),

(4,1,1),
(4,2,1),
(4,3,1),
(4,5,1),

(5,1,1),
(5,2,1),
(5,3,1);

 
-- viewing artist skill data with join functions
SELECT 
    artist.artist_name AS artist, skill.skill_name AS skill
FROM
    artist_skill
        INNER JOIN
    artist ON artist.artist_id = artist_skill.artist_id
        INNER JOIN
    skill ON skill.skill_id = artist_skill.skill_id;
--

-- Create table for role
CREATE TABLE role (
	role_id INT NOT NULL,
	role_name VARCHAR(255) NOT NULL,
	PRIMARY KEY(role_id)
);

--  role data
INSERT INTO role (role_id,role_name) VALUES 
	(1,'lawyer'),
	(2,'teacher'),
	(3,'engineer'),
	(4,'IT'),
	(5,'Doctor'),


   
-- Create table for artist_role
CREATE TABLE artist_role (
	artist_id INT NOT NULL,
	movie_id INT NOT NULL,
	role_id INT NOT NULL,
	FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
	FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
	FOREIGN KEY (role_id) REFERENCES role(role_id),
	PRIMARY KEY (artist_id, movie_id,role_id)
);

-- loading role data's
INSERT INTO artist_role (artist_id,movie_id,role_id) VALUES 
	(1,1,1),
	(1,1,2),
	(3,3,3),
	(4,4,4),
	(5,5,5);
  
 
--  movie and artist 
 
  SELECT movie.movie_title, artist.artist_name AS artist, role.role_name AS role FROM movie INNER JOIN  artist_role ON movie.movie_id = artist_role.movie_id INNER JOIN artist ON artist.artist_id = movie.movie_id INNER JOIN role ON role.role_id = artist_role.role_id;

    
        
  
        
    
        
    
