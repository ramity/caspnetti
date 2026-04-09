#!/bin/bash

docker compose -f docker/development/docker-compose.yml down --rmi --volumes

# Remove .env.local files for all services:
rm docker/development/adminer/.env.local
rm docker/development/aspnet/.env.local
rm docker/development/mariadb/.env.local
rm docker/development/nginx/caspnetti-ssl.conf.local
rm docker/development/nginx/caspnetti.conf.local
rm docker/development/vue/.env.local
