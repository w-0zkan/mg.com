import 'package:flutter/material.dart';
import 'profil_sayfasi.dart';

class AnaSayfa extends StatelessWidget {
  final String kullaniciAdi;

  AnaSayfa({required this.kullaniciAdi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hoşgeldiniz $kullaniciAdi'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilSayfasi(
                    kullaniciAdi: kullaniciAdi,
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Text(
          'MutluGunum.com/a Hoşgeldiniz!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}