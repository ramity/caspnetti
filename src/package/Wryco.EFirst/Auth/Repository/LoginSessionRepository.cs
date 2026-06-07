using Wryco.EFirst;
using Wryco.EFirst.Auth.Entity;

namespace Wryco.EFirst.Auth.Repository;

public class LoginSessionRepository : BaseRepository<LoginSession>
{
    public LoginSessionRepository(DbContext context) : base(context) { }
}
