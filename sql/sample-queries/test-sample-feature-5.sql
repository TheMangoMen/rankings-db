SELECT j.company, t.oadifficulty, t.oalength, t.interviewvibe, t.interviewtechnical, t.offercomp, count(*) as count
FROM tags t JOIN jobs j ON j.jid = t.jid
GROUP BY j.company, t.oadifficulty, t.oalength, t.interviewvibe, t.interviewtechnical, t.offercomp;

INSERT INTO
    Tags (uid, jid, oadifficulty, oalength, interviewvibe, interviewtechnical, offercomp)
VALUES
    ('j12cole', 362791, 'Medium', '1 to 2 Hours', 'Good', 'Technical', 50.00) ON CONFLICT (uid, jid) DO
UPDATE
SET
    oadifficulty = EXCLUDED.oadifficulty,
    oalength = EXCLUDED.oalength,
    interviewvibe = EXCLUDED.interviewvibe,
    interviewtechnical = EXCLUDED.interviewtechnical,
    offercomp = EXCLUDED.offercomp
RETURNING *;

INSERT INTO
    Tags (uid, jid, oadifficulty, oalength, interviewvibe, interviewtechnical, offercomp)
VALUES
    ('j12cole', 362791, 'Medium', '1 to 2 Hours', 'Good', 'Technical', 100.00) ON CONFLICT (uid, jid) DO
UPDATE
SET
    oadifficulty = EXCLUDED.oadifficulty,
    oalength = EXCLUDED.oalength,
    interviewvibe = EXCLUDED.interviewvibe,
    interviewtechnical = EXCLUDED.interviewtechnical,
    offercomp = EXCLUDED.offercomp
RETURNING *;

DELETE FROM Tags WHERE uid = 'j12cole' AND jid = 362791;
