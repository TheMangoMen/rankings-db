psql -U $DB_USER -d $DB_NAME -f ../sql/drop_tables.sql
psql -U $DB_USER -d $DB_NAME -f ../sql/create_tables.sql

TABLE_NAMES=("jobs" "users" "rankings")

cd ../sql

# Define corresponding CSV files
CSV_FILES=("sample/jobs_short.csv" "sample/users.csv" "sample/rankings.csv")

# Loop over table names and CSV files
for ((i=0; i<${#TABLE_NAMES[@]}; i++)); do
    TABLE_NAME="${TABLE_NAMES[i]}"
    CSV_FILE="${CSV_FILES[i]}"
    
    psql -U "$DB_USER" -d "$DB_NAME" -c "\COPY $TABLE_NAME FROM '$CSV_FILE' WITH (FORMAT csv, HEADER true)"
    
    echo "Data imported successfully into table $TABLE_NAME from $CSV_FILE."
done