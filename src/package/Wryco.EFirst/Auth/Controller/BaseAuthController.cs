using Wryco.EFirst;
using Wryco.EFirst.Auth.Repository;
using Wryco.EFirst.Auth.Service;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http;

namespace Caspnetti.API.Controllers;

public class BaseAuthController<TRepo, TEntity, TContext> : BaseController<TRepo, TEntity, TContext>
where TRepo : BaseIRepository<TEntity>
where TEntity : class, BaseIEntity
where TContext: DbContext
{
    protected UserService _userService;

    public BaseAuthController(TRepo repository, UserService userService)
    : base(repository)
    {
        _userService = userService;
    }

    private bool UserIsAuthenticated()
    {
        string? token = HttpContext.Session.GetString("token");

        if (token != null)
        {
            bool isTokenValid = _userService.ValidateSessionToken(token);

            if (isTokenValid)
            {
                return true;
            }
        }

        return false;
    }

    [HttpGet]
    public override IActionResult Index()
    {
        if (!UserIsAuthenticated())
        {
            return Unauthorized();
        }

        return base.Index();
    }

    [HttpGet("{id}")]
    public override IActionResult Show(int id)
    {
        if (!UserIsAuthenticated())
        {
            return Unauthorized();
        }

        return base.Show(id);
    }

    [HttpPost]
    public override IActionResult Create([FromBody] TEntity newEntity)
    {
        if (!UserIsAuthenticated())
        {
            return Unauthorized();
        }

        return base.Create(newEntity);
    }

    [HttpPut("{id}")]
    public override IActionResult Update(int id, [FromBody] TEntity updatedEntity)
    {
        if (!UserIsAuthenticated())
        {
            return Unauthorized();
        }

        return base.Update(id, updatedEntity);
    }

    [HttpDelete("{id}")]
    public override IActionResult Delete(int id)
    {
        if (!UserIsAuthenticated())
        {
            return Unauthorized();
        }

        return base.Delete(id);
    }
}
