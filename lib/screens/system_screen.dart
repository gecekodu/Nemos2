import 'package:flutter/material.dart';
import 'package:nemos/data/game_data.dart';

class SystemScreen extends StatelessWidget {
  const SystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roadmapItems = getRoadmapItems();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF172554),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Önerilen mimari', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('1. Mobil uygulama seçim akışını yönetir.', style: TextStyle(color: Color(0xFFDBEAFE))),
              Text('2. İçerik servisi uygun HTML oyun paketini döner.', style: TextStyle(color: Color(0xFFDBEAFE))),
              Text('3. WebView/runtime katmanı oyunu açar.', style: TextStyle(color: Color(0xFFDBEAFE))),
              Text('4. Multiplayer oyunlar lobby ve match servisleriyle genişler.', style: TextStyle(color: Color(0xFFDBEAFE))),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...roadmapItems.indexed.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF1E293B)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Aşama ${entry.$1 + 1}', style: const TextStyle(color: Color(0xFF67E8F9), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(entry.$2.$1, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(entry.$2.$2, style: const TextStyle(color: Color(0xFFCBD5E1), height: 1.4)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
