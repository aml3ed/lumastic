#!/usr/bin/env bash
docker build --build-arg secret_key_base=${@} -f Dockerfile.prod -t registry.heroku.com/lumastic-dev/web .
docker push registry.heroku.com/lumastic-dev/web
heroku container:release web --app lumastic-dev