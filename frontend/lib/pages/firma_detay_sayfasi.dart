import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/yorum_model.dart';
import 'rezervasyon_sayfasi.dart';

class FirmaDetaySayfasi extends StatefulWidget {
  final Map<String, String> firma;

  const FirmaDetaySayfasi({Key? key, required this.firma}) : super(key: key);

  @override
  _FirmaDetaySayfasiState createState() => _FirmaDetaySayfasiState();
}

class _FirmaDetaySayfasiState extends State<FirmaDetaySayfasi> {
  final List<Yorum> yorumlar = [];
  final TextEditingController yorumController = TextEditingController();

  // Simüle edilmiş giriş yapmış kullanıcı
  final String? aktifKullaniciAdi = "ozkan123";

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  void _yorumEkle() {
    final icerik = yorumController.text.trim();
    if (icerik.isNotEmpty && aktifKullaniciAdi != null) {
      setState(() {
        yorumlar.add(
          Yorum(
            kullaniciAdi: aktifKullaniciAdi!,
            icerik: icerik,
            tarih: DateTime.now(),
          ),
        );
        yorumController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final firma = widget.firma;

    return Scaffold(
      appBar: AppBar(
        title: Text(firma['ad'] ?? ''),
        backgroundColor: Colors.pink.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Firma adı ve açıklama
            Text(
              firma['ad'] ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pink.shade700),
            ),
            const SizedBox(height: 12),
            Text(
              firma['aciklama'] ?? '',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // İletişim ikonları
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.phone),
                  color: Colors.pink,
                  onPressed: () {
                    final phone = firma['telefon'] ?? '';
                    if (phone.isNotEmpty) {
                      _launchURL('tel:$phone');
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.whatsapp),
                  color: Colors.green,
                  onPressed: () {
                    final phone = firma['telefon'] ?? '';
                    if (phone.isNotEmpty) {
                      _launchURL('https://wa.me/$phone');
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.instagram),
                  color: Colors.purple,
                  onPressed: () {
                    final instaLink = firma['instagram'] ?? '';
                    if (instaLink.isNotEmpty) {
                      _launchURL(instaLink);
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Rezervasyon Butonu
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade300,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RezervasyonSayfasi(
                        firmaAdi: firma['ad'] ?? '',
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Rezervasyon Yap',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Yorumlar Başlığı
            Text(
              'Yorumlar',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Yorum listesi
            ...yorumlar.reversed.map((yorum) => Card(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(yorum.kullaniciAdi),
                    subtitle: Text(yorum.icerik),
                    trailing: Text(
                      '${yorum.tarih.day}/${yorum.tarih.month}/${yorum.tarih.year}',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                )),

            const SizedBox(height: 20),

            // Yorum Ekleme Alanı
            aktifKullaniciAdi != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: yorumController,
                        decoration: InputDecoration(
                          labelText: 'Yorumunuz',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _yorumEkle,
                        child: Text('Yorumu Gönder'),
                      ),
                    ],
                  )
                : Text(
                    'Yorum yapmak için giriş yapmalısınız.',
                    style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
                  ),
          ],
        ),
      ),
    );
  }
}