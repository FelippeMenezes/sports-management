#!/bin/bash -e

# In a production environment, we need to ensure the database is ready and migrated.
# This runs for both the web and worker services.
if [ "$RAILS_ENV" = "production" ]; then
  echo "Production environment detected. Preparing database..."
  bin/rails db:prepare
  echo "Database is ready."
fi

# If the first argument is "sidekiq", prepend "bundle exec"
# This allows us to run "sidekiq" as the command in our worker service on Koyeb.
if [ "$1" = "sidekiq" ]; then
  set -- bundle exec sidekiq "$@"
fi

exec "${@}"
