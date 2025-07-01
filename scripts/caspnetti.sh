#!/bin/bash

CASPNETTI_VERSION="0.1"

###################
# Utility functions
###################

print_input() {
  read response
  echo "$response"
}

print_root_help() {
  echo "usage: $(basename "$0")"
  echo ""
  echo "These are common Caspnetti commands used in various situations:"
  echo ""
  echo ""
  echo "  --project <name>   Specify the project name"
  echo "  -h, --help         Show this help message and exit"
  echo ""
  echo "Example:"
  echo "  $(basename "$0") --project my-app"
}

################################
# Calculate directory/file paths
################################

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLI_PATH="$(cd "$(dirname ".")" && pwd)"
ENV_PATH="$SCRIPT_PATH/.env"
ENV_LOCAL_PATH="$SCRIPT_PATH/.env.local"
ROOT_PATH="$SCRIPT_PATH/../"
DOCKER_PATH="$ROOT_PATH/docker"

#################################################################
# Prepare .env.local functionality and verify required parameters
#################################################################

# We assume the lack of a .env.local file is equivalent to a first time execution.
# Interactively ask the user if they want to copy .env defaults to .env.local.

if [ ! -f $ENV_LOCAL_PATH ]; then

  echo "First time execution detected."
  
  # Make sure that the default env file exists. If it does not, exit execution.
  # In the future this will be sourced remotely from a release system that does not presently exist.
  # This script may also be externalized into its own repo if it becomes sufficiently complex.

  if [ ! -f $ENV_PATH ]; then
    echo "$ENV_PATH was not detected\nExiting..."
    exit 1
  fi

  echo "$ENV_LOCAL_PATH was not detected"
  echo "Would you like to copy the defaults from $ENV_PATH? (y/n)"
  selection=$(print_input)

  if [[ $selection == "y" || $selection == "Y" ]]; then
    cp $ENV_PATH $ENV_LOCAL_PATH
  else
    # TODO: pull file from remote source
    touch $ENV_LOCAL_PATH
  fi
fi

# Check for existence of ENV variable and make sure it is also not empty

if grep -q '^ENV=[^[:space:]]' $ENV_LOCAL_PATH; then
  if DEBUG then
    echo "ENV is set and not empty"
  fi 
else
  echo "ENV is empty"
  exit 1
fi

# Load variables into bash context line by line

while IFS='=' read -r key value; do
  if [[ ! $key =~ ^# && $key != "" ]]; then
    # echo "$key $value"
    export "$key"="$value"
  fi
done < $ENV_LOCAL_PATH

####################################################
# Non interactive logic, handle user input arguments
####################################################

a="$1"
b="$2"
c="$3"
d="$4"

# caspnetti

if [[ -z "$a" && -z "$b" && -z "$c" && -z "$d" ]]; then
  print_root_help
  exit 0
fi

# caspnetti help

if [[ "$a" == "help" && -z "$b" && -z "$c" && -z "$d" ]]; then
  print_root_help
  exit 0
fi

# caspnetti context create $name $url

if [[ "$a" == "context" && "$b" == "create" && -n "$c" && -n "$d" ]]; then
  # TODO: Validate context does not already exist prior to running
  docker context create "$c" --docker host=$d
  exit 1
fi

# caspnetti context development

if [[ "$a" == "context" && "$b" == "development" && -z "$c" && -z "$d" ]]; then
  # Change ENV var to development
  sed -i 's/^ENV=.*/ENV=development/' "$ENV_LOCAL_PATH"
  # Switch to development
  docker context use $DEVELOPMENT_CONTEXT
  exit 1
fi

# caspnetti context production

if [[ "$a" == "context" && "$b" == "production" && -z "$c" && -z "$d" ]]; then
  # Change ENV var to production
  sed -i 's/^ENV=.*/ENV=production/' "$ENV_LOCAL_PATH"
  # Switch to production
  docker context use $PRODUCTION_CONTEXT
  exit 1
fi

# caspnetti context $environment_name $environment_context

if [[ "$a" == "context" && -n "$b" && -n "$c" && -z "$d" ]]; then
  # Change ENV var to $b
  sed -i 's/^ENV=.*/ENV='$b'/' "$ENV_LOCAL_PATH"
  # Change context to $c
  docker context use $c
  exit 1
fi

# caspnetti env default

if [[ "$a" == "context" && -n "$b" && -n "$c" && -z "$d" ]]; then
  # Prevent overwriting existing .local files
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

  echo ".env.local files created"
  echo "Environment is now ready for docker operations"
  echo "Be aware that exposing services using default .env values is a security risk"

  exit 1
fi

# caspnetti dotnet build

if [[ "$a" == "context" && "$b" == "dotnet" && "$c" == "build" && -z "$d" ]]; then

  if [ $ENV == "development" ]; then
    docker exec -t caspnetti_backend bash -c "dotnet build"
    exit 1
  elif [ $ENV == "production" ]; then
    docker exec -t caspnetti_backend bash -c "dotnet publish -c Release -o /publish"
    exit 1
  fi

fi

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
