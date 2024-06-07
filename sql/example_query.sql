select
    userid,
    name,
    EmployerRanking,
    UserRanking,
    company,
    jobtitle
from
    users NATURAL
    JOIN rankings NATURAL
    JOIN jobs
ORDER BY
    userid;