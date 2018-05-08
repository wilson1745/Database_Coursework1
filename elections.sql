-- The comment lines starting -- ! are used by the automatic testing tool to
-- help mark your coursework. You must not modify them or add further lines
-- starting with -- !. Of course you can create comments of your own, just use
-- the normal -- to start them.

-- !elections

-- !question0
-- This is an example question and answer.

SELECT Party.name FROM Party 
JOIN Candidate ON Candidate.party = Party.id 
WHERE Candidate.name = 'Mark Bradshaw';

-- !question1

SELECT name FROM Party ORDER BY name ASC;

-- !question2

SELECT SUM(votes) FROM Candidate;

-- !question3

SELECT name, votes FROM Candidate 
WHERE ward = (SELECT id FROM Ward WHERE name = 'Southville');

-- !question4

SELECT votes AS LD_Bedminster FROM Candidate 
WHERE party = (SELECT id FROM Party WHERE name = 'Liberal Democrat') 
AND ward = (SELECT id FROM Ward WHERE name = 'Bedminster');

-- !question5

SELECT Candidate.name, Party.name AS party, votes FROM Candidate 
INNER JOIN Party ON Candidate.party = Party.id 
WHERE ward = (SELECT id FROM Ward WHERE name = 'Bedminster') 
ORDER BY votes DESC;

-- !question6

SELECT 1 + COUNT(1) FROM Candidate 
WHERE ward = (SELECT id FROM Ward WHERE name = 'Southville') 
AND votes > (SELECT votes FROM Candidate WHERE party = (SELECT id FROM Party WHERE name = 'Labour') 
AND ward = (SELECT id FROM Ward WHERE name = 'Southville'));

-- !question7

SELECT t1.name, (votes/sumvotes*100) AS percent_vote FROM (SELECT party, votes, ward, Ward.name FROM Candidate 
INNER JOIN Ward ON Ward.id = Candidate.ward 
INNER JOIN Party ON Candidate.party = Party.id WHERE Party.name = "Green") AS t1 
INNER JOIN (SELECT ward, SUM(votes) AS sumvotes FROM Candidate 
GROUP BY ward) AS t2 ON t1.ward = t2.ward;

-- !question8

SELECT t1.name, (t1.votes - t2.votes) AS abs, (((t1.votes - t2.votes)/Ward.electorate)*100) AS rel FROM (SELECT party, votes, ward, Ward.name FROM Candidate INNER JOIN Ward ON Ward.id = Candidate.ward INNER JOIN Party ON Candidate.party = Party.id WHERE Party.name = "Green") AS t1 
INNER JOIN Ward ON t1.ward = Ward.id 
INNER JOIN (SELECT party, votes, ward, Ward.name FROM Candidate INNER JOIN Ward ON Ward.id = Candidate.ward INNER JOIN Party ON Candidate.party = Party.id WHERE Party.name = "Labour") AS t2 
ON t1.ward = t2.ward WHERE (t1.votes - t2.votes) > 0;

-- !end




