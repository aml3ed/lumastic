#!/usr/bin/env bash
docker build --build-arg secret_key_base=${@} -f Dockerfile.prod -t registry.heroku.com/lumastic/web .
docker push registry.heroku.com/lumastic/web
heroku container:release web --app lumastic
