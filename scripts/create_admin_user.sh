# Check if the user already exists
EXISTING_USER=$(psql -h localhost -p 5432 -tAc "SELECT 1 FROM pg_roles WHERE rolname='$DB_USER'")

# Print statement
if [ -z "$EXISTING_USER" ]; then
	echo "User '$DB_USER' does not exist. Creating user..."
else
	echo "User '$DB_USER' already exists."
fi

# If the user does not exist, create it
if [ -z "$EXISTING_USER" ]; then
	# Create the user with superuser privileges
	psql -c "CREATE ROLE $DB_USER WITH LOGIN PASSWORD '$DB_PASSWORD' SUPERUSER;"
fi
