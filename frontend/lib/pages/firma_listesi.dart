import 'package:flutter/material.dart';
import 'firma_detay_sayfasi.dart';

class FirmaListesi extends StatefulWidget {
  @override
  _FirmaListesiState createState() => _FirmaListesiState();
}

class _FirmaListesiState extends State<FirmaListesi> {
  List<Map<String, String>> firmalar = [
    {
    'ad': 'Lotus Organizasyon',
    'aciklama': 'Düğün ve özel gün organizasyonları.',
    'il': 'İstanbul',
    'ilce': 'Kadıköy',
    'telefon': '+905551112233',
    'instagram': 'https://instagram.com/lotusorganizasyon'
    },
    {
    'ad': 'Beyaz Lale Events',
    'aciklama': 'Kurumsal etkinlik ve lansman organizasyonu.',
    'il': 'İstanbul',
    'ilce': 'Şişli',
    'telefon': '+905554443322',
    'instagram': 'https://instagram.com/beyazlaleevents'
    },
    {
      'ad': 'Ege Düğün Salonu',
      'aciklama': 'İzmir\'de düğün salonu hizmeti.',
      'il': 'İzmir',
      'ilce': 'Konak',
      'telefon': '+0905519439128',
      'instagram':'https://instagram.com/egedugunsalonu'
    },
  ];

  List<Map<String, String>> _filtrelenmisFirmalar = [];
  String _arama = '';
  String _secilenIl = 'Tümü';
  String _secilenIlce = 'Tümü';

  List<String> _iller = ['Tümü', 'İstanbul', 'İzmir','ANKARA','AROG'];
  List<String> _ilceler = ['Tümü'];

  @override
  void initState() {
    super.initState();
    _filtrelenmisFirmalar = firmalar;
  }

  void _filtrele(String? arama) {
    setState(() {
      _arama = arama ?? '';
      _uygulaFiltre();
    });
  }

  void _uygulaFiltre() {
    setState(() {
      _filtrelenmisFirmalar = firmalar.where((firma) {
        final ad = firma['ad']?.toLowerCase() ?? '';
        final il = firma['il'] ?? '';
        final ilce = firma['ilce'] ?? '';

        bool aramaEslesme = ad.contains(_arama.toLowerCase());
        bool ilEslesme = _secilenIl == 'Tümü' || il == _secilenIl;
        bool ilceEslesme = _secilenIlce == 'Tümü' || ilce == _secilenIlce;

        return aramaEslesme && ilEslesme && ilceEslesme;
      }).toList();
    });
  }

  void _ilDegisti(String? yeniIl) {
    setState(() {
      _secilenIl = yeniIl ?? 'Tümü';
      _secilenIlce = 'Tümü';
      if (_secilenIl == 'İstanbul') {
        _ilceler = ['Tümü', 'Kadıköy', 'Şişli', 'Beşiktaş'];
      } else if (_secilenIl == 'İzmir') {
        _ilceler = ['Tümü', 'Konak', 'Karşıyaka', 'Bornova'];
      } else {
        _ilceler = ['Tümü'];
      }
      _uygulaFiltre();
    });
  }

  void _ilceDegisti(String? yeniIlce) {
    setState(() {
      _secilenIlce = yeniIlce ?? 'Tümü';
      _uygulaFiltre();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        title: Text(
          'Firmaları Gör',
          style: TextStyle(color: Colors.pink.shade700, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.pink.shade700),
      ),
      backgroundColor: Color(0xFFFDF7F8),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Arama Çubuğu
            TextField(
              decoration: InputDecoration(
                hintText: 'Firma ismi ara...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: _filtrele,
            ),
            SizedBox(height: 16),
            // İl Seçimi
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'İl Seçin',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              value: _secilenIl,
              items: _iller.map((il) {
                return DropdownMenuItem<String>(
                  value: il,
                  child: Text(il),
                );
              }).toList(),
              onChanged: _ilDegisti,
            ),
            SizedBox(height: 16),
            // İlçe Seçimi
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'İlçe Seçin',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              value: _secilenIlce,
              items: _ilceler.map((ilce) {
                return DropdownMenuItem<String>(
                  value: ilce,
                  child: Text(ilce),
                );
              }).toList(),
              onChanged: _ilceDegisti,
            ),
            SizedBox(height: 16),
            // Firma Listesi
            Expanded(
              child: _filtrelenmisFirmalar.isEmpty
                  ? Center(child: Text('Bu Bölgede Henüz Hizmet Ortağımız Bulunmamaktadır !'))
                  : ListView.builder(
                      itemCount: _filtrelenmisFirmalar.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            title: Text(
                              _filtrelenmisFirmalar[index]['ad'] ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Text(
                              _filtrelenmisFirmalar[index]['aciklama'] ?? '',
                              style: TextStyle(fontSize: 14),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FirmaDetaySayfasi(
                                     firma: _filtrelenmisFirmalar[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}