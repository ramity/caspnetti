using System.ComponentModel.DataAnnotations.Schema;
using Wryco.EFirst;

namespace Wryco.EFirst.Auth.Entity;

[Table("FilePointer")]
public class FilePointer: BaseIEntity
{
    public int Id { get; set; }
    public string? Name { get; set; }
    public string? AbsolutePath { get; set; }
    public string? Type { get; set; }
    public int? Size { get; set; }
    public DateTime? CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
