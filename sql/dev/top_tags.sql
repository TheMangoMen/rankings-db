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
),
tags AS (
    WITH MostCommonOADifficulty AS (
        SELECT 
            JID,
            OADifficulty,
            COUNT(*) AS Occurrence,
            ROW_NUMBER() OVER (PARTITION BY JID ORDER BY COUNT(*) DESC) AS RowNum
        FROM Tags
        WHERE OADifficulty IS NOT NULL and OADifficulty <> ''
        GROUP BY JID, OADifficulty
    ),
    MostCommonOALength AS (
        SELECT 
            JID,
            OALength,
            COUNT(*) AS Occurrence,
            ROW_NUMBER() OVER (PARTITION BY JID ORDER BY COUNT(*) DESC) AS RowNum
        FROM Tags
        WHERE OALength IS NOT NULL and OALength <> ''
        GROUP BY JID, OALength
    ),
    MostCommonInterviewVibe AS (
        SELECT 
            JID,
            InterviewVibe,
            COUNT(*) AS Occurrence,
            ROW_NUMBER() OVER (PARTITION BY JID ORDER BY COUNT(*) DESC) AS RowNum
        FROM Tags
        WHERE InterviewVibe IS NOT NULL and InterviewVibe <> ''
        GROUP BY JID, InterviewVibe
    ),
    MostCommonInterviewTechnical AS (
        SELECT 
            JID,
            InterviewTechnical,
            COUNT(*) AS Occurrence,
            ROW_NUMBER() OVER (PARTITION BY JID ORDER BY COUNT(*) DESC) AS RowNum
        FROM Tags
        WHERE InterviewTechnical IS NOT NULL and InterviewTechnical <> ''
        GROUP BY JID, InterviewTechnical
    ),
    MostCommonOfferComp AS (
        SELECT 
            JID,
            OfferComp,
            COUNT(*) AS Occurrence,
            ROW_NUMBER() OVER (PARTITION BY JID ORDER BY COUNT(*) DESC) AS RowNum
        FROM Tags
        WHERE OfferComp IS NOT NULL
        GROUP BY JID, OfferComp
    )
    SELECT 
        d.JID,
        d.OADifficulty,
        l.OALength,
        v.InterviewVibe,
        t.InterviewTechnical,
        c.OfferComp
    FROM MostCommonOADifficulty d
    LEFT JOIN MostCommonOALength l ON d.JID = l.JID AND l.RowNum = 1
    LEFT JOIN MostCommonInterviewVibe v ON d.JID = v.JID AND v.RowNum = 1
    LEFT JOIN MostCommonInterviewTechnical t ON d.JID = t.JID AND t.RowNum = 1
    LEFT JOIN MostCommonOfferComp c ON d.JID = c.JID AND c.RowNum = 1
    WHERE d.RowNum = 1
)

SELECT
    j.jid,
    t.OADifficulty,
    t.OALength,
    t.InterviewVibe,
    t.InterviewTechnical,
    t.OfferComp
FROM jobs j
LEFT JOIN interviewcounts i
    ON j.JID = i.JID
LEFT JOIN watches w
    ON j.JID = w.JID
LEFT JOIN tags t
    ON j.JID = t.JID
WHERE j.season = (SELECT * FROM season) AND j.year = (SELECT * FROM year) AND j.cycle = (SELECT * FROM cycle)
ORDER BY j.company;

