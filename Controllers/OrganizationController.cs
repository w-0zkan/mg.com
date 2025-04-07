using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using mg.API.Models.DTOs;
using mg.API.Services;

namespace mg.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrganizationController : ControllerBase
    {
        private readonly IOrganizationService _organizationService;

        public OrganizationController(IOrganizationService organizationService)
        {
            _organizationService = organizationService;
        }

        [HttpGet]
        public async Task<ActionResult<List<OrganizationDTO>>> GetOrganizations([FromQuery] OrganizationFilterDTO filter)
        {
            var organizations = await _organizationService.GetOrganizations(filter);
            return Ok(organizations);
        }

        [HttpGet("cities")]
        public async Task<ActionResult<List<string>>> GetCities()
        {
            var cities = await _organizationService.GetCities();
            return Ok(cities);
        }

        [HttpGet("service-types")]
        public async Task<ActionResult<List<string>>> GetServiceTypes()
        {
            var serviceTypes = await _organizationService.GetServiceTypes();
            return Ok(serviceTypes);
        }
    }
} 