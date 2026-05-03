using System.ComponentModel.DataAnnotations.Schema;

namespace Caspnetti.DAL.Entity;

[Table("FilePointer")]
public class FilePointer: IEntity
{
    public int Id { get; set; }
    public string? Name { get; set; }
    public string? AbsolutePath { get; set; }
    public string? Type { get; set; }
    public int? Size { get; set; }
    public DateTime? CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
