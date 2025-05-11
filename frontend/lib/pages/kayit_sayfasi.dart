import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KayitSayfasi extends StatefulWidget {
  final String kullaniciTipi;

  KayitSayfasi({required this.kullaniciTipi});

  @override
  _KayitSayfasiState createState() => _KayitSayfasiState();
}

class _KayitSayfasiState extends State<KayitSayfasi> {
  final _formKey = GlobalKey<FormState>();
  final adSoyadController = TextEditingController();
  final emailController = TextEditingController();
  final cepTelefonuController = TextEditingController();
  final sifreController = TextEditingController();
  final sifreTekrarController = TextEditingController();
  bool capsLockAcik = false;

  // Şifre doğrulama fonksiyonu
  String? validateSifre(String value) {
    if (value.length < 8) {
      return 'Şifre en az 8 karakter olmalı';
    }
    if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
      return 'Şifre en az bir harf içermeli';
    }
    return null;
  }

  // Caps Lock kontrolü
  void _onKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      setState(() {
        capsLockAcik = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Ol (${widget.kullaniciTipi})'),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: _onKey,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: adSoyadController,
                  decoration: InputDecoration(
                    labelText: 'Ad Soyad',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ad Soyad giriniz';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'E-Posta',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'E-Posta giriniz';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: cepTelefonuController,
                  decoration: InputDecoration(
                    labelText: 'Cep Telefonu',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Cep telefonu giriniz';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: sifreController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Şifre giriniz';
                    }
                    return validateSifre(value);
                  },
                ),
                if (capsLockAcik)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Caps Lock açık!',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                SizedBox(height: 12),
                TextFormField(
                  controller: sifreTekrarController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Şifre Tekrar',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Şifreyi tekrar giriniz';
                    }
                    if (value != sifreController.text) {
                      return 'Şifreler uyuşmuyor';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form başarıyla doğrulandı
                      print('Ad Soyad: ${adSoyadController.text}');
                      print('E-Posta: ${emailController.text}');
                      print('Cep Telefonu: ${cepTelefonuController.text}');
                      print('Şifre: ${sifreController.text}');
                      print('Kullanıcı Tipi: ${widget.kullaniciTipi}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Kayıt Başarılı! (${widget.kullaniciTipi})'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Kayıt Ol'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}