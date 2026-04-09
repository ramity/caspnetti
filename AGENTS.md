# 🤖 Agent Instructions

## 1. Core Role & Principles
- **Primary Responsibility**: Implement backend/frontend features, maintain architectural consistency, write/run tests, and validate changes using provided scripts.
- **Design Paradigm**: **Thin Controller / Fat Service**.
- **Engineering Principles**: SOLID, Dependency Injection, Async/Await.

## 2. Environment & Architecture

### Infrastructure
- **Environment**: Docker-based development.
- **Key Containers**:
  - `caspnetti_aspnet_development`: ASP.NET 10 backend (Entry: `Program.cs`).
  - `caspnetti_vue_development`: Vue 3 + Vite frontend.
  - `caspnetti_mariadb_development`: MariaDB 11.8 database.
  - `caspnetti_nginx_development`: Nginx reverse proxy.
  - `caspnetti_adminer_development`: MariaDB GUI.

### Backend (`src/backend`)
- **Layers**:
  - `Caspnetti.API`: Controllers (extending `BaseController`/`BaseAuthController`), DTOs, OpenAPI.
  - `Caspnetti.Service`: Business logic (extending `UserService` or similar).
  - `Caspnetti.DAL`: Entity Framework Core, `ApplicationDbContext.cs`, `Repository<Entity>` (extending `IRepository`).
  - `Caspnetti.Test`: xUnit unit/integration tests.
- **Automation**: 
  - **Entity Scaffolding**: Use `./scripts/development/scaffold_entity.sh <EntityName>` to bootstrap new domain models, repositories, services, and controllers.

### Frontend (`src/frontend`)
- **Stack**: Vue 3 (Composition API), Vite, Vitest (Unit), Playwright (E2/E).
- **Communication**: API interaction via service layer (Axios/Fetch).

## 3. Task Execution Framework
Classify every task into one of the following modes and apply the corresponding workflow:

### Mode A: Trivial (e.g., Typos, simple config, documentation)
- **Workflow**: Direct implementation $\rightarrow$ Verify.

### Mode B: Standard (e.g., New CRUD entity, adding methods to existing services/repos)
- **Workflow**:
  1. **Validate/Understand**: Check existing patterns and files.
  2. **Implement**: Use scaffolding for new entities; modify existing files for extensions.
  3. **Test**: Add/update service/unit tests.
  4. **Build & Validate**: Run `./scripts/development/aspnet_build.sh` and `./scripts/development/vue_build.sh`.
  5. **Verify**: Ensure end-to-end functionality.

### Mode C: Complex (e.g., Refactoring, breaking changes, multi-component features)
- **Workflow**:
  1. **Plan**: Use `EnterPlanMode` to design the implementation strategy and identify impacts.
  2. **Execute**: Follow the **Mode B** workflow.

## 4. Rules & Constraints
- **Controller**: No business logic; strictly handles request/response and calls services.
- **Service**: Handles all business logic; must not access the database directly.
- **Repository**: Handles all database access/EF Core interactions.
- **Contract Integrity**: Do not break existing API contracts or repository interfaces without a documented plan.
- **Testing**: All changes must be accompanied by updated/new tests.

## 5. Definition of Done
A task is complete **ONLY** if:
- [ ] Code compiles successfully.
- [ ] All tests (Unit/Integration) pass.
- [ ] Docker services run without error.
- [ ] Feature is verified end-to-end.
- [ ] Architecture and "Rules & Constraints" are respected.
