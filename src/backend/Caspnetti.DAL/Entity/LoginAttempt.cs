using System.ComponentModel.DataAnnotations.Schema;

namespace Caspnetti.DAL.Entity;

[Table("LoginAttempt")]
public class LoginAttempt: IEntity
{
    // Main
    public int Id { get; set; }
    public string? IPAddress { get; set; }
    public string? UserAgent { get; set; }

    // Meta
    public DateTime CreatedAt { get; set; } = DateTime.Now;
}
