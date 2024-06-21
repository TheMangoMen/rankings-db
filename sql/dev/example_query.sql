select
    JID,
    Title,
    Company,
    Location,
    Openings
from jobs
ORDER BY
    JID;

select
    UID,
    COUNT(*) NumContributions
from
    Contributions
GROUP BY
    UID;
