#!/bin/bash

echo "---------------------------------------------------------------------"
pwd
echo "looking for postgres data directory"
if [ -d "$(pwd)/postgres_db_data" ]; then
  echo "postgres_db_data directory exists, postgres will use existing data"
else
  echo "postgres_db_data directory not found, trying to create directory, postgres will be empty"
  mkdir $(pwd)/postgres_db_data
fi
echo "starting docker postgres...."
echo "---------------------------------------------------------------------"
docker run --rm -p5432:5432 -v $(pwd)/postgres_db_data:/var/lib/postgresql/data postgres

#EOF
