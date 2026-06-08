using Wryco.EFirst;
using Wryco.EFirst.Auth.Repository;
using Wryco.EFirst.Auth.Service;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace Wryco.EFirst.Extensions;

public static class ServiceExtensions
{
    /// <summary>
    /// Registers base infrastructure, including the DbContext and shared services.
    /// Uses a generic constraint to ensure the TContext is a child of BaseDbContext.
    /// </summary>
    public static IServiceCollection AddSharedInfrastructure<TContext>(
        this IServiceCollection services, 
        string connectionString) where TContext : BaseDbContext
    {
        // 1. Register the specific DbContext type requested by the API
        services.AddDbContext<TContext>(options =>
            options.UseMySql(connectionString, new MySqlServerVersion(new Version(10, 11, 15)))
        );

        // 2. Register the base context as an alias so shared services can use it
        services.AddScoped<BaseDbContext>(provider => 
            provider.GetRequiredService<TContext>());

        // 3. Register shared services (e.g., Auth services, Repositories)
        services.AddScoped<UserRepository>();
        services.AddScoped<LoginSessionRepository>();
        services.AddScoped<LoginAttemptRepository>();
        services.AddScoped<FilePointerRepository>();
        
        return services;
    }
}
