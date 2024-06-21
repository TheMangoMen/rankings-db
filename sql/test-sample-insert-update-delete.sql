-- upsert contributions
INSERT INTO
    Contributions (uid, jid, oa, interviewstage, offercall)
VALUES
    ('m4xu', 369074, true, 2, false) ON CONFLICT (uid, jid) DO
UPDATE
SET
    oa = EXCLUDED.oa,
    interviewstage = EXCLUDED.interviewstage,
    offercall = EXCLUDED.offercall
RETURNING *;

INSERT INTO
    Contributions (uid, jid, oa, interviewstage, offercall)
VALUES
    ('m4xu', 369074, true, 3, true) ON CONFLICT (uid, jid) DO
UPDATE
SET
    oa = EXCLUDED.oa,
    interviewstage = EXCLUDED.interviewstage,
    offercall = EXCLUDED.offercall
RETURNING *;

-- upsert ranking
INSERT INTO
    Rankings (uid, jid, userranking, employerranking)
VALUES
('m4xu', 369074, -1, 'Offer') ON CONFLICT (uid, jid) DO
UPDATE
SET
    userranking = EXCLUDED.userranking,
    employerranking = EXCLUDED.employerranking
RETURNING *;

INSERT INTO
    Rankings (uid, jid, userranking, employerranking)
VALUES
('m4xu', 369074, 1, 'Offer') ON CONFLICT (uid, jid) DO
UPDATE
SET
    userranking = EXCLUDED.userranking,
    employerranking = EXCLUDED.employerranking
RETURNING *;

-- create user
INSERT INTO Users (UID) VALUES ('njchen') ON CONFLICT DO NOTHING;
SELECT * FROM Users WHERE UID = 'njchen';

-- create watching
INSERT INTO Watching VALUES ('njchen', 369074) RETURNING *;

-- delete watching
DELETE FROM Watching WHERE uID = 'njchen' AND jID = 369074 RETURNING *;
