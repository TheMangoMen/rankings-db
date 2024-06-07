select
    userid,
    name,
    ranking,
    company,
    jobtitle
from
    users NATURAL
    JOIN rankings NATURAL
    JOIN jobs
ORDER BY
    userid;