import 'package:flutter/material.dart';

import '../../../data/mock_game_repository.dart';

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({
    required this.repository,
    super.key,
  });

  final MockGameRepository repository;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          title: const Text('Liderlik'),
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top 3 podium
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (repository.leaderboard.length > 1)
                      _PodiumCard(entry: repository.leaderboard[1], height: 100),
                    const SizedBox(width: 8),
                    if (repository.leaderboard.isNotEmpty)
                      _PodiumCard(entry: repository.leaderboard[0], height: 130),
                    const SizedBox(width: 8),
                    if (repository.leaderboard.length > 2)
                      _PodiumCard(entry: repository.leaderboard[2], height: 80),
                  ],
                ),
                const SizedBox(height: 24),
                Text('Tüm sıralama', style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final entry = repository.leaderboard[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.dividerColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _rankColor(entry.rank).withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${entry.rank}',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: _rankColor(entry.rank),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(entry.player, style: theme.textTheme.titleMedium),
                              Text('Favori: ${entry.favoriteGame}', style: theme.textTheme.bodyMedium),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${entry.points}',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).primaryColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: repository.leaderboard.length,
            ),
          ),
        ),
      ],
    );
  }

  Color _rankColor(int rank) {
    switch (rank) {
      case 1: return const Color(0xFFFFBF00);  // Gold
      case 2: return const Color(0xFF9E9E9E);  // Silver
      case 3: return const Color(0xFFCD7F32);  // Bronze
      default: return const Color(0xFF64748B);
    }
  }
}

class _PodiumCard extends StatelessWidget {
  const _PodiumCard({required this.entry, required this.height});

  final dynamic entry;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isFirst = entry.rank == 1;
    return Expanded(
      child: Column(
        children: [
          if (isFirst) const Text('🏆', style: TextStyle(fontSize: 28)),
          Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isFirst
                    ? [const Color(0xFFFFBF00), const Color(0xFFFF8C00)]
                    : [const Color(0xFF6366F1), const Color(0xFF0EA5E9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${entry.rank}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    entry.player,
                    style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
