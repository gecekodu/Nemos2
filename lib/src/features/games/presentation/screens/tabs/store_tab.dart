import 'package:flutter/widgets.dart';

import '../../../data/mock_game_repository.dart';

class StoreTab extends StatelessWidget {
  const StoreTab({
    required this.repository,
    super.key,
  });

  final MockGameRepository repository;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand();
  }
}
