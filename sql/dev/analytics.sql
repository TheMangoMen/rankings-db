WITH watched_status AS (
    SELECT
    c.jid,
    CASE
        WHEN BOOL_OR(c.offercall) THEN 'offercall'
        WHEN MAX(c.interviewstage) > 0 THEN 'interview'
        WHEN BOOL_OR(c.oa) THEN 'oa'
        ELSE 'nothing'
    END AS status
    FROM users u JOIN watching w ON w.uid = u.uid LEFT JOIN contributions c ON w.jid = c.jid
    WHERE u.uid = 'njchen' GROUP BY c.jid
),
status_counts AS (
    SELECT status, COUNT(status) AS count
    FROM watched_status
    GROUP BY status
)
SELECT s.statusname, COALESCE(sc.count, 0) AS count
FROM AnalyticsStatuses s LEFT OUTER JOIN status_counts sc ON s.statusid = sc.status
ORDER BY s.ranking;
