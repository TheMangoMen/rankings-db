CREATE TABLE Jobs (
    JobId INT PRIMARY KEY,
    Company TEXT,
    JobTitle TEXT,
    Location TEXT,
    Openings INT
);

CREATE TABLE Users (
    UserId TEXT PRIMARY KEY,
    Name TEXT,
    Email TEXT,
    Affiliation TEXT
);

CREATE TABLE Rankings (
    UserId TEXT,
    JobId INT,
    Ranking INT,
    PRIMARY KEY (UserId, JobId),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (JobId) REFERENCES Jobs(JobId)
);