using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using mg.API.Models.DTOs;
using mg.API.Services;
using Microsoft.AspNetCore.Identity;
using mg.API.Models;

namespace mg.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReviewController : ControllerBase
    {
        private readonly IReviewService _reviewService;
        private readonly UserManager<ApplicationUser> _userManager;

        public ReviewController(IReviewService reviewService, UserManager<ApplicationUser> userManager)
        {
            _reviewService = reviewService;
            _userManager = userManager;
        }

        [HttpGet("organization/{organizationId}")]
        public async Task<ActionResult<List<ReviewDTO>>> GetReviewsByOrganization(int organizationId)
        {
            var reviews = await _reviewService.GetReviewsByOrganizationId(organizationId);
            return Ok(reviews);
        }

        [Authorize]
        [HttpPost]
        public async Task<ActionResult<ReviewDTO>> CreateReview(CreateReviewDTO reviewDto)
        {
            var userId = _userManager.GetUserId(User);
            var review = await _reviewService.CreateReview(reviewDto, userId);
            return CreatedAtAction(nameof(GetReviewsByOrganization), new { organizationId = reviewDto.OrganizationId }, review);
        }
    }
} 