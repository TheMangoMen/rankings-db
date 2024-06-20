BEGIN;

DROP TYPE IF EXISTS SeasonEnum;
CREATE TYPE SeasonEnum as ENUM ('Fall', 'Spring', 'Winter');

DROP TYPE IF EXISTS EmployerRankingEnum;
CREATE TYPE EmployerRankingEnum as ENUM ('Offer', 'Ranked');

COMMIT;
