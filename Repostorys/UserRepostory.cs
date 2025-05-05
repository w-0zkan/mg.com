using Application.Repostorys;
using Domain.Entities;

namespace Persistence.Repostorys;

public class UserRepostory:IGenericRepostory<User>,IUserRepostroy
{
    public void Add<T>(T entity)
    {
        throw new NotImplementedException();
    }

    public void Update<T>(T entity)
    {
        throw new NotImplementedException();
    }

    public void Delete<T>(T entity)
    {
        throw new NotImplementedException();
    }

    public List<T> GetAll<T>()
    {
        throw new NotImplementedException();
    }

    public void login()
    {
        throw new NotImplementedException();
    }
}