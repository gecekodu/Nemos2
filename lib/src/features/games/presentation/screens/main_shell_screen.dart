import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/mock_game_repository.dart';
import '../controllers/builder_controller.dart';
import 'tabs/build_tab.dart';
import 'tabs/discover_tab.dart';
import 'tabs/games_tab.dart';
import 'tabs/home_tab.dart';
import 'tabs/store_tab.dart';

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
  static const int _homeIndex = 2;

  late final PageController _pageController;
  late final List<Widget> _pages;
  int currentIndex = _homeIndex;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _homeIndex);
    _pages = [
      StoreTab(repository: widget.repository),
      GamesTab(repository: widget.repository),
      HomeTab(repository: widget.repository),
      DiscoverTab(repository: widget.repository),
      BuildTab(
        repository: widget.repository,
        controller: widget.builderController,
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _goToPage(int index) async {
    if (index == currentIndex) return;

    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        if (currentIndex != _homeIndex) {
          await _goToPage(_homeIndex);
          return;
        }

        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Çıkış'),
            content:
                const Text('Uygulamadan çıkmak istediğinize emin misiniz?'),
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
          child: PageView(
            controller: _pageController,
            onPageChanged: (value) => setState(() => currentIndex = value),
            physics: const BouncingScrollPhysics(),
            children: _pages,
          ),
        ),
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.16),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  _BottomNavItem(
                    label: 'Mağaza',
                    selected: currentIndex == 0,
                    onTap: () => _goToPage(0),
                    iconOffset: const Offset(0, 0),
                    icon: const _NavImage(
                      assetPath: 'assets/navigation/store.png',
                    ),
                  ),
                  const _NavDivider(),
                  _BottomNavItem(
                    label: 'Oyunlar',
                    selected: currentIndex == 1,
                    onTap: () => _goToPage(1),
                    iconOffset: const Offset(0, 0),
                    icon: const _NavImage(
                      assetPath: 'assets/navigation/games.png',
                    ),
                  ),
                  const _NavDivider(),
                  _BottomNavItem(
                    label: 'Ana sayfa',
                    selected: currentIndex == 2,
                    onTap: () => _goToPage(2),
                    iconOffset: const Offset(0, 0),
                    icon: Icon(
                      Icons.home_rounded,
                      color:
                          currentIndex == 2 ? Colors.white : theme.primaryColor,
                    ),
                  ),
                  const _NavDivider(),
                  _BottomNavItem(
                    label: 'Keşfet',
                    selected: currentIndex == 3,
                    onTap: () => _goToPage(3),
                    iconOffset: const Offset(4, 0),
                    icon: const _NavImage(
                      assetPath: 'assets/navigation/discover.png',
                    ),
                  ),
                  const _NavDivider(),
                  _BottomNavItem(
                    label: 'Oyun oluştur',
                    selected: currentIndex == 4,
                    onTap: () => _goToPage(4),
                    iconOffset: const Offset(0, 0),
                    icon: const _NavImage(
                      assetPath: 'assets/navigation/build.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ), // closes Scaffold
    ); // closes PopScope
  }
}

class _NavImage extends StatelessWidget {
  const _NavImage({
    required this.assetPath,
  });

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      isAntiAlias: true,
      gaplessPlayback: true,
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.icon,
    this.iconOffset = Offset.zero,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Widget icon;
  final Offset iconOffset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.zero,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          height: 88,
          color: selected ? const Color(0xFF5056D8) : Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: Offset(iconOffset.dx, selected ? -2 : -1),
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOutBack,
                  scale: selected ? 1.18 : 0.92,
                  child: SizedBox(
                    width: selected ? 58 : 50,
                    height: selected ? 58 : 50,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: icon,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                height: 22,
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    reverseDuration: const Duration(milliseconds: 120),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.vertical,
                          child: child,
                        ),
                      );
                    },
                    child: selected
                        ? SizedBox(
                            key: ValueKey(label),
                            width: double.infinity,
                            child: Text(
                              label,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.2,
                                shadows: const [
                                  Shadow(
                                    color: Color(0xCC111827),
                                    blurRadius: 1.2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink(key: ValueKey('empty')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavDivider extends StatelessWidget {
  const _NavDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 52,
      color: const Color(0xFFE5E7EB),
    );
  }
}
