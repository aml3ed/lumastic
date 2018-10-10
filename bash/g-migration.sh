#!/bin/bash
docker-compose run web rails g migration $@
