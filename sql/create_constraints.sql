CREATE UNIQUE INDEX unique_employer_ranking_1 ON Rankings (JobId)
WHERE
    EmployerRanking = '1';

ALTER TABLE
    Rankings
ADD
    CONSTRAINT check_user_ranking_null_when_not_ranked CHECK (
        (
            EmployerRanking = 'Not Ranked'
            AND UserRanking IS NULL
        )
        OR (EmployerRanking <> 'Not Ranked')
    );