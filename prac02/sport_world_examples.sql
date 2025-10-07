CREATE TABLE ADDRESS (
	ADDRESS_ID		char(5)			NOT NULL,
    ADDRESS_NAME 	varchar(45)		NOT NULL,
    ZIP_CODE		int,
    
    CONSTRAINT PK_ADDRESS PRIMARY KEY (ADDRESS_ID)
);

CREATE TABLE TEAM (
	TEAM_ID		char(5)			NOT NULL,
    TEAM_NAME 	varchar(45)		NOT NULL,
    PHONE		int,
    ADDRESS_ID	char(5)			NOT NULL,
    
    CONSTRAINT PK_TEAM PRIMARY KEY (TEAM_ID),
    FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESS(ADDRESS_ID)
);

CREATE TABLE PLAYER (
	PLAYER_ID	char(5)			NOT NULL,
    PLAYER_NAME varchar(45)		NOT NULL,
    PLAYER_NO 	int				NOT NULL,
    EMAIL		varchar(45)		NOT NULL,
    TEAM_ID		char(5)			NOT NULL,
    
    CONSTRAINT PK_Player PRIMARY KEY (PLAYER_ID),
    FOREIGN KEY (TEAM_ID) REFERENCES TEAM(TEAM_ID)
);

INSERT INTO ADDRESS
VALUES
	(A0001, Korea, 1001),
    (A0002, England, 1002),
    (A0003, Spain, 1003),
    (A0004, Italy, 1004);
    
SELECT * FROM prac02_sport.address;

INSERT INTO ADDRESS (ADDRESS_ID, ADDRESS_NAME, ZIP_CODE)
VALUES
	("A0001", "Korea", 1001),
    ("A0002", "England", 1002),
    ("A0003", "Spain", 1003),
    ("A0004", "Italy", 1004);
    
#Q1: Show only address name from ADDRESS relation
SELECT ADDRESS_NAME FROM ADDRESS; 

SELECT * FROM prac02_sport.player;

ALTER TABLE PLAYER
DROP COLUMN EMAIL;

INSERT INTO PLAYER
VALUES
	("P0111", "Saka", 7, "TM011"),
    ("P0112", "Leno", 1, "TM011"),
    ("P0113", "Son", 7, "TM012"),
    ("P0114", "Ronaldo", 7, "TM013"),
    ("P0115", "Pogba", 5, "TM013"),
    ("P0116", "Park", 10, "TM014"),
    ("P0117", "Pigue", 3, "TM015"),
    ("P0118", "Benzema", 3, "TM016"),
    ("P0119", "Dybala", 10, "TM017");
    
#Q3: Show the name of players who wears number 7 or 10 shirt
SELECT PLAYER_NAME, PLAYER_NO FROM PLAYER
WHERE PLAYER_NO = 7 OR PLAYER_NO = 10;

#Q4: Show how many players in PLAYER relation
SELECT COUNT(PLAYER_NO) AS NoOfPlayers
FROM PLAYER;

SELECT * FROM prac02_sport.team;

INSERT INTO TEAM
VALUES
	("TM011", "Arsenal", 12345, "A0002"),
    ("TM012", "Tottenham", 23456, "A0002"),
    ("TM013", "Manchester United", 23456, "A0002"),
    ("TM014", "FC Seoul", 34567, "A0001"),
    ("TM015", "Barcelona", 45678, "A0003"),
    ("TM016", "Real Madrid", null, "A0003"),
    ("TM017", "Juventus", null, "A0004");

#Q2: Show the teams whose name contains ‘en’ letters
SELECT TEAM_NAME FROM TEAM
WHERE TEAM_NAME LIKE '%en%';

SELECT * FROM world.countrylanguage;

#Task1: Find how many languages are spoken in the USA
SELECT COUNT(*) AS LanguagesInUSA
FROM countrylanguage
WHERE CountryCode = 'USA';

#Task2: Count how many languages are in the world
SELECT COUNT(Language)
FROM countrylanguage;

SELECT COUNT(DISTINCT Language)
FROM countrylanguage;

#Task3: Count how many countries speak each language
#Group by Language attribute: Arawakan, Armenian, Asami, etc
SELECT Language, COUNT(CountryCode)
FROM CountryLanguage
GROUP BY Language;

#Task4: Show how many languages are spoken in Korea
SELECT CountryCode, COUNT(Language)
FROM CountryLanguage
WHERE CountryCode = 'KOR';

SELECT * FROM world.country;

#Task5: List all countries in Europe, Oceania, and Antarctica. Use IN statement
SELECT Continent, Name
FROM Country
WHERE 
	Continent IN ('Europe', 'Oceania', 'Antarctica');

#Task6: Find the country with the highest population in Asia. Show the name and population of that country.
SELECT Name, Population
FROM Country
WHERE 
	Continent = 'Asia'
ORDER BY Population DESC
LIMIT 1;

#Task7: Show how many countries in each continent.
	#Return only continent name and count number
	#Exclude continents that have less than 5 countries
SELECT
  Continent       AS continent_name,
  COUNT(*)        AS country_count
FROM country
GROUP BY Continent
HAVING COUNT(*) >= 5
ORDER BY country_count DESC;

#Task8: Count how many countries speak each language.
	#Languages must be spoken at least 50 percent
	#Exclude languages that have less than 2 countries
    #Sort the result in descending order
    
SELECT * FROM world.countrylanguage;

SELECT
  Language,
  COUNT(DISTINCT CountryCode) AS country_count
FROM countrylanguage
WHERE Percentage >= 50                 -- 해당 언어가 그 나라에서 50% 이상 사용
GROUP BY Language
HAVING COUNT(DISTINCT CountryCode) >= 2 -- 2개 이상 국가에서 사용
ORDER BY country_count DESC;

SELECT * FROM world.city;
SELECT * FROM world.country;

#Q1-1: Show the countries and their cities
#Normal Query
SELECT CountryCode, Name
FROM city
ORDER BY CountryCode;

#Better Query
SELECT country.Name, city.Name
FROM city
JOIN country ON city.CountryCode;

#EVEN Better Query
SELECT C.Name, T.Name
FROM city T
JOIN country C ON T.CountryCode = C.Code;

#THE BEST Query
SELECT C.Name AS Country_Name, T.Name AS City_Name
FROM city T
JOIN country C ON T.CountryCode = C.Code;

#Task3: Show the countries and their cities where city population exceeds 5,000,000 people
SELECT C.Name AS Country_Name, T.Name AS City_Name, T.Population AS Population
FROM city T
JOIN country C ON T.CountryCode = C.Code
WHERE T.Population > 5000000;

#Q2: Language used in Berlin and where it is located? 
SELECT 
	C.Name AS City, 
    T.Name AS Country, 
    L.Language AS Language,
    L.Percentage AS Percentage
FROM city T
JOIN country C ON T.CountryCode = C.Code
JOIN countrylanguage L ON C.Code = L.CountryCode
WHERE T.Name = 'Berlin' AND L.IsOfficial = 'T';

#Task4: What is the capital city of Sweden and its official spoken language
SELECT
    C.Name AS Country,
    C.Capital AS Capital,
    L.Language AS OfficialLanguage
FROM country C
JOIN countrylanguage L ON C.Code = L.CountryCode
WHERE C.Name = 'Sweden' AND L.IsOfficial = 'T';    

