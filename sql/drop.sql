BEGIN;
DROP TRIGGER IF EXISTS delete_unsuccessful_contributions_trigger ON Contributions;
DROP TRIGGER IF EXISTS stage_single_row_trigger ON Stage;
DROP TRIGGER IF EXISTS year_single_row_trigger ON Year;
DROP TRIGGER IF EXISTS season_single_row_trigger ON Season;
DROP TRIGGER IF EXISTS cycle_single_row_trigger ON Cycle;

DROP TABLE IF EXISTS Jobs;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Admins;
DROP TABLE IF EXISTS Watching;
DROP TABLE IF EXISTS Contributions;
DROP TABLE IF EXISTS Rankings;
DROP TABLE IF EXISTS Stage;
DROP TABLE IF EXISTS Year;
DROP TABLE IF EXISTS Season;
DROP TABLE IF EXISTS Cycle;

DROP TYPE IF EXISTS SeasonEnum;
DROP TYPE IF EXISTS EmployerRankingEnum;
COMMIT;
