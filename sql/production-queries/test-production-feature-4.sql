SELECT *
FROM ContributionsLogs
ORDER BY LogID DESC;

INSERT INTO
    Contributions (uid, jid, oa, interviewstage, offercall)
VALUES
    ('njchen', 368822, true, 0, false) ON CONFLICT (uid, jid) DO
UPDATE
SET
    oa = EXCLUDED.oa,
    interviewstage = EXCLUDED.interviewstage,
    offercall = EXCLUDED.offercall
RETURNING *;

SELECT *
FROM ContributionsLogs
ORDER BY LogID DESC
LIMIT 5;

INSERT INTO
    Contributions (uid, jid, oa, interviewstage, offercall)
VALUES
    ('njchen', 368822, true, 2, false) ON CONFLICT (uid, jid) DO
UPDATE
SET
    oa = EXCLUDED.oa,
    interviewstage = EXCLUDED.interviewstage,
    offercall = EXCLUDED.offercall
RETURNING *;

SELECT *
FROM ContributionsLogs
ORDER BY LogID DESC
LIMIT 5;

DELETE FROM Contributions WHERE uid = 'njchen' AND jid = 368822;

SELECT *
FROM ContributionsLogs
ORDER BY LogID DESC
LIMIT 5;
