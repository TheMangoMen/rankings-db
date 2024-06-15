select
    JID,
    Title,
    Company,
    Location,
    Openings
from
    users NATURAL
    JOIN rankings NATURAL
    JOIN jobs
ORDER BY
    JID;

select
    UID,
    COUNT(*) NumContributions
from
    Contributions
GROUP BY
    UID;