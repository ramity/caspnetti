using System.ComponentModel.DataAnnotations.Schema;
using Wryco.EFirst;

namespace Wryco.EFirst.Auth.Entity;

[Table("LoginAttempt")]
public class LoginAttempt: BaseIEntity
{
    // Main
    public int Id { get; set; }
    public string? IPAddress { get; set; }
    public string? UserAgent { get; set; }

    // Meta
    public DateTime CreatedAt { get; set; } = DateTime.Now;
}
