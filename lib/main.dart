import 'package:flutter/material.dart';
import 'package:nemos/screens/builder_screen.dart';
import 'package:nemos/screens/library_screen.dart';
import 'package:nemos/screens/system_screen.dart';

void main() {
  runApp(const NemosApp());
}

class NemosApp extends StatelessWidget {
  const NemosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nemos',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF08101F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.dark,
        ),
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int currentIndex = 0;

  final screens = const [
    BuilderScreen(),
    LibraryScreen(),
    SystemScreen(),
  ];

  final titles = const [
    'Builder',
    'Kütüphane',
    'Sistem',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nemos'),
            Text(
              titles[currentIndex],
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: const Color(0xFF94A3B8)),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (value) => setState(() => currentIndex = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.auto_awesome), label: 'Builder'),
          NavigationDestination(icon: Icon(Icons.videogame_asset_outlined), label: 'Kütüphane'),
          NavigationDestination(icon: Icon(Icons.hub_outlined), label: 'Sistem'),
        ],
      ),
    );
  }
}
