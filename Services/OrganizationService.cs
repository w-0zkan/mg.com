using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using mg.API.Data;
using mg.API.Models;
using mg.API.Models.DTOs;
using Microsoft.EntityFrameworkCore;

namespace mg.API.Services
{
    public interface IOrganizationService
    {
        Task<List<OrganizationDTO>> GetOrganizations(OrganizationFilterDTO filter);
        Task<List<string>> GetCities();
        Task<List<string>> GetServiceTypes();
    }

    public class OrganizationService : IOrganizationService
    {
        private readonly ApplicationDbContext _context;

        public OrganizationService(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<List<OrganizationDTO>> GetOrganizations(OrganizationFilterDTO filter)
        {
            var query = _context.Organizations
                .Include(o => o.Reviews)
                .AsQueryable();

            if (!string.IsNullOrEmpty(filter.City))
            {
                query = query.Where(o => o.City == filter.City);
            }

            if (!string.IsNullOrEmpty(filter.ServiceType))
            {
                query = query.Where(o => o.ServiceType == filter.ServiceType);
            }

            return await query
                .Select(o => new OrganizationDTO
                {
                    Id = o.Id,
                    Name = o.Name,
                    City = o.City,
                    ServiceType = o.ServiceType,
                    Description = o.Description,
                    Address = o.Address,
                    Phone = o.Phone,
                    Email = o.Email,
                    Website = o.Website,
                    AverageRating = o.Reviews.Any() ? o.Reviews.Average(r => r.Rating) : 0,
                    ReviewCount = o.Reviews.Count
                })
                .ToListAsync();
        }

        public async Task<List<string>> GetCities()
        {
            return await _context.Organizations
                .Select(o => o.City)
                .Distinct()
                .OrderBy(c => c)
                .ToListAsync();
        }

        public async Task<List<string>> GetServiceTypes()
        {
            return await _context.Organizations
                .Select(o => o.ServiceType)
                .Distinct()
                .OrderBy(t => t)
                .ToListAsync();
        }
    }
} 