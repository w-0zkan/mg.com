using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace MutluGunumApi.Models
{
    public class User
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string? Id { get; set; }

        [BsonElement("kullaniciAdi")]
        public string KullaniciAdi { get; set; }

        [BsonElement("email")]
        public string Email { get; set; }

        [BsonElement("sifre")]
        public string Sifre { get; set; }

        [BsonElement("rol")]
        public string Rol { get; set; }

        [BsonElement("kayitTarihi")]
        public DateTime KayitTarihi { get; set; } = DateTime.UtcNow;
    }
}