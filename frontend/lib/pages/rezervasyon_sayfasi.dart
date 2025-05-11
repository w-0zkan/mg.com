import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RezervasyonSayfasi extends StatefulWidget {
  final String firmaAdi;

  RezervasyonSayfasi({required this.firmaAdi});

  @override
  _RezervasyonSayfasiState createState() => _RezervasyonSayfasiState();
}

class _RezervasyonSayfasiState extends State<RezervasyonSayfasi> {
  DateTime? secilenTarih;
  String? secilenSaatAraligi;

  final List<String> saatAraliklari = [
    '10:00 - 12:00',
    '12:00 - 14:00',
    '14:00 - 16:00',
    '16:00 - 18:00',
    '18:00 - 20:00',
    '20:00 - 22:00',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.firmaAdi} - Rezervasyon'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Rezervasyon Tarihi ve Saat Aralığını Seçin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => _tarihSec(context),
                child: Text(
                  secilenTarih == null
                      ? 'Tarih Seç'
                      : DateFormat('dd MMMM yyyy', 'tr_TR').format(secilenTarih!),
                ),
              ),

              const SizedBox(height: 20),

              DropdownButton<String>(
                value: secilenSaatAraligi,
                hint: Text('Saat Aralığı Seç'),
                items: saatAraliklari.map((aralik) {
                  return DropdownMenuItem<String>(
                    value: aralik,
                    child: Text(aralik),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    secilenSaatAraligi = value;
                  });
                },
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: (secilenTarih != null && secilenSaatAraligi != null)
                    ? _rezervasyonYap
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text('Rezervasyon Yap'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _tarihSec(BuildContext context) async {
    final DateTime? secilen = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      locale: const Locale('tr', 'TR'),
    );
    if (secilen != null) {
      setState(() {
        secilenTarih = secilen;
      });
    }
  }

  void _rezervasyonYap() {
    final tarih = DateFormat('dd MMMM yyyy', 'tr_TR').format(secilenTarih!);
    final mesaj =
        '${widget.firmaAdi} için $tarih tarihinde $secilenSaatAraligi saatleri arasında rezervasyon yapıldı!';

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mesaj),
    ));

    // TODO: Bu veriler veritabanına kaydedilecek
  }
}