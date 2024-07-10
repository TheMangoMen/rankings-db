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

SELECT COUNT(*) FROM Contributions WHERE uid = 'njchen' and jid = 368822;

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

SELECT COUNT(*) FROM Contributions WHERE uid = 'njchen' and jid = 368822;

INSERT INTO
    Contributions (uid, jid, oa, interviewstage, offercall)
VALUES
    ('njchen', 368822, true, 2, true) ON CONFLICT (uid, jid) DO
UPDATE
SET
    oa = EXCLUDED.oa,
    interviewstage = EXCLUDED.interviewstage,
    offercall = EXCLUDED.offercall
RETURNING *;

SELECT COUNT(*) FROM Contributions WHERE uid = 'njchen' and jid = 368822;

DELETE FROM Contributions WHERE uid = 'njchen' AND jid = 368822;
