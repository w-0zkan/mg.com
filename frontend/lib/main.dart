import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages/giris_sayfasi.dart';
import 'pages/kayit_sayfasi.dart';
import 'pages/firma_listesi.dart';
import 'pages/hakkinda_sayfasi.dart';

void main() {
  runApp(MutluGunumApp());
}

class MutluGunumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mutlu Günüm',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr', 'TR'),
        Locale('en', 'US'),
      ],
      home: Anasayfa(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Anasayfa extends StatelessWidget {
  const Anasayfa({super.key});

  void _acUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mutlu Günüm'),
        backgroundColor: Colors.pinkAccent.shade100,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GirisSayfasi()),
              );
            },
            child: Text(
              'Giriş Yap',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KullaniciSecimSayfasi()),
              );
            },
            child: Text(
              'Kayıt Ol',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.pink.shade50,
        ),
        child: Column(
          children: [
            const Spacer(),
            Text(
              'Mutlu Günüm\'e Hoşgeldiniz!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirmaListesi()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Firmaları Gör'),
            ),
            const SizedBox(height: 20),

            // 🔸 Hover ile aktif görünüm (mobilde normal çalışır)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HakkindaSayfasi()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Hakkında', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),

            const Spacer(),

            // 🔸 Sosyal medya ikonları
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt_outlined),
                  tooltip: 'Instagram',
                  color: Colors.pink,
                  onPressed: () => _acUrl('https://instagram.com/seninhesabın'),
                ),
                IconButton(
                  icon: Icon(Icons.alternate_email),
                  tooltip: 'X (Twitter)',
                  color: Colors.black,
                  onPressed: () => _acUrl('https://x.com/seninhesabın'),
                ),
                IconButton(
                  icon: Icon(Icons.facebook),
                  tooltip: 'Facebook',
                  color: Colors.blue,
                  onPressed: () => _acUrl('https://facebook.com/seninhesabın'),
                ),
                IconButton(
                  icon: Icon(Icons.music_note),
                  tooltip: 'TikTok',
                  color: Colors.deepPurple,
                  onPressed: () => _acUrl('https://tiktok.com/@seninhesabın'),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              '© 2025 Mutlu Günüm | Tüm hakları saklıdır.',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class KullaniciSecimSayfasi extends StatelessWidget {
  const KullaniciSecimSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Tipi Seçin'),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KayitSayfasi(kullaniciTipi: 'Müşteri'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                textStyle: TextStyle(fontSize: 16),
              ),
              child: Text('Müşteri'),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        KayitSayfasi(kullaniciTipi: 'Hizmet Veren Firma'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                textStyle: TextStyle(fontSize: 16),
              ),
              child: Text('Hizmet Veren'),
            ),
          ],
        ),
      ),
    );
  }
}