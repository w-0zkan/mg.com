using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Conventions.Infrastructure;

namespace Persistence.Context;

public class PostgreContext:DbContext
{
   protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
   {
      optionsBuilder.UseNpgsql("Host=localhost;Port=5432;Database=mydatabase;Username=admin;Password=123456");
   }
   public DbSet<Consept> Consepts { get; set; }
   public DbSet<Company> Companies { get; set; }
   public DbSet<User> Users { get; set; }
   
}

