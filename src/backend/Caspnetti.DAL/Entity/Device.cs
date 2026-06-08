using System.ComponentModel.DataAnnotations.Schema;
using Wryco.EFirst;

namespace Caspnetti.DAL.Entity;

[Table("Device")]
public class Device: BaseIEntity
{
    public Device()
    {
        CreatedAt = DateTime.UtcNow;
        UpdatedAt = DateTime.UtcNow;
    }

    // Main
    public int Id { get; set; }
    public required string Name { get; set; }

    // Meta
    public DateTime CreatedAt { get; set; } = DateTime.Now;
    public DateTime UpdatedAt { get; set; } = DateTime.Now;
    public DateTime LastActiveAt { get; set; } = DateTime.Now;
}
