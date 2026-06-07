using Wryco.EFirst.Auth.Entity;

namespace Wryco.EFirst.Auth.Repository;

public class UserRepository : Repository<User>
{
    public UserRepository(ApplicationDbContext context) : base(context) { }
}
