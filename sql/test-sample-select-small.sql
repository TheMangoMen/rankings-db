-- get contributions
SELECT *
FROM Contributions
WHERE jid = 362791 AND uid = 'j12cole';

-- get rankings
SELECT * FROM Rankings WHERE jid = 362791;

-- get ranking stage
SELECT * FROM Stage;

-- get user
SELECT * FROM Users WHERE UID = 'j12cole';
