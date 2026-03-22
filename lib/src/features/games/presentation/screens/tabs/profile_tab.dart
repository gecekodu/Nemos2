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
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Profil ve arkadaşlar',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 12),
        const GradientCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'nemos_user',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 8),
              Text('Seviye 12 • 4 gündür aktif • 3 oyun favoride'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('Arkadaşlık sistemi',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        ...repository.friends.map(
          (friend) => Card(
            child: ListTile(
              leading: CircleAvatar(child: Text(friend.name.characters.first)),
              title: Text(friend.name),
              subtitle: Text('${friend.handle} • ${friend.status}'),
              trailing: Text('Lv.${friend.level}'),
            ),
          ),
        ),
      ],
    );
  }
}
