SELECT j.company, t.oadifficulty, t.oalength, t.interviewvibe, t.interviewtechnical, t.offercomp, count(*) as count
FROM tags t JOIN jobs j ON j.jid = t.jid
GROUP BY j.company, t.oadifficulty, t.oalength, t.interviewvibe, t.interviewtechnical, t.offercomp;

INSERT INTO
    Tags (uid, jid, oadifficulty, oalength, interviewvibe, interviewtechnical, offercomp)
VALUES
    ('njchen', 366111, 'Medium', 'Over 2 Hours', 'Bad', 'Somewhat', 45.00) ON CONFLICT (uid, jid) DO
UPDATE
SET
    oadifficulty = EXCLUDED.oadifficulty,
    oalength = EXCLUDED.oalength,
    interviewvibe = EXCLUDED.interviewvibe,
    interviewtechnical = EXCLUDED.interviewtechnical,
    offercomp = EXCLUDED.offercomp
RETURNING *;

DELETE FROM Tags WHERE uid = 'njchen' AND jid = 366111;
