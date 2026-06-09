using Microsoft.EntityFrameworkCore;
using Wryco.EFirst;
using Wryco.EFirst.Auth.Entity;

namespace Wryco.EFirst.Auth.Repository;

public class UserRepository : BaseRepository<User>
{
    public UserRepository(BaseDbContext context) : base(context) { }
}
