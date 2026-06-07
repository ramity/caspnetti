using System.ComponentModel.DataAnnotations.Schema;
using Wryco.EFirst;
using Wryco.EFirst.Auth.Entity;

namespace Wryco.EFirst.Auth.Entity;

[Table("User")]
public class User: IEntity
{
    public User()
    {
        CreatedAt = DateTime.UtcNow;
        UpdatedAt = DateTime.UtcNow;
    }

    // Main
    public int Id { get; set; }
    public required string Username { get; set; }
    public required string PasswordHash { get; set; }
    public required string DisplayName { get; set; }
    public string? Email { get; set; }

    // Meta
    public DateTime CreatedAt { get; set; } = DateTime.Now;
    public DateTime UpdatedAt { get; set; } = DateTime.Now;
    public DateTime LastActiveAt { get; set; } = DateTime.Now;

    // Navigation
    public FilePointer? Avatar { get; set; }
    public FilePointer? Banner { get; set; }
    public List<LoginAttempt>? LoginAttempts { get; set; }
    public List<LoginSession>? LoginSessions { get; set; }
}
