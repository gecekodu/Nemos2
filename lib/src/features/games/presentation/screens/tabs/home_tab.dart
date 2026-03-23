import 'package:flutter/material.dart';

import '../../../domain/game_models.dart';
import '../../../data/mock_game_repository.dart';
import '../game_player_screen.dart';
import '../../widgets/gradient_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({
    required this.repository,
    super.key,
  });

  final MockGameRepository repository;

  void _openGame(BuildContext context, GameProfile game) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => GamePlayerScreen(game: game)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Pick a featured game for the Hero section
    final heroGame = repository.featuredGames.firstWhere(
      (g) => g.id == 'n1',
      orElse: () => repository.featuredGames.first,
    );

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          title: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: const DecorationImage(
                    image: AssetImage('assets/app/logo.png'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.primaryColor.withValues(alpha: 0.14),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Text('Nemos',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      letterSpacing: -1.0)),
            ],
          ),
          backgroundColor: theme.scaffoldBackgroundColor,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                shape: BoxShape.circle,
                border: Border.all(color: theme.dividerColor),
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
            ),
          ],
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ─── EPIC HERO SECTION ─────────────────────────────────
                GestureDetector(
                  onTap: () => _openGame(context, heroGame),
                  child: Container(
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                            color: theme.primaryColor.withValues(alpha: 0.2),
                            blurRadius: 30,
                            offset: const Offset(0, 15)),
                      ],
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?q=80&w=2070&auto=format&fit=crop'), // Placeholder sci-fi/gaming image
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Gradient Overlay for text readability
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.3),
                                  Colors.black.withValues(alpha: 0.8),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Content
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.25),
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text('Günün Seçimi',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12)),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                heroGame.title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900,
                                    height: 1.1,
                                    letterSpacing: -1.0),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                heroGame.shortDescription,
                                style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 36),

                // ─── QUICK STATS ───────────────────────────────────────────
                Row(
                  children: [
                    _EpicStatCard(
                        icon: Icons.flash_on_rounded,
                        title: 'Aktif Oyuncu',
                        value: '12K+',
                        color: const Color(0xFFEAB308)),
                    const SizedBox(width: 16),
                    _EpicStatCard(
                        icon: Icons.casino_rounded,
                        title: 'Toplam Oyun',
                        value: '${repository.totalPossibilityCount}',
                        color: const Color(0xFF6366F1)),
                  ],
                ),

                const SizedBox(height: 36),

                // ─── TRENDING NOW (HORIZONTAL CAROUSEL) ─────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Şu An Trend',
                        style: theme.textTheme.titleLarge
                            ?.copyWith(fontSize: 24, letterSpacing: -0.5)),
                    IconButton(
                        icon: const Icon(Icons.arrow_forward_rounded),
                        onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),

        // Horizontal List inside a SliverToBoxAdapter
        SliverToBoxAdapter(
          child: SizedBox(
            height: 220,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: 6, // Show top 6
              itemBuilder: (context, index) {
                final game =
                    repository.featuredGames[index + 1]; // Skip the hero game
                return _HorizontalGameCard(
                  game: game,
                  onTap: () => _openGame(context, game),
                  index: index,
                );
              },
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── FRIENDS ACTIVITY ─────────────────────────────────────
                Text('Arkadaşlarından Haberler',
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontSize: 24, letterSpacing: -0.5)),
                const SizedBox(height: 16),
                ...repository.friends.map(
                  (friend) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: theme.dividerColor),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4))
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor:
                              theme.primaryColor.withValues(alpha: 0.1),
                          child: Text(
                            friend.name.substring(0, 1),
                            style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 20),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(friend.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16)),
                              const SizedBox(height: 4),
                              Text(
                                friend.status,
                                style: TextStyle(
                                    color: theme.textTheme.bodyMedium?.color,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right_rounded,
                            color: theme.dividerColor.withValues(alpha: 0.5)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // ─── PROMO BANNER ──────────────────────────────────────────
                GradientCard(
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Kendi Oyununu Yarat',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.5)),
                            SizedBox(height: 8),
                            Text(
                                'Yapay zeka ile saniyeler içinde benzersiz bir deneyim oluştur.',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                    height: 1.4)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle),
                        child: const Icon(Icons.auto_awesome_rounded,
                            color: Colors.white, size: 32),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EpicStatCard extends StatelessWidget {
  const _EpicStatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Theme.of(context).dividerColor),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 16),
            Text(value,
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.0)),
            const SizedBox(height: 4),
            Text(title,
                style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _HorizontalGameCard extends StatelessWidget {
  const _HorizontalGameCard({
    required this.game,
    required this.onTap,
    required this.index,
  });

  final GameProfile game;
  final VoidCallback onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    // Generate a beautiful generic gradient based on the index to act as placeholder art
    final gradients = [
      [const Color(0xFFF472B6), const Color(0xFF8B5CF6)], // Pink -> Purple
      [const Color(0xFF34D399), const Color(0xFF3B82F6)], // Mint -> Blue
      [const Color(0xFFFBBF24), const Color(0xFFEA580C)], // Yellow -> Orange
      [const Color(0xFF2DD4BF), const Color(0xFF0F766E)], // Teal
      [
        const Color(0xFFA78BFA),
        const Color(0xFF4C1D95)
      ], // Light purple -> Dark purple
      [
        const Color(0xFF60A5FA),
        const Color(0xFF1D4ED8)
      ], // Light blue -> Dark blue
    ];

    final gradient = gradients[index % gradients.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Theme.of(context).dividerColor),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(23)),
                gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          const Icon(Icons.favorite_rounded,
                              color: Colors.white, size: 12),
                          const SizedBox(width: 4),
                          Text('${game.likes}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        letterSpacing: -0.5),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    game.tags.first,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
