BEGIN;

DROP TYPE IF EXISTS SeasonEnum;
CREATE TYPE SeasonEnum as ENUM ('Fall', 'Spring', 'Winter');

DROP TYPE IF EXISTS EmployerRankingEnum;
CREATE TYPE EmployerRankingEnum as ENUM ('Offer', 'Ranked');

DROP TYPE IF EXISTS DifficultyEnum;
CREATE TYPE DifficultyEnum as ENUM ('Easy', 'Medium', 'Hard');

DROP TYPE IF EXISTS LengthEnum;
CREATE TYPE LengthEnum as ENUM ('Under1hr', '1to2Hrs', 'Over2hrs');

DROP TYPE IF EXISTS VibeEnum;
CREATE TYPE VibeEnum as ENUM ('Bad', 'Neutral', 'Good');

DROP TYPE IF EXISTS TechnicalEnum;
CREATE TYPE TechnicalEnum as ENUM ('Non-technical', 'Somewhat', 'Fully');

DROP TYPE IF EXISTS CompEnum;
CREATE TYPE CompEnum as ENUM ('Low', 'Decent', 'High');

COMMIT;
