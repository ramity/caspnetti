using Wryco.EFirst;
using Wryco.EFirst.Auth.Entity;

namespace Wryco.EFirst.Auth.Repository;

public class LoginAttemptRepository : BaseRepository<LoginAttempt, TContext>
{
    public LoginAttemptRepository(DbContext context) : base(context) { }
}
