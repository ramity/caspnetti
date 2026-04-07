using Caspnetti.DAL.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace Caspnetti.DAL;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(){}

    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options): base(options){}

    public DbSet<FilePointer> FilePointers { get; set; } = null!;
    public DbSet<LoginAttempt> LoginAttempts { get; set; } = null!;
    public DbSet<LoginSession> LoginSessions { get; set; } = null!;
    public DbSet<User> Users { get; set; } = null!;

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        // if (!optionsBuilder.IsConfigured)
        // {
        //     // Build configuration from appsettings.json
        //     var config = new ConfigurationBuilder()
        //         .SetBasePath(Path.Combine(Directory.GetCurrentDirectory(), "../Caspnetti.API"))
        //         .AddJsonFile("appsettings.json")
        //         .Build();

        //     var connectionString = config.GetConnectionString("MariaDBConnection");
        //     optionsBuilder.UseSqlServer(connectionString);
        // }
    }
}
