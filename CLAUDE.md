# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build and Test Commands

### Note on docker
This project uses docker for development and uses a series of containers to run the application. Below are the most relevant containers:

- caspnetti_aspnet_development: The backend container.
- caspnetti_mariadb_development: The database container.
- caspnetti_vue_development: The frontend container.
- caspnetti_nginx_development: The reverse proxy container.
- caspnetti_adminer_development: The database admin container.

You, the agent, run within your own docker container:

- caspnetti_agent_development: The agent container. That's you!
- caspnetti_agent_ui_development: The agent ui container.

The caspnetti_agent_development container has been given access to the docker daemon via a volume mount. This is so that you can start and stop other containers.

You may also note that there are production and test docker compose containers and files that can be used to run the application in different environments.

### Backend (.NET)
The backend is a .NET solution consisting of an API, Service layer, and Data Access Layer (DAL).
- **Build the entire solution**:
```sh
docker exec -t caspnetti_aspnet_development sh -c "dotnet build Caspnetti.sln"
```
- **Run all tests**:
```sh
docker exec -t caspnetti_aspnet_development sh -c "dotnet test Caspnetti.sln"
```
- **Run a specific test**:
```sh
docker exec -t caspnetti_aspnet_development sh -c "dotnet test Caspnetti.sln --filter Name=YourTestName"
```
- **Run development server**:

NOTE: The development server is already running in the caspnetti_aspnet_development container.

### Frontend (Vue 3 + Vite)
The frontend is a Vue 3 application built with Vite.

- **Install dependencies**:
```sh
docker exec -t caspnetti_vue_development sh -c "npm install"
```
- **Run development server**:

NOTE: The development server is already running in the caspnetti_vue_development container.

- **Build for production**:
```sh
docker exec -t caspnetti_vue_development sh -c "npm run build"
```
- **Run unit tests (Vitest)**:
```sh
docker exec -t caspnetti_vue_development sh -c "npm run test:unit"
```
- **Run end-to-end tests (Playwright)**:
```sh
docker exec -t caspnetti_vue_development sh -c "npm run test:e2e"
```
- **Lint code**:
```sh
docker exec -t caspnetti_vue_development sh -c "npm run lint"
```

## Architecture Overview

### Backend Architecture
The backend follows a layered architecture:

- **Caspnetti.API**: The entry point. Contains ASP.NET Core Controllers, DTOs, and API configuration. It uses OpenAPI for documentation.
- **Caspnetti.Service**: The business logic layer. Contains service implementations (e.g., `UserService.cs`) that orchestrate domain logic.
- **Caspnetti.DAL (Data Access Layer)**: Handles data persistence. Uses Entity Framework Core with `ApplicationDbContext`. It implements the Repository pattern (`IRepository.cs`, `Repository.cs`) and defines entities.
- **Caspnetti.Test**: The test suite using xUnit for unit and integration testing.

### Frontend Architecture
A modern Vue 3 application using the Composition API and Vite.

- **Components**: Vue SFCs (Single File Components).
- **Testing**: Vitest for unit testing and Playwright for E2E testing.
- **Tooling**: ESLint for linting and Volar for TypeScript support in `.vue` files.

### Line Endings
LF

### Encoding
UTF-8
