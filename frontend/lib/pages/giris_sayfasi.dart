// lib/pages/giris_sayfasi.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GirisSayfasi extends StatefulWidget {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  final _kullaniciAdiController = TextEditingController();
  final _sifreController = TextEditingController();

  Future<void> _girisYap() async {
    final url = Uri.parse('http://192.168.1.184:5199/api/User/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'kullaniciAdi': _kullaniciAdiController.text,
          'sifre': _sifreController.text,
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['basarili'] == true) {
          String rol = body['rol'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Hoşgeldiniz ${body['kullaniciAdi']}')),
          );

          switch (rol) {
            case 'Musteri':
              Navigator.pushReplacementNamed(context, '/musteriAnaSayfa');
              break;
            case 'Firma':
              Navigator.pushReplacementNamed(context, '/firmaPanel');
              break;
            case 'Admin':
              Navigator.pushReplacementNamed(context, '/adminPanel');
              break;
            default:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Bilinmeyen rol: $rol')),
              );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Geçersiz kullanıcı adı veya şifre')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sunucu hatası: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata oluştu: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _kullaniciAdiController,
              decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
            ),
            TextField(
              controller: _sifreController,
              decoration: InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _girisYap,
              child: Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}