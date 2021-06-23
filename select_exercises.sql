# 2. USE the albums_db database.
	USE `albums_db`;

# 3. Explore the structure of the albums table.
	DESCRIBE albums;
#	a. How many ROWS are IN the albums TABLE?
	SELECT *
	FROM albums;
	-- 31
#	b. How many UNIQUE artist NAMES are IN the albums TABLE?
	SELECT DISTINCT
		artist
	FROM albums;
	-- 23
#	c. What IS the PRIMARY KEY FOR the albums TABLE?
	DESCRIBE albums;
	-- id
#	d. What IS the oldest RELEASE DATE FOR ANY album IN the albums TABLE? What IS the most recent RELEASE DATE?
  	SELECT release_date
    FROM albums
    ORDER BY release_date;

    Can also DO descending BY doing 
    ORDER BY release_date DESC;

    Can also USE TO get the max AND min VALUE respectively
    SELECT max(release_date)
    FROM albums;

    SELECT min(release_date)
    FROM albums;
      -- 1967
    
# 4. WRITE queries TO find the following information:  
#	a. The NAME of ALL albums BY Pink Floyd
	SELECT *
    FROM albums
    WHERE artist = "pink floyd";
    -- `The Dark Side of the Moon`, `The Wall`
#	b. The YEAR Sgt. Pepper's Lonely Hearts Club Band was released
    SELECT *
    FROM albums
    WHERE NAME = "Sgt. Pepper's Lonely Hearts Club Band";
    -- Also can DO 
    SELECT *
    FROM albums
    WHERE NAME = 'Sgt. Pepper\'s Lonely Hearts Club Band';
     -- 1967
#	c. The genre FOR the album Nevermind
	SELECT *
    FROM albums
    WHERE NAME = "Nevermind";
     -- Grunge, Alternative Rock
#	d. Which albums were released IN the 1990s
	SELECT
       NAME,
       release_date
    FROM albums
    WHERE release_date BETWEEN 1990 AND 1999;
#	e. Which albums had LESS THAN 20 million certified sales
	SELECT
        NAME,
        sales
    FROM albums
    WHERE sales < 20;
#	f. ALL the albums WITH a genre of "Rock". Why DO these QUERY results NOT include albums WITH a genre of "Hard rock" OR "Progressive rock"?
	SELECT
        NAME,
        genre
    FROM albums
    WHERE genre = 'rock';
    
/* The reason it did NOT include albums WITH the genre of "Hard rock" AND "Progressive rock" IS because the parameter of my QUERY IS
   only "Rock" AND will only RETURN within those parameters. The Genre will have TO equal only "Rock" not with any other parameters. 
   If we wanted to include the other "rock" Genre's we would have to change the parameters. Has to be an exact match, not looking at
   a piece, it's looking at the entire value. */

        -- Can also use to include all genres that have rock in the name
        SELECT 
	        NAME,
	        genre 
        FROM albums WHERE genre LIKE '%Rock%';