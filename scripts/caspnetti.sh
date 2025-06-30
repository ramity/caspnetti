#!/bin/bash

################################
# Calculate directory/file paths
################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env.local"
ROOT_DIR="$SCRIPT_DIR/../"
DOCKER_DIR="$ROOT_DIR/docker"

##################################################################
# Validate .env.local functionality and verify required parameters
##################################################################

# Check for existence of ENV var

if grep -q '^ENV=' $ENV_FILE; then
  echo "ENV is present"
else
  echo "ENV is missing"
  exit 1
fi

# Check for existence of ENV var and make sure it is also not empty

if grep -q '^ENV=[^[:space:]]' $ENV_FILE; then
  echo "ENV is set and not empty"
else
  echo "ENV is missing or empty"
  exit 1
fi

# Load variables into bash context line by line

while IFS='=' read -r key value; do
  if [[ ! $key =~ ^# && $key != "" ]]; then
    # echo "$key $value"
    export "$key"="$value"
  fi
done < $ENV_FILE

###################
# Utility functions
###################

print_input() {
    local prompt="$1"
    read -p "$prompt" response
    echo "$response"
}

print_help() {
    echo "Usage: $(basename "$0") [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --project <name>   Specify the project name"
    echo "  -h, --help         Show this help message and exit"
    echo ""
    echo "Example:"
    echo "  $(basename "$0") --project my-app"
}

####################################################
# Non interactive logic, handle user input arguments
####################################################

a="$1"
b="$2"
c="$3"
d="$4"

# caspnetti

if [[ -z "$a" && -z "$b" && -z "$c" && -z "$d" ]]; then
    print_help
    exit 0
fi

# caspnetti help

if [[ "$a" == "help" && -z "$b" && -z "$c" && -z "$d" ]]; then
    print_help
    exit 0
fi

# caspnetti context create $name $url

if [[ "$a" == "context" && "$b" == "create" && -n "$c" && -n "$d" ]]; then
    docker context create "$c" --docker host=$d
    exit 1
fi

# caspnetti context development

if [[ "$a" == "context" && "$b" == "development" && -z "$c" && -z "$d" ]]; then
    # Change ENV var to development
    sed -i 's/^ENV=.*/ENV=development/' "$ENV_FILE"
    # Switch to development
    docker context use $DEVELOPMENT_CONTEXT
    exit 1
fi

# caspnetti context production

if [[ "$a" == "context" && "$b" == "production" && -z "$c" && -z "$d" ]]; then
    # Change ENV var to production
    sed -i 's/^ENV=.*/ENV=production/' "$ENV_FILE"
    # Switch to production
    docker context use $PRODUCTION_CONTEXT
    exit 1
fi

# caspnetti context $environment_name $environment_context

if [[ "$a" == "context" && -n "$b" && -n "$c" && -z "$d" ]]; then
    # Change ENV var to $b
    sed -i 's/^ENV=.*/ENV='$b'/' "$ENV_FILE"
    # Change context to $c
    docker context use $c
    exit 1
fi



# ---

# caspnetti env default

cp -n $DOCKER_DIR/adminer/.env $DOCKER_DIR/adminer/.env.local
cp -n $DOCKER_DIR/aspnet_development/.env $DOCKER_DIR/aspnet_development/.env.local
cp -n $DOCKER_DIR/aspnet_production/.env $DOCKER_DIR/aspnet_production/.env.local
cp -n $DOCKER_DIR/mssql/.env $DOCKER_DIR/mssql/.env.local
cp -n $DOCKER_DIR/nginx_development/caspnetti-ssl.conf $DOCKER_DIR/nginx_development/caspnetti-ssl.conf.local
cp -n $DOCKER_DIR/nginx_development/caspnetti.conf $DOCKER_DIR/nginx_development/caspnetti.conf.local
cp -n $DOCKER_DIR/nginx_production/caspnetti-ssl.conf $DOCKER_DIR/nginx_production/caspnetti-ssl.conf.local
cp -n $DOCKER_DIR/nginx_production/caspnetti.conf $DOCKER_DIR/nginx_production/caspnetti.conf.local
cp -n $DOCKER_DIR/vue_development/.env $DOCKER_DIR/vue_development/.env.local
cp -n $DOCKER_DIR/vue_production/.env $DOCKER_DIR/vue_production/.env.local

# caspnetti env destroy

# caspnetti dotnet build
# - dev "dotnet build"
# - prod "dotnet publish -c Release -o /publish"

# caspnetti dotnet server
# - dev "dotnet run --project Caspnetti.API"
# - prod docker exec -t caspnetti_api bash -c "dotnet Caspnetti.API.dll"

# caspnetti dotnet database drop
# - dotnet ef database drop --project Caspnetti.API

# caspnetti dotnet migrations add descriptive_name_goes_here

# caspnetti dotnet database update
# - dotnet ef database update --project Caspnetti.API

# caspnetti vue build
# caspnetti vue build
# caspnetti vue server
# caspnetti vue server

# caspnetti deploy start
# caspnetti deploy stop
# caspnetti deploy recreate
# caspnetti deploy destroy
