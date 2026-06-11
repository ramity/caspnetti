using Caspnetti.DAL;
using Caspnetti.DAL.Entity;
using Caspnetti.DAL.Repository;
using Microsoft.AspNetCore.Mvc;
using Wryco.EFirst;

namespace Caspnetti.API.Controllers;

[ApiController]
[Route("api/device")]
public class DeviceController : BaseController<DeviceRepository, Device>
{
    public DeviceController(DeviceRepository repository) : base(repository) { }
}
