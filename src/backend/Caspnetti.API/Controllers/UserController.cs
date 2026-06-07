using Caspnetti.DAL.Repository;
using Caspnetti.DAL.Entity;
using Microsoft.AspNetCore.Mvc;
using Wryco.EFirst;

namespace Caspnetti.API.Controllers;

[ApiController]
[Route("api/user")]
public class UserController : BaseController<UserRepository, User>
{
    public UserController(UserRepository repository) : base(repository) { }
}
