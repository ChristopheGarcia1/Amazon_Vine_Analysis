CREATE TABLE review_id_table (
  review_id TEXT PRIMARY KEY NOT NULL,
  customer_id INTEGER,
  product_id TEXT,
  product_parent INTEGER,
  review_date DATE -- this should be in the formate yyyy-mm-dd
);

-- This table will contain only unique values
CREATE TABLE products_table (
  product_id TEXT PRIMARY KEY NOT NULL UNIQUE,
  product_title TEXT
);

-- Customer table for first data set
CREATE TABLE customers_table (
  customer_id INT PRIMARY KEY NOT NULL UNIQUE,
  customer_count INT
);

-- vine table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);


-- A query showing reviews with over 20 votes and 50% helpful
WITH cte_total_votes  AS (
SELECT *
	FROM vine_table
	WHERE (total_votes >= 20))
SELECT * FROM cte_total_votes
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5


-- A query looking at over 50% helpful reviews That are part of the vine program
WITH cte_total_votes  AS (
SELECT *
	FROM vine_table
	WHERE (total_votes >= 20))
SELECT * FROM cte_total_votes
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5 AND (vine = 'Y')


-- A query looking at over 50% helpful reviews That are NOT part of the vine program
WITH cte_total_votes  AS (
SELECT *
	FROM vine_table
	WHERE (total_votes >= 20))
SELECT * FROM cte_total_votes
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5 AND (vine = 'N')


WITH cte_total_reviews  AS ( 
	SELECT CAST(COUNT(review_id)AS FLOAT) AS total_reviews,
		vine
	FROM vine_table
	group by vine),
	
	cte_five_stars  AS ( 
	SELECT 
		CAST(COUNT(review_id) AS FLOAT) as five_stars,
		vine
	FROM vine_table
	WHERE star_rating = 5
	group by vine)
	
select tot.total_reviews,
fiv.five_stars/tot.total_reviews AS percentage_fivestars,
tot.vine
From cte_total_reviews AS tot
join cte_five_stars AS fiv
On( fiv.vine = tot.vine)















