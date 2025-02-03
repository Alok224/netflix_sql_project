-- CREATE TABLE netflix_table (
--     show_id VARCHAR(2),       
--     type VARCHAR(50),                 
--     title VARCHAR(255),               
--     director VARCHAR(255),            
--     "cast" TEXT,                        
--     country VARCHAR(100),             
--     date_added DATE,
-- 	 release_year INT, 
--     rating VARCHAR(50),               
--     duration VARCHAR(50),             
--     listed_in VARCHAR(255),           
--     description TEXT                  
-- );
-- SELECT * FROM netflix_table

-- ALTER TABLE netflix_table
-- ALTER COLUMN show_id TYPE INT;

-- ALTER TABLE netflix_table
-- ALTER COLUMN show_id TYPE INT USING show_id::VARCHAR;

-- ALTER TABLE netflix_table
-- ALTER COLUMN show_id TYPE VARCHAR USING show_id::TEXT;

-- SELECT *
-- FROM netflix_table
-- WHERE show_id ~ '[^0-9]';


-- SELECT column_name, data_type 
-- FROM information_schema.columns 
-- WHERE table_name = 'netflix_table';




-- COPY netflix_table (show_id, type, title, director, "cast", country, date_added, release_year, rating, duration, listed_in, description)
-- FROM 'C:\Users\HP\Downloads\archive\netflix_titles.csv'
-- DELIMITER ','
-- CSV HEADER;

-- ALTER TABLE netflix_table
-- ALTER COLUMN country TYPE VARCHAR(255);

-- SELECT COUNT(*) AS TOTAL_CONTENT FROM netflix_table;

-- Different types of movies
-- SELECT DISTINCT listed_in,type FROM netflix_table

-- count the number of movies and the tv shows

-- SELECT type,COUNT(type) AS No_Of_type FROM netflix_table
-- GROUP BY type

-- SELECT listed_in,COUNT(listed_in) AS No_Of_Movies FROM netflix_table
-- GROUP BY listed_in

-- Find the most common rating for movies and the TV shows

-- SELECT type,rating, COUNT(rating) AS MOST_COMMON_RATING FROM netflix_table
-- GROUP BY type,rating
-- ORDER BY MOST_COMMON_RATING DESC

-- List all movies which released in a specific year

-- SELECT type,title,release_year, count(release_year) FROM netflix_table
-- GROUP BY title,release_year,type HAVING count(release_year) = 1 AND type = 'Movie' AND release_year = '2020';

-- Find the top 5 countries with the most content on netflix


-- SELECT country,description,LENGTH(description) AS description_length FROM netflix_table
-- ORDER BY description_length DESC
-- LIMIT 5

-- Identify the longest movie
-- SELECT show_id,title,type, MAX(duration) FROM netflix_table
-- WHERE type = 'Movie'
-- GROUP BY show_id,title,type,duration
-- ORDER BY duration DESC
-- LIMIT 100;

-- SELECT title, duration FROM netflix_table
-- WHERE type = 'Movie'
-- ORDER BY CAST(SPLIT_PART(duration, ' ', 1) AS INT) DESC
-- LIMIT 5;

-- Find all the movies and Tv shows by director 'Rajiv chilaka!'

-- SELECT * FROM netflix_table
-- WHERE type = 'Movie' AND director ILIKE '%Rajiv Chilaka%'

-- SELECT * FROM netflix_table
-- WHERE date_added >= (CURRENT_DATE - INTERVAL '5 years');



-- SELECT title, type, date_added
-- FROM netflix_table
-- WHERE date_added >= (CURRENT_DATE - INTERVAL '5 years')
-- ORDER BY date_added DESC;


-- List all the tv shows with more than 5 seasons

-- SELECT * FROM netflix_table
-- WHERE type = 'TV Show' AND duration > '6 Season'

-- Count the number of content items in each genre
-- SELECT type,title,listed_in,COUNT(listed_in) AS Number_of_content FROM netflix_table
-- GROUP BY type,title,listed_in

-- SELECT UNNEST(STRING_TO_ARRAY(listed_in,',')) AS Genre, COUNT(show_id) AS total_content FROM netflix_table 
-- GROUP BY Genre

-- Find each year and the average numbers of content release by india on netflix and return top 5 year with highest avg content release!

-- SELECT EXTRACT(YEAR FROM date_added) AS year FROM netflix_table

-- List all the movies that are documentaries
-- SELECT title,type,listed_in FROM netflix_table
-- WHERE type = 'Movie' AND listed_in = 'Documentaries'

-- Find all the content without a director

-- SELECT title,type,director FROM netflix_table
-- WHERE director IS NULL

-- Find how many movies actor 'Salman khan' appeared in last 10 years

-- WHERE date_added >= (CURRENT_DATE - INTERVAL '5 years')


-- SELECT "cast" FROM netflix_table
-- WHERE "cast" ILIKE '%Salman Khan%'
-- AND release_year > EXTRACT(YEAR FROM CURRENT_DATE)- 10

-- SELECT date_added, pg_typeof(date_added) FROM netflix_table LIMIT 5;


-- Find the top 10 actors who have appeared in the highest number of movies produced in india

-- SELECT * FROM netflix_table
-- WHERE "cast" = (SELECT MAX("cast") FROM netflix_table) AND "cast" ILIKE '%Salman Khan%' AND type = 'Movie' AND country = 'India'
-- GROUP BY "cast"

-- SELECT COUNT(*) FROM netflix_table

-- SELECT UNNEST(STRING_TO_ARRAY("cast",',')) AS actors,COUNT(*) AS TOTAL_CONTENT
-- FROM netflix_table
-- GROUP BY actors
-- ORDER BY TOTAL_CONTENT DESC
-- LIMIT 10;



-- Categorize the content based on the presence of the keywords 'kill' and 'violence' in the discriptions 
-- field. Label content containing these keywords as 'Bad' and all other content as 'Good'. Count how many items fall
-- into each category.

-- SELECT type,description FROM netflix_table WHERE description ILIKE '%kill%' OR description ILIKE '%violence%'

SELECT *,
CASE
WHEN description ILIKE '%kill%'
OR
description ILIKE '%violence%' THEN 'Bad_content'
ELSE 'Good_content'
END category
FROM netflix_table



