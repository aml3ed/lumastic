#!/bin/bash
docker-compose -f docker-compose-prod.yml down
git pull
docker-compose -f docker-compose-prod.yml build
docker-compose -f docker-compose-prod.yml run web rails db:migrate
docker-compose -f docker-compose-prod.yml up -d