using Microsoft.EntityFrameworkCore;
using Wryco.EFirst;
using Wryco.EFirst.Auth.Entity;

namespace Wryco.EFirst.Auth.Repository;

public class LoginAttemptRepository : BaseRepository<LoginAttempt>
{
    public LoginAttemptRepository(BaseDbContext context) : base(context) { }
}
