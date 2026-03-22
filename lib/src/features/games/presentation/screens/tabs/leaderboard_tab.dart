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
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Liderlik sıralaması',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 12),
        ...repository.leaderboard.map(
          (entry) => Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('${entry.rank}')),
              title: Text(entry.player),
              subtitle: Text('Favori oyun: ${entry.favoriteGame}'),
              trailing: Text('${entry.points}'),
            ),
          ),
        ),
      ],
    );
  }
}
