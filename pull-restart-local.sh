#!/bin/bash
docker-compose down
rm /lumastic/tmp/pids/server.pid -y
git pull
docker-compose build
docker-compose up -d