using System;
using System.ComponentModel.DataAnnotations;

namespace mg.API.Models
{
    public class UnavailableDate
    {
        public int Id { get; set; }

        [Required]
        public int OrganizationId { get; set; }

        [Required]
        public DateTime Date { get; set; }

        [StringLength(200)]
        public string Reason { get; set; }

        // Navigation property
        public virtual Organization Organization { get; set; }
    }
} 