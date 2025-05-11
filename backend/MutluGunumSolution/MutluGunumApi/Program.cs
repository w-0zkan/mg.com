using MutluGunumApi.Models;
using MutluGunumApi.Services;

var builder = WebApplication.CreateBuilder(args);

// 🌐 CORS yapılandırması (Flutter için mutlaka gerekli)
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader();
    });
});

// 🗃️ MongoDB ayarlarını yapılandır
builder.Services.Configure<MongoDBSettings>(
    builder.Configuration.GetSection("MongoDBSettings"));

// 🧩 Gerekli servisleri ekle
builder.Services.AddSingleton<UserService>();
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// 🌐 CORS middleware'i aktif et
app.UseCors("AllowAll");

// 🧪 Swagger sadece geliştirme ortamında açılır
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// HTTPS yönlendirmesi (gerekirse aç-kapa)
app.UseHttpsRedirection();

app.UseAuthorization();

// 📦 Tüm controller’ları aktif et
app.MapControllers();

// ✅ Sunucuyu çalıştır
app.Run();