#!/bin/bash

# Remove .env.local files for all services:
rm docker/production/adminer/.env.local
rm docker/production/aspnet/.env.local
rm docker/production/mariadb/.env.local
rm docker/production/nginx/caspnetti-ssl.conf.local
rm docker/production/nginx/caspnetti.conf.local
rm docker/production/vue/.env.local
