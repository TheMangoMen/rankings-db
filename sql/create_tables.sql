BEGIN;

DROP TABLE IF EXISTS Jobs;
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

DROP TABLE IF EXISTS Users;
CREATE TABLE Users (UID VARCHAR(8) PRIMARY KEY);

DROP TABLE IF EXISTS Admins;
CREATE TABLE Admins (
    UID VARCHAR(8) PRIMARY KEY,
    FOREIGN KEY (UID) REFERENCES Users(UID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Watching;
CREATE TABLE Watching (
    UID VARCHAR(8) NOT NULL,
    JID INT NOT NULL,
    PRIMARY KEY (UID, JID),
    FOREIGN KEY (UID) REFERENCES Users(UID) ON DELETE CASCADE,
    FOREIGN KEY (JID) REFERENCES Jobs(JID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Contributions;
CREATE TABLE Contributions (
    UID VARCHAR(8) NOT NULL,
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

DROP TABLE IF EXISTS Rankings;
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

DROP TABLE IF EXISTS Stage;
CREATE TABLE Stage (
    IsRankingStage BOOLEAN NOT NULL
);
INSERT INTO Stage (IsRankingStage) VALUES (true);

DROP TABLE IF EXISTS Year;
CREATE TABLE Year (
    Year INT NOT NULL
);
INSERT INTO Year (Year) VALUES (2024);

DROP TABLE IF EXISTS Season;
CREATE TABLE Season (
    Season SeasonEnum NOT NULL
);
INSERT INTO Season (Season) VALUES ('Fall');

DROP TABLE IF EXISTS Cycle;
CREATE TABLE Cycle (
    Cycle INT NOT NULL
    CHECK (
        Cycle >= 1
        AND Cycle <= 6
    )
);
INSERT INTO Cycle (Cycle) VALUES (2);

DROP TABLE IF EXISTS ContributionsLogs;
CREATE TABLE ContributionsLogs (
    LogID SERIAL PRIMARY KEY,
    LogTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UID VARCHAR(8) NOT NULL,
    JID INT NOT NULL,
    OA BOOLEAN NOT NULL DEFAULT FALSE,
    InterviewStage INT NOT NULL DEFAULT 0,
    OfferCall BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (UID) REFERENCES Users(UID) ON DELETE CASCADE,
    FOREIGN KEY (JID) REFERENCES Jobs(JID) ON DELETE CASCADE,
    CHECK (
        InterviewStage >= 0
        AND InterviewStage <= 3
    )
);

COMMIT;

DROP TABLE IF EXISTS AnalyticsStatuses;
CREATE TABLE AnalyticsStatuses (
    StatusID VARCHAR(256) PRIMARY KEY,
    StatusName VARCHAR(256) NOT NULL,
    Ranking INT NOT NULL UNIQUE
);
INSERT INTO AnalyticsStatuses(StatusID, StatusName, Ranking) VALUES ('nothing', 'Nothing', 1);
INSERT INTO AnalyticsStatuses(StatusID, StatusName, Ranking) VALUES ('oa', 'OA', 2);
INSERT INTO AnalyticsStatuses(StatusID, StatusName, Ranking) VALUES ('interview', 'Interview', 3);
INSERT INTO AnalyticsStatuses(StatusID, StatusName, Ranking) VALUES ('offercall', 'Offer Call', 4);
