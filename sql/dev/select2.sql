WITH interviewcounts AS (
    SELECT
        JID,
        SUM(CASE WHEN OA = true THEN 1 ELSE 0 END) oaCount,
        SUM(CASE WHEN InterviewStage >= 1 THEN 1 ELSE 0 END) int1Count,
        SUM(CASE WHEN InterviewStage >= 2 THEN 1 ELSE 0 END) int2Count,
        SUM(CASE WHEN InterviewStage >= 3 THEN 1 ELSE 0 END) int3Count,
        SUM(CASE WHEN OfferCall = true THEN 1 ELSE 0 END) offerCount
    FROM Contributions
    GROUP BY JID
),
watches AS (
    SELECT *, TRUE as watch from Watching where UID = 'njchen'
)
SELECT
    j.jid,
    j.title,
    j.company,
    coalesce(j.location, 'N/A') location,
    j.openings,
    j.season,
    j.year,
    j.cycle,
    COALESCE(i.oaCount, 0) oaCount,
    COALESCE(i.int1Count, 0) int1Count,
    COALESCE(i.int2Count, 0) int2Count,
    COALESCE(i.int3Count, 0) int3Count,
    COALESCE(i.OfferCount, 0) OfferCount,
    COALESCE(w.watch, FALSE) watching
FROM jobs j
LEFT JOIN interviewcounts i
    ON j.JID = i.JID
LEFT JOIN watches w
    ON j.JID = w.JID
WHERE j.season = (SELECT * FROM season)
    AND j.year = (SELECT * FROM year)
    AND j.cycle = (SELECT * FROM cycle)
ORDER BY j.company;
