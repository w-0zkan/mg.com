using System;
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
    public class ReservationController : ControllerBase
    {
        private readonly IReservationService _reservationService;
        private readonly UserManager<ApplicationUser> _userManager;

        public ReservationController(IReservationService reservationService, UserManager<ApplicationUser> userManager)
        {
            _reservationService = reservationService;
            _userManager = userManager;
        }

        [Authorize]
        [HttpPost]
        public async Task<ActionResult<ReservationDTO>> CreateReservation(CreateReservationDTO reservationDto)
        {
            try
            {
                var userId = _userManager.GetUserId(User);
                var reservation = await _reservationService.CreateReservation(reservationDto, userId);
                return CreatedAtAction(nameof(GetUserReservations), new { userId }, reservation);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [Authorize]
        [HttpGet("user")]
        public async Task<ActionResult<List<ReservationDTO>>> GetUserReservations()
        {
            var userId = _userManager.GetUserId(User);
            var reservations = await _reservationService.GetUserReservations(userId);
            return Ok(reservations);
        }

        [Authorize]
        [HttpGet("organization/{organizationId}")]
        public async Task<ActionResult<List<ReservationDTO>>> GetOrganizationReservations(int organizationId)
        {
            var reservations = await _reservationService.GetOrganizationReservations(organizationId);
            return Ok(reservations);
        }

        [HttpGet("available-dates/{organizationId}")]
        public async Task<ActionResult<AvailableDatesDTO>> GetAvailableDates(
            int organizationId,
            [FromQuery] DateTime startDate,
            [FromQuery] DateTime endDate)
        {
            var availableDates = await _reservationService.GetAvailableDates(organizationId, startDate, endDate);
            return Ok(availableDates);
        }

        [Authorize]
        [HttpPost("unavailable-date")]
        public async Task<ActionResult<UnavailableDateDTO>> AddUnavailableDate(CreateUnavailableDateDTO unavailableDateDto)
        {
            var unavailableDate = await _reservationService.AddUnavailableDate(unavailableDateDto);
            return CreatedAtAction(nameof(GetAvailableDates), new { organizationId = unavailableDateDto.OrganizationId }, unavailableDate);
        }

        [Authorize]
        [HttpDelete("unavailable-date/{id}")]
        public async Task<IActionResult> RemoveUnavailableDate(int id)
        {
            var result = await _reservationService.RemoveUnavailableDate(id);
            if (!result)
            {
                return NotFound();
            }
            return NoContent();
        }
    }
} 