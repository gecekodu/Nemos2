import 'package:flutter/material.dart';

import '../../../data/mock_game_repository.dart';
import '../../widgets/gradient_card.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({
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
          title: const Text('Profil'),
          backgroundColor: theme.scaffoldBackgroundColor,
          actions: [
            IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
            const SizedBox(width: 4),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Profile card ──────────────────────────────────────
                GradientCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 34,
                            backgroundColor: Colors.white.withValues(alpha: 0.25),
                            child: const Text('N', style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w900)),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'nemos_user',
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text('Seviye 12', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _ProfileStat(value: '4', label: 'Gün Aktif'),
                          _ProfileStatDivider(),
                          _ProfileStat(value: '3', label: 'Favorim'),
                          _ProfileStatDivider(),
                          _ProfileStat(value: '12', label: 'Oynadım'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ─── Friends ───────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Arkadaşlar', style: theme.textTheme.titleLarge),
                    TextButton(onPressed: () {}, child: const Text('Tümü')),
                  ],
                ),
                const SizedBox(height: 12),
                ...repository.friends.map(
                  (friend) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.dividerColor),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: theme.primaryColor.withValues(alpha: 0.12),
                            child: Text(
                              friend.name.characters.first,
                              style: TextStyle(fontWeight: FontWeight.w700, color: theme.primaryColor),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(friend.name, style: theme.textTheme.titleMedium),
                                Text(friend.status, style: theme.textTheme.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Lv.${friend.level}',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: theme.primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}

class _ProfileStatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 32, color: Colors.white.withValues(alpha: 0.25));
  }
}
