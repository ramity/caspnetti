using Caspnetti.DAL.Entity;
using Wryco.EFirst;

namespace Caspnetti.DAL.Repository;

public class DeviceRepository: BaseRepository<Device>
{
    public DeviceRepository(ApplicationDbContext context) : base(context) { }
}
