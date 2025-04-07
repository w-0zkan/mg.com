using System;
using System.ComponentModel.DataAnnotations;

namespace mg.API.Models
{
    public class Reservation
    {
        public int Id { get; set; }

        [Required]
        public string UserId { get; set; }

        [Required]
        public int OrganizationId { get; set; }

        [Required]
        public DateTime ReservationDate { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public string Status { get; set; } = "Pending"; // Pending, Confirmed, Cancelled

        // Navigation properties
        public virtual ApplicationUser User { get; set; }
        public virtual Organization Organization { get; set; }
    }
} 