using Microsoft.EntityFrameworkCore;
using mg.API.Models;

namespace mg.API.Data
{
    public class ApplicationDbContext : DbContext
    {
        public DbSet<Review> Reviews { get; set; }
    }
} 