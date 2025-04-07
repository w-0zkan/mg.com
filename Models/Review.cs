using System;
using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;

namespace mg.API.Models
{
    public class Review
    {
        public int Id { get; set; }

        [Required]
        public string UserId { get; set; }

        [Required]
        public int OrganizationId { get; set; }

        [Required]
        [StringLength(500)]
        public string Comment { get; set; }

        [Required]
        [Range(1, 5)]
        public int Rating { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        // Navigation properties
        public virtual ApplicationUser User { get; set; }
        public virtual Organization Organization { get; set; }
        public virtual ICollection<Reservation> Reservations { get; set; }
        public virtual ICollection<UnavailableDate> UnavailableDates { get; set; }
    }
} 