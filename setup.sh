# add .pgpass
set -o allexport
source .env
set +o allexport

psql -h localhost -p 5432 -U ${DB_USER} -d ${DB_NAME} -f sql/create_types.sql
psql -h localhost -p 5432 -U ${DB_USER} -d ${DB_NAME} -f sql/create_tables.sql
psql -h localhost -p 5432 -U ${DB_USER} -d ${DB_NAME} -f sql/create_triggers.sql

TABLE_NAMES=(
	"jobs"
	"users"
	"admins"
	"watching"
	"contributions"
	"rankings"
)

CSV_FILES=(
	"sql/sample/jobs_short.csv"
	"sql/sample/users.csv"
	"sql/sample/admins.csv"
	"sql/sample/watching.csv"
	"sql/sample/contributions.csv"
	"sql/sample/rankings.csv"
)

# Loop over arrays in sync (assuming both arrays have the same length)
for ((i = 0; i < ${#TABLE_NAMES[@]}; i++)); do
	TABLE_NAME="${TABLE_NAMES[i]}"
	CSV_FILE="${CSV_FILES[i]}"

	# Use psql to copy data from CSV file into the database table
	psql -h localhost -p 5432 -U "$DB_USER" -d "$DB_NAME" -c "\COPY $TABLE_NAME FROM '$CSV_FILE' WITH (FORMAT csv, HEADER true)"

	echo "Data imported successfully into table $TABLE_NAME from $CSV_FILE."
done
