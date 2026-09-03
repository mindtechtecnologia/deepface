#!/usr/bin/env sh
set -e

echo "Starting the application..."

# If a non-empty command was passed (docker run / compose `command:`), run it.
# Otherwise start the API with gunicorn.
if [ "$#" -gt 0 ] && [ -n "$1" ]; then
    exec "$@"
fi

exec gunicorn --workers=1 --timeout=7200 --bind=0.0.0.0:5000 --log-level=debug --access-logformat='%(h)s - - [%(t)s] "%(r)s" %(s)s %(b)s %(L)s' --access-logfile=- "app:create_app()"
