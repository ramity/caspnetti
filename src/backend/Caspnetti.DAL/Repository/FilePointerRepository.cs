using Caspnetti.DAL.Entity;

namespace Caspnetti.DAL.Repository;

public class FilePointerRepository: Repository<FilePointer>
{
    public FilePointerRepository(ApplicationDbContext context) : base(context) { }
}
