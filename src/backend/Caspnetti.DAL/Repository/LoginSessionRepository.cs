using Caspnetti.DAL.Entity;

namespace Caspnetti.DAL.Repository;

public class LoginSessionRepository: Repository<LoginSession>
{
    public LoginSessionRepository(ApplicationDbContext context) : base(context) { }
}
