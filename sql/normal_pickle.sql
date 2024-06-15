-- insert
insert into
    Users (UID)
values
    ('njchen');

insert into
    Admins (UID)
values
    ('njchen');

select
    *
from
    Contributions;

INSERT INTO
    Contributions (UID, JID, OA, InterviewStage, OfferCall)
VALUES
    ('njchen', 362791, TRUE, 2, FALSE) ON CONFLICT (UID, JID) DO
UPDATE
SET
    OA = EXCLUDED.OA,
    InterviewStage = EXCLUDED.InterviewStage,
    OfferCall = EXCLUDED.OfferCall;

select
    *
from
    Contributions;

INSERT INTO
    Contributions (UID, JID, OA, InterviewStage, OfferCall)
VALUES
    ('njchen', 362791, TRUE, 3, TRUE) ON CONFLICT (UID, JID) DO
UPDATE
SET
    OA = EXCLUDED.OA,
    InterviewStage = EXCLUDED.InterviewStage,
    OfferCall = EXCLUDED.OfferCall;

select
    *
from
    Contributions;

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
    ('njchen', 383229, 8, 'Offer') ON CONFLICT (UID, JID) DO
UPDATE
SET
    UserRanking = EXCLUDED.UserRanking,
    EmployerRanking = EXCLUDED.EmployerRanking;