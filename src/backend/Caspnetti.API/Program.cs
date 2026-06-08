using Wryco.EFirst;
using Wryco.EFirst.Extensions;
using Wryco.EFirst.Auth.Entity;
using Wryco.EFirst.Auth.Repository;
using Wryco.EFirst.Auth.Service;
using Caspnetti.DAL;
using Caspnetti.DAL.Repository;
using Microsoft.EntityFrameworkCore;
using System.IO;

var builder = WebApplication.CreateBuilder(args);

// MariaDB initialization
string? username = Environment.GetEnvironmentVariable("MARIADB_USER");
string? password = Environment.GetEnvironmentVariable("MARIADB_PASSWORD");
string? server = Environment.GetEnvironmentVariable("MARIADB_SERVER");
string? database = Environment.GetEnvironmentVariable("MARIADB_DATABASE");

if (username == null || password == null || server == null || database == null)
{
    throw new Exception("MARIADB environment variables not set.");
}

string MariaDBConnection = $"Server={server};Database={database};User={username};Password={password};";

// Redis initialization
string? redisConnection = Environment.GetEnvironmentVariable("REDIS_CONNECTION");

if (redisConnection == null)
{
    throw new Exception("REDIS_CONNECTION environment variable not set.");
}

builder.Services.AddControllers();
builder.Services.AddOpenApi();
builder.Services.AddSharedInfrastructure<ApplicationDbContext>(MariaDBConnection);
builder.Services.AddScoped<DeviceRepository>();

// Session
builder.Services.AddStackExchangeRedisCache(options =>
{
    options.Configuration = redisConnection;
    options.InstanceName = "Caspnetti_";
});
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(60 * 24);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi("/api/swagger.json");
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseAuthorization();
app.MapControllers();
app.Run();
