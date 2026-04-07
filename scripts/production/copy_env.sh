#!/bin/bash

# Copy default .env if .env.local does not already exist for all services:
cp -n docker/production/adminer/.env docker/production/adminer/.env.local
cp -n docker/production/aspnet/.env docker/production/aspnet/.env.local
cp -n docker/production/mariadb/.env docker/production/mariadb/.env.local
cp -n docker/production/nginx/caspnetti-ssl.conf docker/production/nginx/caspnetti-ssl.conf.local
cp -n docker/production/nginx/caspnetti.conf docker/production/nginx/caspnetti.conf.local
cp -n docker/production/vue/.env docker/production/vue/.env.local
