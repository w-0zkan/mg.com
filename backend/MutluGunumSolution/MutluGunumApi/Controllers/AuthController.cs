using Microsoft.AspNetCore.Mvc;
using MutluGunumApi.Models;
using MutluGunumApi.Services;

namespace MutluGunumApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly UserService _userService;

        public AuthController(UserService userService)
        {
            _userService = userService;
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest request)
        {
            var user = _userService.GetByUsernameAndPassword(request.KullaniciAdi, request.Sifre);

            if (user == null)
            {
                return Unauthorized(new { message = "Kullanıcı adı veya şifre hatalı" });
            }

            return Ok(new
            {
                message = "Giriş başarılı",
                user.Id,
                user.KullaniciAdi,
                user.Email,
                user.Rol
            });
        }
    }
}