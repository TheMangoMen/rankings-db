begin;

CREATE TYPE SeasonEnum as ENUM ('Fall', 'Spring', 'Winter');

CREATE TABLE Jobs (
    JID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Company VARCHAR(255) NOT NULL,
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
    JID VARCHAR(50) NOT NULL,
    PRIMARY KEY (UID, JID),
    FOREIGN KEY (UID) REFERENCES Users(UID) ON DELETE CASCADE,
    FOREIGN KEY (JID) REFERENCES Jobs(JID) ON DELETE CASCADE
);

CREATE TYPE EmployerRankingEnum as ENUM ('Offer', 'Ranked');

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

-- TODO: add trigger
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

commit;