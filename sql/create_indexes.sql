BEGIN;

CREATE INDEX idx_jobs_company ON jobs (company);

COMMIT;
