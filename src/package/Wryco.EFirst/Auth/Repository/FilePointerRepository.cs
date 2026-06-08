using Microsoft.EntityFrameworkCore;
using Wryco.EFirst;
using Wryco.EFirst.Auth.Entity;

namespace Wryco.EFirst.Auth.Repository;

public class FilePointerRepository: BaseRepository<FilePointer>
{
    public FilePointerRepository(BaseDbContext context) : base(context) { }
}
