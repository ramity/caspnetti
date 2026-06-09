using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace Wryco.EFirst;

public class BaseController<TRepo, TEntity, TContext> : ControllerBase
where TRepo : BaseIRepository<TEntity>
where TEntity : class, BaseIEntity
where TContext: DbContext
{
    protected readonly TRepo _repository;

    public BaseController(TRepo repository)
    {
        _repository = repository;
    }

    [HttpGet]
    public virtual IActionResult Index()
    {
        return new JsonResult(_repository.FindAll());
    }

    [HttpGet("{id}")]
    public virtual IActionResult Show(int id)
    {
        return new JsonResult(_repository.FindOneBy(e => e.Id == id));
    }

    [HttpPost]
    public virtual IActionResult Create([FromBody] TEntity newEntity)
    {
        _repository.Add(newEntity);
        _repository.Save();
        return new JsonResult(newEntity.Id);
    }

    [HttpPut("{id}")]
    public virtual IActionResult Update(int id, [FromBody] TEntity updatedEntity)
    {
        var existing = _repository.FindOneBy(e => e.Id == id);
        if (existing == null)
        {
            return new JsonResult(false);
        }

        _repository.Update(updatedEntity);
        _repository.Save();
        return new JsonResult(true);
    }

    [HttpDelete("{id}")]
    public virtual IActionResult Delete(int id)
    {
        var existing = _repository.FindOneBy(e => e.Id == id);
        if (existing == null)
        {
            return new JsonResult(false);
        }

        _repository.Delete(existing);
        _repository.Save();
        return new JsonResult(true);
    }
}
