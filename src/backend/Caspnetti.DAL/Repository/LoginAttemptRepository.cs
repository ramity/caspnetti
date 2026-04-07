using Caspnetti.DAL.Entity;

namespace Caspnetti.DAL.Repository;

public class LoginAttemptRepository : Repository<LoginAttempt>
{
    public LoginAttemptRepository(ApplicationDbContext context) : base(context) { }
}
