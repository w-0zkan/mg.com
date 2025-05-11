using Microsoft.AspNetCore.Mvc;
using MutluGunumApi.Models;
using MutluGunumApi.Services;

namespace MutluGunumApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        private readonly UserService _userService;

        public UserController(UserService userService) =>
            _userService = userService;

        // Tüm kullanıcıları getir
        [HttpGet]
        public async Task<List<User>> Get() =>
            await _userService.GetAsync();

        // ID ile kullanıcı getir
        [HttpGet("{id:length(24)}")]
        public async Task<ActionResult<User>> Get(string id)
        {
            var user = await _userService.GetAsync(id);
            if (user is null) return NotFound();
            return user;
        }

        // Yeni kullanıcı oluştur
        [HttpPost]
        public async Task<IActionResult> Post(User newUser)
        {
            await _userService.CreateAsync(newUser);
            return CreatedAtAction(nameof(Get), new { id = newUser.Id }, newUser);
        }

        // Kullanıcıyı güncelle
        [HttpPut("{id:length(24)}")]
        public async Task<IActionResult> Update(string id, User updatedUser)
        {
            var user = await _userService.GetAsync(id);
            if (user is null) return NotFound();
            updatedUser.Id = user.Id;
            await _userService.UpdateAsync(id, updatedUser);
            return NoContent();
        }

        // Kullanıcı sil
        [HttpDelete("{id:length(24)}")]
        public async Task<IActionResult> Delete(string id)
        {
            var user = await _userService.GetAsync(id);
            if (user is null) return NotFound();
            await _userService.RemoveAsync(id);
            return NoContent();
        }

        // ✅ GİRİŞ (LOGIN) İŞLEMİ
        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest loginRequest)
        {
            var user = _userService.GetByUsernameAndPassword(loginRequest.KullaniciAdi, loginRequest.Sifre);
            if (user == null)
            {
                return Unauthorized(new
                {
                    basarili = false,
                    mesaj = "Geçersiz kullanıcı adı veya şifre."
                });
            }

            return Ok(new
            {
                basarili = true,
                mesaj = "Giriş başarılı",
                kullaniciAdi = user.KullaniciAdi,
                rol = user.Rol
            });
        }
    }
}