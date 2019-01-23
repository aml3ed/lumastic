#!/usr/bin/env bash
docker build --build-arg secret_key_base=${@} -f Dockerfile.prod -t registry.heroku.com/lumastic-dev/web:latest .

