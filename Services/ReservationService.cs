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
    public interface IReservationService
    {
        Task<ReservationDTO> CreateReservation(CreateReservationDTO reservationDto, string userId);
        Task<List<ReservationDTO>> GetUserReservations(string userId);
        Task<List<ReservationDTO>> GetOrganizationReservations(int organizationId);
        Task<AvailableDatesDTO> GetAvailableDates(int organizationId, DateTime startDate, DateTime endDate);
        Task<UnavailableDateDTO> AddUnavailableDate(CreateUnavailableDateDTO unavailableDateDto);
        Task<bool> RemoveUnavailableDate(int id);
        Task<bool> IsDateAvailable(int organizationId, DateTime date);
    }

    public class ReservationService : IReservationService
    {
        private readonly ApplicationDbContext _context;

        public ReservationService(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<ReservationDTO> CreateReservation(CreateReservationDTO reservationDto, string userId)
        {
            if (!await IsDateAvailable(reservationDto.OrganizationId, reservationDto.ReservationDate))
            {
                throw new Exception("Seçilen tarih müsait değil.");
            }

            var reservation = new Reservation
            {
                UserId = userId,
                OrganizationId = reservationDto.OrganizationId,
                ReservationDate = reservationDto.ReservationDate,
                Status = "Pending"
            };

            _context.Reservations.Add(reservation);
            await _context.SaveChangesAsync();

            var createdReservation = await _context.Reservations
                .Include(r => r.User)
                .Include(r => r.Organization)
                .FirstOrDefaultAsync(r => r.Id == reservation.Id);

            return new ReservationDTO
            {
                Id = createdReservation.Id,
                UserName = createdReservation.User.UserName,
                OrganizationId = createdReservation.OrganizationId,
                OrganizationName = createdReservation.Organization.Name,
                ReservationDate = createdReservation.ReservationDate,
                CreatedAt = createdReservation.CreatedAt,
                Status = createdReservation.Status
            };
        }

        public async Task<List<ReservationDTO>> GetUserReservations(string userId)
        {
            return await _context.Reservations
                .Where(r => r.UserId == userId)
                .Include(r => r.Organization)
                .Select(r => new ReservationDTO
                {
                    Id = r.Id,
                    OrganizationId = r.OrganizationId,
                    OrganizationName = r.Organization.Name,
                    ReservationDate = r.ReservationDate,
                    CreatedAt = r.CreatedAt,
                    Status = r.Status
                })
                .OrderByDescending(r => r.ReservationDate)
                .ToListAsync();
        }

        public async Task<List<ReservationDTO>> GetOrganizationReservations(int organizationId)
        {
            return await _context.Reservations
                .Where(r => r.OrganizationId == organizationId)
                .Include(r => r.User)
                .Select(r => new ReservationDTO
                {
                    Id = r.Id,
                    UserName = r.User.UserName,
                    ReservationDate = r.ReservationDate,
                    CreatedAt = r.CreatedAt,
                    Status = r.Status
                })
                .OrderByDescending(r => r.ReservationDate)
                .ToListAsync();
        }

        public async Task<AvailableDatesDTO> GetAvailableDates(int organizationId, DateTime startDate, DateTime endDate)
        {
            var unavailableDates = await _context.UnavailableDates
                .Where(u => u.OrganizationId == organizationId && u.Date >= startDate && u.Date <= endDate)
                .Select(u => u.Date)
                .ToListAsync();

            var reservations = await _context.Reservations
                .Where(r => r.OrganizationId == organizationId && r.ReservationDate >= startDate && r.ReservationDate <= endDate)
                .Select(r => r.ReservationDate)
                .ToListAsync();

            var allUnavailableDates = unavailableDates.Union(reservations).ToList();
            var allDates = Enumerable.Range(0, (endDate - startDate).Days + 1)
                .Select(offset => startDate.AddDays(offset))
                .ToList();

            var availableDates = allDates.Except(allUnavailableDates).ToArray();

            return new AvailableDatesDTO
            {
                OrganizationId = organizationId,
                AvailableDates = availableDates,
                UnavailableDates = allUnavailableDates.ToArray()
            };
        }

        public async Task<UnavailableDateDTO> AddUnavailableDate(CreateUnavailableDateDTO unavailableDateDto)
        {
            var unavailableDate = new UnavailableDate
            {
                OrganizationId = unavailableDateDto.OrganizationId,
                Date = unavailableDateDto.Date,
                Reason = unavailableDateDto.Reason
            };

            _context.UnavailableDates.Add(unavailableDate);
            await _context.SaveChangesAsync();

            return new UnavailableDateDTO
            {
                Id = unavailableDate.Id,
                OrganizationId = unavailableDate.OrganizationId,
                Date = unavailableDate.Date,
                Reason = unavailableDate.Reason
            };
        }

        public async Task<bool> RemoveUnavailableDate(int id)
        {
            var unavailableDate = await _context.UnavailableDates.FindAsync(id);
            if (unavailableDate == null)
            {
                return false;
            }

            _context.UnavailableDates.Remove(unavailableDate);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> IsDateAvailable(int organizationId, DateTime date)
        {
            var isUnavailable = await _context.UnavailableDates
                .AnyAsync(u => u.OrganizationId == organizationId && u.Date.Date == date.Date);

            if (isUnavailable)
            {
                return false;
            }

            var hasReservation = await _context.Reservations
                .AnyAsync(r => r.OrganizationId == organizationId && r.ReservationDate.Date == date.Date);

            return !hasReservation;
        }
    }
} 