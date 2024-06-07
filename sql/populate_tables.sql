COPY Jobs
FROM
    '/Users/michaelxu/Code/cs348/data-ingest/sql/sample/jobs_short.csv' WITH (FORMAT csv, HEADER true);

COPY Users
FROM
    '/Users/michaelxu/Code/cs348/data-ingest/sql/sample/users.csv' WITH (FORMAT csv, HEADER true);

COPY Rankings
FROM
    '/Users/michaelxu/Code/cs348/data-ingest/sql/sample/rankings.csv' WITH (FORMAT csv, HEADER true);