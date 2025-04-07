using System;

namespace mg.API.Models.DTOs
{
    public class ReservationDTO
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public int OrganizationId { get; set; }
        public string OrganizationName { get; set; }
        public DateTime ReservationDate { get; set; }
        public DateTime CreatedAt { get; set; }
        public string Status { get; set; }
    }

    public class CreateReservationDTO
    {
        public int OrganizationId { get; set; }
        public DateTime ReservationDate { get; set; }
    }

    public class UnavailableDateDTO
    {
        public int Id { get; set; }
        public int OrganizationId { get; set; }
        public DateTime Date { get; set; }
        public string Reason { get; set; }
    }

    public class CreateUnavailableDateDTO
    {
        public int OrganizationId { get; set; }
        public DateTime Date { get; set; }
        public string Reason { get; set; }
    }

    public class AvailableDatesDTO
    {
        public int OrganizationId { get; set; }
        public DateTime[] AvailableDates { get; set; }
        public DateTime[] UnavailableDates { get; set; }
    }
} 