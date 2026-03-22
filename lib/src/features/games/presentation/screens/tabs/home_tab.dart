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

    return CustomScrollView(
      slivers: [
        // ─── SliverAppBar ───────────────────────────────────────────────
        SliverAppBar(
          floating: true,
          snap: true,
          title: const Text('Nemos'),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {},
            ),
            const SizedBox(width: 4),
          ],
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Hero gradient card ─────────────────────────────────
                GradientCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '🎮  Türkiye\'nin Oyun Keşfi',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Sana en uygun\noyunu bul.',
                        style: theme.textTheme.headlineLarge?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      const _Bullet(text: '6 adımlı oyun oluşturma ve eşleşme'),
                      const _Bullet(text: '20 oyunluk başlangıç kütüphanesi'),
                      const _Bullet(text: 'TikTok stili dikey keşfet akışı'),
                      const _Bullet(text: 'Arkadaşlık, beğeni ve liderlik'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            '${repository.totalPossibilityCount} farklı eşleşme ihtimali',
                            style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ─── Stats row ─────────────────────────────────────────
                Row(
                  children: [
                    _StatCard(icon: Icons.gamepad_rounded, value: '${repository.featuredGames.length}', label: 'Oyun'),
                    const SizedBox(width: 12),
                    _StatCard(icon: Icons.people_rounded, value: '${repository.friends.length}', label: 'Arkadaş'),
                    const SizedBox(width: 12),
                    _StatCard(icon: Icons.emoji_events_rounded, value: '${repository.leaderboard.length}', label: 'Sıralama'),
                  ],
                ),

                const SizedBox(height: 28),

                Text('🔥 Öne çıkan oyunlar', style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),

        // ─── Featured games list ──────────────────────────────────────
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _GameListCard(game: repository.featuredGames[i]),
              ),
              childCount: repository.featuredGames.length,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Column(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 26),
            const SizedBox(height: 6),
            Text(value, style: Theme.of(context).textTheme.titleMedium),
            Text(label, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}

class _GameListCard extends StatelessWidget {
  const _GameListCard({required this.game});

  final GameProfile game;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF0EA5E9)],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.gamepad_rounded, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(game.title, style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(game.shortDescription, style: theme.textTheme.bodyMedium, maxLines: 2),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              Icon(Icons.favorite_rounded, size: 14, color: Colors.redAccent.withValues(alpha: 0.8)),
              const SizedBox(width: 4),
              Text('${game.likes}', style: theme.textTheme.bodyMedium),
            ],
          ),
        ],
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
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('✦ ', style: TextStyle(color: Colors.white70, fontSize: 13)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
