import 'package:flutter/widgets.dart';

import '../../../data/mock_game_repository.dart';

class GamesTab extends StatelessWidget {
  const GamesTab({
    required this.repository,
    super.key,
  });

  final MockGameRepository repository;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand();
  }
}
