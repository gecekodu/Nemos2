import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/mock_game_repository.dart';
import '../controllers/builder_controller.dart';
import 'tabs/build_tab.dart';
import 'tabs/discover_tab.dart';
import 'tabs/home_tab.dart';
import 'tabs/leaderboard_tab.dart';
import 'tabs/profile_tab.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({
    required this.repository,
    required this.builderController,
    super.key,
  });

  final MockGameRepository repository;
  final BuilderController builderController;

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeTab(repository: widget.repository),
      DiscoverTab(repository: widget.repository),
      BuildTab(
        repository: widget.repository,
        controller: widget.builderController,
      ),
      LeaderboardTab(repository: widget.repository),
      ProfileTab(repository: widget.repository),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        if (currentIndex != 0) {
          setState(() => currentIndex = 0);
          return;
        }

        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Çıkış'),
            content: const Text('Uygulamadan çıkmak istediğinize emin misiniz?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('İptal'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Çık'),
              ),
            ],
          ),
        );

        if (shouldPop ?? false) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
      body: SafeArea(
        child: IndexedStack(index: currentIndex, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (value) => setState(() => currentIndex = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Ana Sayfa',
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle_outline),
            label: 'Keşfet',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            label: 'Oluştur',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            label: 'Liderlik',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    ), // closes Scaffold
    ); // closes PopScope
  }
}
