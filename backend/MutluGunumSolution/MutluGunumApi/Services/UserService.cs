using MongoDB.Driver;
using MutluGunumApi.Models;
using Microsoft.Extensions.Options;

namespace MutluGunumApi.Services
{
    public class UserService
    {
        private readonly IMongoCollection<User> _userCollection;

        public UserService(IOptions<MongoDBSettings> mongoDbSettings)
        {
            var mongoClient = new MongoClient(mongoDbSettings.Value.ConnectionURI);
            var mongoDatabase = mongoClient.GetDatabase(mongoDbSettings.Value.DatabaseName);
            _userCollection = mongoDatabase.GetCollection<User>(mongoDbSettings.Value.CollectionName);
        }

        // Tüm kullanıcıları getir
        public async Task<List<User>> GetAsync() =>
            await _userCollection.Find(_ => true).ToListAsync();

        // ID'ye göre kullanıcı getir
        public async Task<User?> GetAsync(string id) =>
            await _userCollection.Find(x => x.Id == id).FirstOrDefaultAsync();

        // Yeni kullanıcı oluştur
        public async Task CreateAsync(User newUser) =>
            await _userCollection.InsertOneAsync(newUser);

        // Kullanıcı güncelle
        public async Task UpdateAsync(string id, User updatedUser) =>
            await _userCollection.ReplaceOneAsync(x => x.Id == id, updatedUser);

        // Kullanıcı sil
        public async Task RemoveAsync(string id) =>
            await _userCollection.DeleteOneAsync(x => x.Id == id);

        // ✅ Giriş işlemi (Login) için kullanıcı adı ve şifre kontrolü
        public User? GetByUsernameAndPassword(string kullaniciAdi, string sifre)
        {
            return _userCollection
                .Find(x => x.KullaniciAdi == kullaniciAdi && x.Sifre == sifre)
                .FirstOrDefault();
        }
    }
}