import 'package:flutter/material.dart';
import 'package:mutlugunum/pages/giris_sayfasi.dart';

class ProfilSayfasi extends StatelessWidget {
  final String kullaniciAdi;

  ProfilSayfasi({required this.kullaniciAdi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profilim'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ad Soyad: $kullaniciAdi', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => GirisSayfasi()),
                  (route) => false,
                );
              },
              child: Text('Çıkış Yap'),
            ),
          ],
        ),
      ),
    );
  }
}