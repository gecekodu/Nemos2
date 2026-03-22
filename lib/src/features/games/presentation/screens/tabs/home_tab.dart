import 'package:flutter/material.dart';

import '../../../domain/game_models.dart';
import '../../../data/mock_game_repository.dart';
import '../../widgets/gradient_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({
    required this.repository,
    super.key,
  });

  final MockGameRepository repository;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Nemos', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Türkçe sosyal oyun keşif uygulamasının güçlü Flutter temeli.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        GradientCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ürün özeti', style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              const _Bullet(text: '6 adımlı oyun oluşturma akışı ve kişisel eşleşme'),
              const _Bullet(
                  text: '20 oyunluk başlangıç kütüphanesi ve akıllı eşleme'),
              const _Bullet(text: 'TikTok/Reels tarzı kaydırmalı keşfet deneyimi'),
              const _Bullet(text: 'Arkadaşlık, yorum, beğeni ve liderlik kurgusu'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('Öne çıkan oyunlar', style: theme.textTheme.titleLarge),
        const SizedBox(height: 12),
        ...repository.featuredGames
            .take(3)
            .map((game) => _GameListCard(game: game)),
      ],
    );
  }
}

class _GameListCard extends StatelessWidget {
  const _GameListCard({required this.game});

  final GameProfile game;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(game.title),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(game.shortDescription),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 7),
            child: Icon(Icons.circle, size: 8),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
