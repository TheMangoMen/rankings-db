# Check if the database exists
EXISTING_DB=$(psql -h localhost -p 5432 -lqt | cut -d \| -f 1 | grep -wq "$DB_NAME" && echo "true" || echo "false")

# If the database does not exist, create it
if [ "$EXISTING_DB" == "false" ]; then
	# Create the database
	createdb "$DB_NAME"
	echo "Database '$DB_NAME' created successfully."
else
	echo "Database '$DB_NAME' already exists."
fi

