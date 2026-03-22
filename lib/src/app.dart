import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/games/data/mock_game_repository.dart';
import 'features/games/presentation/controllers/builder_controller.dart';
import 'features/games/presentation/screens/main_shell_screen.dart';

class NemosApp extends StatefulWidget {
  const NemosApp({super.key});

  @override
  State<NemosApp> createState() => _NemosAppState();
}

class _NemosAppState extends State<NemosApp> {
  late final MockGameRepository repository;
  late final BuilderController builderController;

  @override
  void initState() {
    super.initState();
    repository = MockGameRepository();
    builderController = BuilderController(repository: repository);
  }

  @override
  void dispose() {
    builderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nemos',
      theme: AppTheme.light(),
      home: MainShellScreen(
        repository: repository,
        builderController: builderController,
      ),
    );
  }
}
