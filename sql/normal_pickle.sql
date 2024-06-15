-- insert
insert into
    Users (UID)
values
    ('njchen');

insert into
    Admins (UID)
values
    ('njchen');

INSERT INTO
    Contributions (UID, JID, OA, InterviewStage, OfferCall)
VALUES
    ('njchen', 362791, TRUE, 2, FALSE) ON CONFLICT (UID, JID) DO
UPDATE
SET
    OA = EXCLUDED.OA,
    InterviewStage = EXCLUDED.InterviewStage,
    OfferCall = EXCLUDED.OfferCall;

INSERT INTO
    Watching (UID, JID)
VALUES
    ('njchen', 362791);

DELETE FROM
    Watching
WHERE
    UID = 'njchen'
    AND JID = 362791;

INSERT INTO
    Rankings (UID, JID, UserRanking, EmployerRanking)
VALUES
    ('njchen', 383229, 8, 'Offer');