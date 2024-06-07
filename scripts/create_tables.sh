psql -U $DB_USER -d $DB_NAME -f ../sql/drop_tables.sql
psql -U $DB_USER -d $DB_NAME -f ../sql/create_tables.sql
psql -U $DB_USER -d $DB_NAME -f ../sql/populate_tables.sql