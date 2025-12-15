#!/bin/bash -e

# Em ambiente de produção, garanta que o banco de dados esteja pronto e migrado.
if [ "$RAILS_ENV" = "production" ]; then
  echo "Waiting for database to be ready..."
  until bin/rails db:version > /dev/null 2>&1; do
    sleep 1
  done
  echo "Database is ready."

  echo "Running database migrations..."
  bin/rails db:prepare
  echo "Database migrations finished."
fi

exec "${@}"
