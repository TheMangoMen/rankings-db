BEGIN;

DROP TYPE IF EXISTS SeasonEnum;
CREATE TYPE SeasonEnum as ENUM ('Fall', 'Spring', 'Winter');

DROP TYPE IF EXISTS EmployerRankingEnum;
CREATE TYPE EmployerRankingEnum as ENUM ('Offer', 'Ranked');

DROP TYPE IF EXISTS DifficultyEnum;
CREATE TYPE DifficultyEnum as ENUM ('Easy', 'Medium', 'Hard', '');

DROP TYPE IF EXISTS LengthEnum;
CREATE TYPE LengthEnum as ENUM ('Under 1 Hour', '1 to 2 Hours', 'Over 2 Hours', '');

DROP TYPE IF EXISTS VibeEnum;
CREATE TYPE VibeEnum as ENUM ('Bad', 'Neutral', 'Good', '');

DROP TYPE IF EXISTS TechnicalEnum;
CREATE TYPE TechnicalEnum as ENUM ('Non-technical', 'Somewhat', 'Technical', '');

COMMIT;
