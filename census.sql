-- This file is for your solutions to the census question.
-- Lines starting with -- ! are recognised by a script that we will
-- use to automatically test your queries, so you must not change
-- these lines or create any new lines starting with this marker.
--
-- You may break your queries over several lines, include empty
-- lines and SQL comments wherever you wish.
--
-- Remember that the answer to each question goes after the -- !
-- marker for it and that the answer to each question must be
-- a single SQL query.
--
-- Upload this file to SAFE as part of your coursework.

-- !census

-- !question0

-- Sample solution to question 0.

SELECT data FROM Statistic 
WHERE wardId = 'E05001982' AND occId = 2 AND gender = 0;

-- !question1

SELECT *FROM Statistic WHERE wardId = 'E05001979' AND occId = 7 AND gender = 1;

-- !question2

SELECT SUM(data) FROM Statistic WHERE wardId = 'E05000697' AND occId = 4;
 
-- !question3

SELECT Occupation.name AS occ, SUM(data) AS num FROM Statistic 
INNER JOIN Occupation ON Statistic.occId = Occupation.id 
WHERE Statistic.wardId = 'E05003701' 
GROUP BY Occupation.name 
ORDER BY Occupation.id ASC;

-- !question4

SELECT Statistic.wardId, SUM(Statistic.data) AS num, Ward.name, County.name AS county FROM Statistic 
LEFT JOIN Ward ON Statistic.wardId = Ward.code 
LEFT JOIN County ON Ward.parent = County.code 
GROUP BY Ward.name, Statistic.wardId, County.name   
ORDER BY SUM(Statistic.data) DESC LIMIT 1;

-- !question5

SELECT count(1) FROM (SELECT SUM(data) FROM Statistic 
GROUP BY wardId HAVING SUM(Statistic.data) >= 10000 
ORDER BY SUM(Statistic.data)) AS sum;

-- !question6

SELECT Region.name AS name, AVG(sum) FROM (SELECT SUM(t1.data) AS sum, Ward.code AS wardId, Ward.parent, County.parent AS region FROM (SELECT *FROM Statistic) AS t1 
INNER JOIN Ward ON t1.wardId = Ward.code 
INNER JOIN County ON Ward.parent = County.code 
WHERE Ward.parent IS NOT NULL 
GROUP BY wardId, Ward.code, Ward.parent, County.parent) AS a 
INNER JOIN Region ON Region.code = region 
GROUP BY region, Region.name;

-- !question7

SELECT County.name AS CLU, Occupation.name AS occupation, CASE WHEN gender = 0 THEN 'M' WHEN gender = 1 THEN 'F' END AS gender, SUM(t1.data) AS count 
FROM (SELECT *FROM Statistic) AS t1 
INNER JOIN Ward ON t1.wardId = Ward.code 
INNER JOIN County ON Ward.parent = County.code 
INNER JOIN Occupation ON Occupation.id = t1.occId 
WHERE County.parent = "E12000001" 
GROUP BY County.code, occId, t1.gender, Occupation.name, County.name  
HAVING SUM(t1.data) > 10000 
ORDER BY SUM(t1.data) ASC;

-- !question8

SELECT mregion AS region, men, women, (women/men) AS ratio 
FROM (SELECT Region.name AS mregion, SUM(data) AS men FROM Statistic INNER JOIN Ward ON Ward.code = Statistic.wardId INNER JOIN County ON County.code = Ward.parent INNER JOIN Region ON Region.code = County.parent WHERE Statistic.gender = 0 AND Statistic.occId = 1 
GROUP BY County.parent, Region.name) AS t1 
LEFT JOIN (SELECT Region.name AS fregion, SUM(data) AS women FROM Statistic INNER JOIN Ward ON Ward.code = Statistic.wardId INNER JOIN County ON County.code = Ward.parent INNER JOIN Region ON Region.code = County.parent WHERE Statistic.gender = 1 AND Statistic.occId = 1 
GROUP BY County.parent, Region.name) AS t2 
ON mregion = fregion 
ORDER BY ratio ASC;

-- !question9

SELECT Region.name AS name, AVG(sum) FROM (SELECT SUM(t1.data) AS sum, Ward.code AS wardId, Ward.parent, County.parent AS region FROM (SELECT *FROM Statistic) AS t1 
INNER JOIN Ward ON t1.wardId = Ward.code 
INNER JOIN County ON Ward.parent = County.code 
WHERE Ward.parent IS NOT NULL 
GROUP BY wardId, Ward.code, Ward.parent, County.parent) AS a 
INNER JOIN Region ON Region.code = region 
GROUP BY region, Region.name 
UNION 
SELECT Country.name AS name, AVG(sum) FROM (SELECT SUM(t1.data) AS sum, Ward.code AS wardId, Ward.parent, County.parent AS region FROM (SELECT *FROM Statistic) AS t1 
INNER JOIN Ward ON t1.wardId = Ward.code 
INNER JOIN County ON Ward.parent = County.code 
GROUP BY wardId, Ward.code, Ward.parent, County.parent) AS a 
INNER JOIN Region ON Region.code = region 
INNER JOIN Country ON Region.parent = Country.code 
GROUP BY Country.code, Country.name 
UNION 
SELECT CASE WHEN count(t2.wardId) = 8570 THEN 'All' END, AVG(sum) FROM (SELECT SUM(t1.data) AS sum, Ward.code AS wardId FROM (SELECT wardId, occId, gender, data FROM Statistic) AS t1 
INNER JOIN Ward ON t1.wardId = Ward.code  
GROUP BY wardId, Ward.code) AS t2 
INNER JOIN Ward ON Ward.code = t2.wardId;

-- !end
