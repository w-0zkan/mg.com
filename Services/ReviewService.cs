using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using mg.API.Data;
using mg.API.Models;
using mg.API.Models.DTOs;
using Microsoft.EntityFrameworkCore;

namespace mg.API.Services
{
    public interface IReviewService
    {
        Task<List<ReviewDTO>> GetReviewsByOrganizationId(int organizationId);
        Task<ReviewDTO> CreateReview(CreateReviewDTO reviewDto, string userId);
    }

    public class ReviewService : IReviewService
    {
        private readonly ApplicationDbContext _context;

        public ReviewService(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<List<ReviewDTO>> GetReviewsByOrganizationId(int organizationId)
        {
            return await _context.Reviews
                .Where(r => r.OrganizationId == organizationId)
                .Include(r => r.User)
                .Select(r => new ReviewDTO
                {
                    Id = r.Id,
                    UserName = r.User.UserName,
                    Comment = r.Comment,
                    Rating = r.Rating,
                    CreatedAt = r.CreatedAt
                })
                .OrderByDescending(r => r.CreatedAt)
                .ToListAsync();
        }

        public async Task<ReviewDTO> CreateReview(CreateReviewDTO reviewDto, string userId)
        {
            var review = new Review
            {
                UserId = userId,
                OrganizationId = reviewDto.OrganizationId,
                Comment = reviewDto.Comment,
                Rating = reviewDto.Rating,
                CreatedAt = DateTime.UtcNow
            };

            _context.Reviews.Add(review);
            await _context.SaveChangesAsync();

            var createdReview = await _context.Reviews
                .Include(r => r.User)
                .FirstOrDefaultAsync(r => r.Id == review.Id);

            return new ReviewDTO
            {
                Id = createdReview.Id,
                UserName = createdReview.User.UserName,
                Comment = createdReview.Comment,
                Rating = createdReview.Rating,
                CreatedAt = createdReview.CreatedAt
            };
        }
    }
} 