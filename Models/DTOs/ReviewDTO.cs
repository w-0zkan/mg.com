using System;

namespace mg.API.Models.DTOs
{
    public class ReviewDTO
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public string Comment { get; set; }
        public int Rating { get; set; }
        public DateTime CreatedAt { get; set; }
    }

    public class CreateReviewDTO
    {
        public int OrganizationId { get; set; }
        public string Comment { get; set; }
        public int Rating { get; set; }
    }
} 