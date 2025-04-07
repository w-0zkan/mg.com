namespace mg.API.Models.DTOs
{
    public class OrganizationDTO
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string City { get; set; }
        public string ServiceType { get; set; }
        public string Description { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string Website { get; set; }
        public double AverageRating { get; set; }
        public int ReviewCount { get; set; }
    }

    public class OrganizationFilterDTO
    {
        public string City { get; set; }
        public string ServiceType { get; set; }
    }
} 