using Application.Repostorys;
using Domain.Entities.BaseEntity;
using Persistence.Context;

namespace Persistence.Repostorys;

public abstract class GenericRepostory<T>: IGenericRepostory<T> where T : BaseEntity
{
    private readonly PostgreContext _context;

    public GenericRepostory(PostgreContext context)
    {
        _context = context;
    }
    public void Add<T1>(T1 entity)
    {
        _context.Add(entity);
        _context.SaveChanges();
    }

    public void Update<T1>(T1 entity)
    {
        throw new NotImplementedException();
    }

    public void Delete<T1>(T1 entity)
    {
        throw new NotImplementedException();
    }

    public List<T1> GetAll<T1>()
    {
        throw new NotImplementedException();
    }
}