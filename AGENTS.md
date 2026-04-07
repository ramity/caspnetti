# 🧠 `AGENTS.md`

## 1. Purpose

This agent is responsible for:

- Implementing backend and frontend features
- Maintaining architectural consistency
- Writing and running unit/integration tests
- Using provided build and utility scripts to validate changes
- Following the **thin controller / fat service** paradigm

## 2. Project Architecture Overview

### Purpose

- This project is intended to serve as a boilerplate for .NET 10 + Vue 3 applications.

### Overview

- This is a Docker-based development environment
- All code is run inside Docker containers
- Use the provided scripts to build and run the application

### Containers

These are the containers that you'll be working with:

caspnetti_adminer_development - Human-friendly MariaDB GUI
caspnetti_aspnet_development - ASP.NET 10 backend
caspnetti_mariadb_development - MariaDB 11.8 database
caspnetti_nginx_development - Nginx reverse proxy
caspnetti_vue_development - Vue 3 frontend

Your efforts will be focused on the development containers. There are production containers and scripts as well, easily identifiable by the `_production` suffix. There may be a time when you're asked to work on the production containers, but that will be rare. When not specified, it's safe to assume you're working on the development containers.

### Backend (ASP.NET)

Host file path: `src/backend` (relative to project root)
Container caspnetti_aspnet_development file path: `/caspnetti` (absolute path)

The backend is a .NET 10 web application that uses Entity Framework Core for data access and MariaDB for the database. Entity framework is at the core of what makes this setup so powerful, with code first entity definitions and migrations, generating SQL is a breeze. The backend is split into four projects:

Caspnetti.API
- Assets/
- Controllers/
- DTO/
- Program.cs

Caspnetti.DAL
- Entity/
- Migrations/
- Repository/
- ApplicationDbContext.cs
- IEntity.cs
- IRepository.cs
- Repository.cs

Caspnetti.Service
- UserService.cs

Caspnetti.Test
- UnitTest1.cs

Caspnetti.API/Program.cs is the API entry point. It is responsible for configuring the API and registering the services.
The backend follows the thin controller / fat service paradigm and makes heavy use of inheritance.

Controllers commonly extend `BaseController` or `BaseAuthController`. These base classes provide typical api endpoints for a given entity, such as:
  - index: GET all entities
  - show: GET entity by ID
  - create: POST entity
  - update: PUT entity
  - delete: DELETE entity

Repositories commonly extend `Repository<Entity>`. This base class provides typical repository methods for a given entity, such as:
  - FindAll
  - FindById
  - Add
  - Update
  - Delete
  - Save

Because of the way the backend is built, entities are the core of the backend. It's very easy to be able to quickly create a new entity, create a repository for that entity, create a controller for accessing that entity, and boom, you have a new CRUD API with complete functionality for that entity. You can also easily add new functionality to an existing entity by adding a new method to the specific repository, a new method to the service, and a new endpoint/method to the controller.

Here are some things to keep in mind:

- Controllers do not contain business logic
- Services capture business logic
- Controllers never directly access a repository
- Services call repository methods to get/update data
- Services and repositories are registered via dependency injection in `Program.cs`

High level request to response flow: Controller handles request, calls service, calls a repository, which populates data relating to an entity that is mapped to a table in the database, data bubbles back up the chain, and the controller returns the response.

### Frontend (Vue + Vite)

Host file path: `src/frontend` (relative to project root)
Container caspnetti_vue_development file path: `/caspnetti` (absolute path)

- Vue components handle UI
- API communication via service layer (axios/fetch)
- Built and served with Vite

## 3. Agent Workflow

Below is a suggested workflow for implementing a given unit of work. The user may specify a different workflow, and this may be overkill for simple tasks, but it's a good starting point.

Prepare subagents for each of the following steps:

0. Validate Task
1. Understand Task
2. Implement Backend
3. Write Backend Tests
4. Build & Validate
5. Verify Integration

"validate, understand, implement, test, build, validate, verify"

### Step 0: Validate Task

The user is there for you. <3 If you like building software that makes two of us. Ask the user if you need clarification, but try to do it up front. The user can be forgetful and may omit necessary context or details they may consider unspoken. It's better to ask than to assume. That said, try to be efficient and not waste the user's time with unnecessary questions.

Before implementing the task, you should use your tools to validate the task is valid. It's too easy to validate than to fix a mistake assuming the user is correct. You should look for these files if you need context or a pattern to follow for new entities.

### Step 1: Understand Task

In most cases the task will read like a user story or list of tasks, so you'll need to break it down into smaller tasks. For example, if the task is "Create a new entity", you'll need to create the entity, create a repository for that entity, create a controller for accessing that entity, and boom, you have a new CRUD API with complete functionality for that entity. You can also easily add new functionality to an existing entity by adding a new method to the specific repository, a new method to the service, and a new endpoint/method to the controller.

It's important that you don't reimplement logic that already exists. For example, if the task is to add a new method to an existing repository, you should find the existing repository and add the new method there. Don't create a new repository for the new method. The same applies to services and controllers.

A well thought out task will include:

- The entity/domain involved
- The functionality to be added
- Any constraints or requirements
- Any examples of similar functionality

Many times, user requests will be sourced from github issues. As such, the user may not provide a complete task description. Maybe the user references code not yet in main for example. In these cases, you should use your tools to validate the user's request is valid. It's too easy to validate than to fix a mistake assuming the user is correct. You should look for these files if you need context or a pattern to follow for new entities.

Additionally, you should always be considering the entity first mental model of the codebase. Entity is the core, wrapped by repository, accessible via a service, made invokable by the controller.

### Step 2: Implement Backend

Is this a new feature or an existing feature? If it's an existing feature, you should look for the existing entity, repository, and service and add the new functionality in the correct location. If it's a new feature, you should create a new entity, repository, service, and controller as needed.

### Step 3: Write Backend Tests

- Add/update service tests
- Ensure logic is validated

### Step 4: Build & Validate

Leverage the available scripts to build and validate the backend.

./scripts/development/aspnet_build.sh
./scripts/development/vue_build.sh

### Step 5: Verify Integration

- No runtime errors
- No compilation errors
- Ensure the user's goal is completed

## 4. Rules & Constraints

### Architecture Rules

- No business logic in controllers
- Services handle business logic
- No direct DB access from services
- Repositories handle DB access

### Code Quality

- Follow SOLID principles
- Use dependency injection
- Prefer async/await

## 5. Agent Memory Guidelines

The agent should remember:

- Existing controllers, entities, repositories, and services
- Naming conventions already used
- Use of base classes when appropriate

## 6. Safe Modification Strategy

When modifying existing code:

1. Locate all references
2. Avoid breaking API contracts
3. Update tests accordingly
4. Rebuild + retest

## 7. Definition of Done

A task is complete ONLY if:

- ✅ Code compiles
- ✅ Tests pass
- ✅ Docker services run without errors
- ✅ Feature works end-to-end
- ✅ Follows architecture rules

## 8. Optional Enhancements

Agent may also:

- Refactor duplicated logic into services
- Suggest performance improvements
- Add missing tests
- Improve type safety
