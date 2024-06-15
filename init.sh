#!/bin/bash
set -o allexport
source .env
set +o allexport

cd scripts

./create_db.sh
./create_admin_user.sh
./create_tables.sh

./run_example.sh

