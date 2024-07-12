BEGIN;

CREATE OR REPLACE FUNCTION delete_unsuccessful_contributions()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.OA = FALSE AND NEW.InterviewStage = 0 AND NEW.OfferCall = FALSE THEN
        DELETE FROM Contributions WHERE UID = NEW.UID AND JID = NEW.JID;
        DELETE FROM Tags WHERE UID = NEW.UID AND JID = NEW.JID
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS delete_unsuccessful_contributions_trigger ON Contributions;
CREATE TRIGGER delete_unsuccessful_contributions_trigger
AFTER INSERT OR UPDATE ON Contributions
FOR EACH ROW
EXECUTE FUNCTION delete_unsuccessful_contributions();


-- STAGE
CREATE OR REPLACE FUNCTION enforce_stage_single_row()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT COUNT(*) FROM Stage) >= 1 THEN
        RAISE EXCEPTION 'Only one row is allowed in the Stage table';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS stage_single_row_trigger ON Stage;
CREATE TRIGGER stage_single_row_trigger
BEFORE INSERT ON Stage
FOR EACH ROW
EXECUTE FUNCTION enforce_stage_single_row();


-- YEAR
CREATE OR REPLACE FUNCTION enforce_year_single_row()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT COUNT(*) FROM Year) >= 1 THEN
        RAISE EXCEPTION 'Only one row is allowed in the Year table';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS year_single_row_trigger ON Year;
CREATE TRIGGER year_single_row_trigger
BEFORE INSERT ON Year
FOR EACH ROW
EXECUTE FUNCTION enforce_year_single_row();


-- SEASON
CREATE OR REPLACE FUNCTION enforce_season_single_row()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT COUNT(*) FROM Season) >= 1 THEN
        RAISE EXCEPTION 'Only one row is allowed in the Season table';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS season_single_row_trigger ON Season;
CREATE TRIGGER season_single_row_trigger
BEFORE INSERT ON Season
FOR EACH ROW
EXECUTE FUNCTION enforce_season_single_row();


-- CYCLE
CREATE OR REPLACE FUNCTION enforce_cycle_single_row()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT COUNT(*) FROM Cycle) >= 1 THEN
        RAISE EXCEPTION 'Only one row is allowed in the Cycle table';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS cycle_single_row_trigger ON Cycle;
CREATE TRIGGER cycle_single_row_trigger
BEFORE INSERT ON Cycle
FOR EACH ROW
EXECUTE FUNCTION enforce_cycle_single_row();

-- ContributionLogs
CREATE OR REPLACE FUNCTION log_contribution_change()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO ContributionsLogs (LogTime, UID, JID, OA, InterviewStage, OfferCall)
    VALUES (CURRENT_TIMESTAMP, NEW.UID, NEW.JID, NEW.OA, NEW.InterviewStage, NEW.OfferCall);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS log_contribution_change_trigger ON Contributions;
CREATE TRIGGER log_contribution_change_trigger
BEFORE INSERT OR UPDATE ON Contributions
FOR EACH ROW
EXECUTE FUNCTION log_contribution_change();

COMMIT;
