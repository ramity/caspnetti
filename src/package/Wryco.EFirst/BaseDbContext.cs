using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Wryco.EFirst.Auth.Entity;

namespace Wryco.EFirst;

public abstract class BaseDbContext : DbContext
{
    public BaseDbContext(){}
    // public BaseDbContext(DbContextOptions options) : base(options) { }
    public BaseDbContext(DbContextOptions options): base(options){}

    public DbSet<FilePointer> FilePointer { get; set; } = null!;
    public DbSet<LoginAttempt> LoginAttempt { get; set; } = null!;
    public DbSet<LoginSession> LoginSession { get; set; } = null!;
    public DbSet<User> User { get; set; } = null!;

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
    }
}
