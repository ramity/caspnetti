using Microsoft.EntityFrameworkCore;
using Wryco.EFirst;
using Wryco.EFirst.Auth.Entity;

namespace Wryco.EFirst.Auth.Repository;

public class LoginSessionRepository : BaseRepository<LoginSession>
{
    public LoginSessionRepository(BaseDbContext context) : base(context) { }
}
