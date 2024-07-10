# ./setup.sh for production
# ./setup.sh -s for sample
# add .pgpass
set -o allexport
source .env
set +o allexport

psql -h localhost -p 5432 -U ${DB_USER} -d ${DB_NAME} -f sql/create_types.sql
psql -h localhost -p 5432 -U ${DB_USER} -d ${DB_NAME} -f sql/create_tables.sql
psql -h localhost -p 5432 -U ${DB_USER} -d ${DB_NAME} -f sql/create_triggers.sql
psql -h localhost -p 5432 -U ${DB_USER} -d ${DB_NAME} -f sql/create_indexes.sql

TABLE_NAMES=(
	"jobs"
	"users"
	"admins"
	"watching"
	"contributions"
	"rankings"
	"tags"
)

SAMPLE_CSV_FILES=(
	"sql/sample/jobs.csv"
	"sql/sample/users.csv"
	"sql/sample/admins.csv"
	"sql/sample/watching.csv"
	"sql/sample/contributions.csv"
	"sql/sample/rankings.csv"
	"sql/sample/tags.csv"
)

PRODUCTION_CSV_FILES=(
	"sql/production/prod_jobs.csv"
	"sql/production/prod_users.csv"
	"sql/production/prod_admins.csv"
	"sql/production/prod_watching.csv"
	"sql/production/prod_contributions.csv"
	"sql/production/prod_rankings.csv"
	"sql/production/prod_tags.csv"
)

data_type="production"
while getopts "s" opt; do
	case $opt in
	s)
		data_type="sample"
		;;
	*)
		echo "Usage: $0 [-s]"
		echo "  -s    Use sample data (default is production data)"
		exit 1
		;;
	esac
done

if [ "$data_type" = "sample" ]; then
	CSV_FILES=("${SAMPLE_CSV_FILES[@]}")
else
	CSV_FILES=("${PRODUCTION_CSV_FILES[@]}")
fi

# Loop over arrays in sync (assuming both arrays have the same length)
for ((i = 0; i < ${#TABLE_NAMES[@]}; i++)); do
	TABLE_NAME="${TABLE_NAMES[i]}"
	CSV_FILE="${CSV_FILES[i]}"

	# Use psql to copy data from CSV file into the database table
	psql -h localhost -p 5432 -U "$DB_USER" -d "$DB_NAME" -c "\COPY $TABLE_NAME FROM '$CSV_FILE' WITH (FORMAT csv, HEADER true)"

	echo "Data imported successfully into table $TABLE_NAME from $CSV_FILE."
done
