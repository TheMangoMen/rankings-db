with goodjobs as (
    SELECT
        JID,
        SUM(CASE WHEN OA = 't' THEN 1 ELSE 0 END) oaCount,
        SUM(CASE WHEN InterviewStage >= 1 THEN 1 ELSE 0 END) int1Count,
        SUM(CASE WHEN InterviewStage >= 2 THEN 1 ELSE 0 END) int2Count,
        SUM(CASE WHEN InterviewStage >= 3 THEN 1 ELSE 0 END) int3Count,
        SUM(CASE WHEN OfferCall = 't' THEN 1 ELSE 0 END) offerCount
    FROM Contributions
    GROUP BY JID
),
watches as (
    SELECT *, TRUE as Watch from Watching where UID = 'j12cole'
)
SELECT 
    j.*,
    COALESCE(g.oaCount, 0) oaCount,
    COALESCE(g.int1Count, 0) int1Count,
    COALESCE(g.int2Count, 0) int2Count,
    COALESCE(g.int3Count, 0) int3Count,
    COALESCE(g.OfferCount, 0) OfferCount,
    COALESCE(w.Watch, FALSE) watched
FROM jobs j
LEFT JOIN goodjobs g 
    ON j.JID = g.JID
LEFT JOIN watches w 
    ON j.JID = w.JID
ORDER BY j.JID
