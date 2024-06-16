begin;

DROP TYPE IF EXISTS SeasonEnum;

CREATE TYPE SeasonEnum as ENUM ('Fall', 'Spring', 'Winter');

CREATE TABLE Jobs (
    JID INT PRIMARY KEY,
    Company VARCHAR(255) NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Location VARCHAR(255),
    Openings INT NOT NULL,
    Season SeasonEnum NOT NULL,
    Year INT NOT NULL,
    Cycle INT NOT NULL,
    CHECK (Openings >= 1),
    CHECK (Year >= 1),
    CHECK (
        Cycle >= 1
        AND Cycle <= 6
    )
);

CREATE TABLE Users (UID VARCHAR(50) PRIMARY KEY);

CREATE TABLE Admins (
    UID VARCHAR(50) PRIMARY KEY,
    FOREIGN KEY (UID) REFERENCES Users(UID) ON DELETE CASCADE
);

CREATE TABLE Watching (
    UID VARCHAR(50) NOT NULL,
    JID INT NOT NULL,
    PRIMARY KEY (UID, JID),
    FOREIGN KEY (UID) REFERENCES Users(UID) ON DELETE CASCADE,
    FOREIGN KEY (JID) REFERENCES Jobs(JID) ON DELETE CASCADE
);

DROP TYPE IF EXISTS EmployerRankingEnum;

CREATE TYPE EmployerRankingEnum as ENUM ('Offer', 'Ranked');

CREATE TABLE Contributions (
    UID VARCHAR(50) NOT NULL,
    JID INT NOT NULL,
    OA BOOLEAN NOT NULL DEFAULT FALSE,
    InterviewStage INT NOT NULL DEFAULT 0,
    OfferCall BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (UID, JID),
    FOREIGN KEY (UID) REFERENCES Users(UID) ON DELETE CASCADE,
    FOREIGN KEY (JID) REFERENCES Jobs(JID) ON DELETE CASCADE,
    CHECK (
        InterviewStage >= 0
        AND InterviewStage <= 3
    )
);

-- CREATE TRIGGER delete_unsuccessful_contributions
-- AFTER INSERT OR UPDATE ON Contributions
-- FOR EACH ROW
-- BEGIN
--    IF NEW.OA = FALSE AND NEW.InterviewStage = 0 AND NEW.OfferCall = 0 THEN
--        DELETE FROM Contributions WHERE UID = NEW.UID AND JID = NEW.JID;
--    END IF;
-- END;

CREATE TABLE Rankings (
    UID VARCHAR(50) NOT NULL,
    JID INT NOT NULL,
    UserRanking INT NOT NULL,
    EmployerRanking EmployerRankingEnum NOT NULL,
    PRIMARY KEY (UID, JID),
    FOREIGN KEY (UID) REFERENCES Users(UID) ON DELETE CASCADE,
    FOREIGN KEY (JID) REFERENCES Jobs(JID) ON DELETE CASCADE,
    CHECK (
        UserRanking >= -1
        AND UserRanking <= 10
    )
);

CREATE TABLE Stage (
    IsRankingStage BOOLEAN NOT NULL
);

CREATE OR REPLACE FUNCTION enforce_single_row()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT COUNT(*) FROM Stage) >= 1 THEN
        RAISE EXCEPTION 'Only one row is allowed in the Stage table';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER single_row_trigger
BEFORE INSERT ON Stage
FOR EACH ROW
EXECUTE FUNCTION enforce_single_row();

INSERT INTO Stage (IsRankingStage) VALUES (true);

UPDATE Stage SET IsRankingStage = false;
UPDATE Stage SET IsRankingStage = true;
UPDATE Stage SET IsRankingStage = false;

commit;
