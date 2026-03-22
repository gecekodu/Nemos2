import 'package:flutter/material.dart';
import 'package:nemos/data/game_data.dart';
import 'package:nemos/models/game.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: gameLibrary.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final game = gameLibrary[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF1E293B)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(game.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  _StatusChip(status: game.packageStatus),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${game.category.label} • ${game.sessionType.label} • ${game.theme.label} • ${game.playTime.label}',
                style: const TextStyle(color: Color(0xFF67E8F9), fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(game.pitch, style: const TextStyle(color: Color(0xFFE2E8F0), height: 1.4)),
              const SizedBox(height: 8),
              Text('HTML teslim modeli', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xFF93C5FD))),
              Text(game.htmlDelivery, style: const TextStyle(color: Color(0xFFCBD5E1))),
              const SizedBox(height: 8),
              Text('Multiplayer notu', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xFF93C5FD))),
              Text(game.multiplayerNote, style: const TextStyle(color: Color(0xFFCBD5E1))),
            ],
          ),
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final PackageStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      PackageStatus.ready => const Color(0xFF14532D),
      PackageStatus.prototype => const Color(0xFF1E3A8A),
      PackageStatus.planned => const Color(0xFF78350F),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(999)),
      child: Text(status.label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
