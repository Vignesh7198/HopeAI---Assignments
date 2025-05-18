CREATE DATABasE NetflixDB;

USE NetflixDB;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    registration_date DATE NOT NULL,
    plan ENUM('Basic', 'Standard', 'Premium') DEFAULT 'Basic'
);

CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    genre VARCHAR(100) NOT NULL,
    release_year YEAR NOT NULL,
    rating DECIMAL(3, 1) NOT NULL
);

CREATE TABLE WatchHistory (
    watch_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    movie_id INT,
    watched_date DATE NOT NULL,
    completion_percentage INT CHECK (completion_percentage >= 0 AND completion_percentage <= 100),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    user_id INT,
    review_text TEXT,
    rating DECIMAL(2, 1) CHECK (rating >= 0 AND rating <= 5),
    review_date DATE NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Users (name, email, registration_date, plan) 
VALUES
('John Doe', 'john.doe@example.com', '2024-01-10', 'Premium'),
('Jane Smith', 'jane.smith@example.com', '2024-01-15', 'Standard'),
('Alice Johnson', 'alice.johnson@example.com', '2024-02-01', 'Basic'),
('Bob Brown', 'bob.brown@example.com', '2024-02-20', 'Premium');

INSERT INTO Movies (title, genre, release_year, rating) 
VALUES
('Stranger Things', 'Drama', 2016, 8.7),
('Breaking Bad', 'Crime', 2008, 9.5),
('The Crown', 'History', 2016, 8.6),
('The Witcher', 'Fantasy', 2019, 8.2),
('Black Mirror', 'Sci-Fi', 2011, 8.8);

INSERT INTO WatchHistory (user_id, movie_id, watched_date, completion_percentage) 
VALUES
(1, 1, '2024-02-05', 100),
(2, 2, '2024-02-06', 80),
(3, 3, '2024-02-10', 50),
(4, 4, '2024-02-15', 100),
(1, 5, '2024-02-18', 90);

INSERT INTO Reviews (movie_id, user_id, review_text, rating, review_date) 
VALUES
(1, 1, 'Amazing storyline and great characters!', 4.5, '2024-02-07'),
(2, 2, 'Intense and thrilling!', 5.0, '2024-02-08'),
(3, 3, 'Good show, but slow at times.', 3.5, '2024-02-12'),
(4, 4, 'Fantastic visuals and acting.', 4.8, '2024-02-16');

#Question 1
select * from Users where plan='Premium';

#Question 2
select * from Movies where genre = 'Drama' and rating > 8.5;

#Question 3
select avg(rating) from movies where release_year >2015;

#Question 4

select u.name, w.completion_percentage from Movies 
join WatchHistory w on Movies.movie_id = w.movie_id
join Users u on u.user_id = w.user_id 
where Movies.title = 'Stranger Things';

#Question 5
select name from Reviews
join users on Reviews.user_id = users.user_id
where rating in (select max(rating)  from Reviews);

#Question 6
select w.user_id, count(w.movie_id) from WatchHistory w join Users u on u.user_id = w.user_id
group by w.user_id
order by count(w.movie_id) desc; 

#Question 7
select movies.movie_id, title, genre,rating, completion_percentage from Users 
join WatchHistory on Users.user_id = WatchHistory.user_id
join movies on WatchHistory.movie_id = movies.movie_id
where name = 'John Doe';

#Question 8
update Movies
set rating = 8
where title = "Stranger Things";

#Question 9
delete from reviews
where movie_id in (select movie_id from movies where rating < 4.0 );

#Question 10
select U.name, M.title, R.review_text from Users U
join Reviews R on U.user_id = R.user_id
join Movies M on R.movie_id = M.movie_id
left join WatchHistory W on U.user_id = W.user_id and M.movie_id = W.movie_id
where (W.completion_percentage IS NULL OR W.completion_percentage < 100);

#Question 11
select M.title, M.genre, W.completion_percentage 
from Movies M
join WatchHistory W on M.movie_id = W.movie_id
join Users U on W.user_id = U.user_id
WHERE U.name = 'John Doe';

#Question 12
select U.name, R.review_text, R.rating 
from Users U
join Reviews R on U.user_id = R.user_id
join Movies M on R.movie_id = M.movie_id
WHERE M.title = 'Stranger Things';

#Question 13
select U.name, U.email, M.title, M.genre, W.watched_date, W.completion_percentage 
from Users U
join WatchHistory W on U.user_id = W.user_id
join Movies M on W.movie_id = M.movie_id;

#Question 14
select M.title, count(R.review_id) as total_reviews, avg(R.rating) as average_rating 
from Movies M
join Reviews R on M.movie_id = R.movie_id
group by M.movie_id
having count(R.review_id) >= 2;
