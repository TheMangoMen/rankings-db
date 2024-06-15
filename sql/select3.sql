SELECT *
FROM 
Jobs AS j LEFT JOIN
(
    SELECT *, TRUE AS watch
    FROM Watching
    WHERE UID = 'j12cole'
) w
ON w.JID = j.JID;

