import 'package:flutter/material.dart';

class HakkindaSayfasi extends StatelessWidget {
  const HakkindaSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hakkında'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 80, color: Colors.pinkAccent),
            const SizedBox(height: 20),
            Text(
              'Mutlu Günüm',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.pink),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Bu uygulama, özel günlerinizde ihtiyaç duyduğunuz organizasyon firmalarını kolayca bulmanızı sağlar. '
              'Düğün, nişan, doğum günü gibi etkinlikler için en uygun firmayı seçebilir, rezervasyon yapabilirsiniz.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Text(
              'Geliştirici: Özkan Bozkurt\n© 2025 Mutlu Günüm',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}