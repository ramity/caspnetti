using Caspnetti.DAL.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Wryco.EFirst;
using Wryco.EFirst.Auth.Entity;

namespace Caspnetti.DAL;

public class ApplicationDbContext : BaseDbContext
{
    // public ApplicationDbContext(){}

    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options): base(options){}

    public DbSet<Device> Device { get; set; } = null!;

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
