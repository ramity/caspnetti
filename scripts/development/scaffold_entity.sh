#!/bin/bash

# Usage: ./scaffold_entity.sh <EntityName>

ENTITY_NAME=$1

if [ -z "$ENTITY_NAME" ]; then
    echo "Usage: $0 <EntityName>"
    exit 1
fi

# Prepare class name (capitalize first letter)
CLASS_NAME="$(echo $ENTITY_NAME | sed 's/./\U&/')"
TABLE_NAME="${CLASS_NAME}s"

# Paths
PROJECT_ROOT="/caspnetti"
DAL_ENTITY_DIR="$PROJECT_ROOT/src/backend/Caspnetti.DAL/Entity"
DAL_REPO_DIR="$PROJECT_ROOT/src/backend/Caspnetti.DAL/Repository"
DAL_CONTEXT_FILE="$PROJECT_ROOT/src/backend/Caspnetti.DAL/ApplicationDbContext.cs"
SERVICE_DIR="$PROJECT_ROOT/src/backend/Caspnetti.Service"
API_CONTROLLER_DIR="$PROJECT_ROOT/src/backend/Caspnetti.API/Controllers"

echo "🚀 Starting scaffolding for entity: $CLASS_NAME"

# 1. Create Entity
ENTITY_FILE="$DAL_ENTITY_DIR/$CLASS_NAME.cs"
cat <<EOF > "$ENTITY_FILE"
using System.ComponentModel.DataAnnotations.Schema;
using Caspnetti.DAL;

namespace Caspnetti.DAL.Entity;

[Table("$TABLE_NAME")]
public class $CLASS_NAME : IEntity
{
    public $CLASS_NAME()
    {
        CreatedAt = DateTime.UtcNow;
        UpdatedAt = DateTime.UtcNow;
    }

    public int Id { get; set; }

    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
}
EOF
echo "  - Created Entity: $ENTITY_FILE"

# 2. Update DbContext
if [[ ! -f "$DAL_CONTEXT_FILE" ]]; then
    echo "Error: File $DAL_CONTEXT_FILE not found."
    exit 1
fi
NEW_LINE="    public DbSet<$CLASS_NAME> $TABLE_NAME { get; set; } = null!;";
if grep -q "DbSet" "$DAL_CONTEXT_FILE"; then
    temp_file=$(mktemp)
    last_idx=$(grep -n "DbSet" "$DAL_CONTEXT_FILE" | tail -n 1 | cut -d: -f1)
    sed "${last_idx}a\\$NEW_LINE" "$DAL_CONTEXT_FILE" > "$temp_file" && mv "$temp_file" "$DAL_CONTEXT_FILE"
    echo "Added DbSet after line $last_idx"
else
    echo "Error: No existing DbSet found in $DAL_CONTEXT_FILE."
    exit 1
fi

# 3. Create Repository
REPO_FILE="$DAL_REPO_DIR/${CLASS_NAME}Repository.cs"
cat <<EOF > "$REPO_FILE"
using Caspnetti.DAL.Entity;

namespace Caspnetti.DAL.Repository;

public class ${CLASS_NAME}Repository: Repository<${CLASS_NAME}>
{
    public ${CLASS_NAME}Repository(ApplicationDbContext context) : base(context) { }
}
EOF
echo "  - Created Repository: $REPO_FILE"

# 4. Create Service
SERVICE_FILE="$SERVICE_DIR/${CLASS_NAME}Service.cs"
cat <<EOF > "$SERVICE_FILE"
using Caspnetti.DAL.Entity;
using Caspnetti.DAL.Repository;

namespace Caspnetti.Service;

public class ${CLASS_NAME}Service
{
    private readonly ${CLASS_NAME}Repository _repository;

    public ${CLASS_NAME}Service(${CLASS_NAME}Repository repository)
    {
        _repository = repository;
    }
}
EOF
echo "  - Created Service: $SERVICE_FILE"

# 5. Create Controller
CONTROLLER_FILE="$API_CONTROLLER_DIR/${CLASS_NAME}Controller.cs"
ROUTE_NAME=$(echo "$CLASS_NAME" | tr '[:upper:]' '[:lower:]')

cat <<EOF > "$CONTROLLER_FILE"
using Caspnetti.DAL.Repository;
using Caspnetti.DAL.Entity;
using Microsoft.AspNetCore.Mvc;

namespace Caspnetti.API.Controllers;

[ApiController]
[Route("api/$ROUTE_NAME")]
public class ${CLASS_NAME}Controller : BaseController<${CLASS_NAME}Repository, $CLASS_NAME>
{
    public ${CLASS_NAME}Controller(${CLASS_NAME}Repository repository) : base(repository) { }
}
EOF
echo "  - Created Controller: $CONTROLLER_FILE"

echo "✅ Successfully scaffolded $CLASS_NAME!"
