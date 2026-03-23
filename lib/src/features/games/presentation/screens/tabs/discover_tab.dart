import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../domain/game_models.dart';
import '../../../data/mock_game_repository.dart';

class DiscoverTab extends StatefulWidget {
  const DiscoverTab({
    required this.repository,
    super.key,
  });

  final MockGameRepository repository;

  @override
  State<DiscoverTab> createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      // PageScrollPhysics replaced with NeverScrollableScrollPhysics to prevent swipe conflict
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.repository.featuredGames.length,
      itemBuilder: (context, index) {
        final game = widget.repository.featuredGames[index];
        return _FeedPage(game: game, pageController: _pageController);
      },
    );
  }
}

/// A single feed page with game on top 70% and native UI on bottom 30%
class _FeedPage extends StatefulWidget {
  const _FeedPage({
    required this.game,
    required this.pageController,
  });

  final GameProfile game;
  final PageController pageController;

  @override
  State<_FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<_FeedPage>
    with AutomaticKeepAliveClientMixin {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  bool get wantKeepAlive => true; // Keep instance alive when swiping back and forth

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (_) {
          if (mounted) setState(() => _isLoading = false);
        },
      ))
      ..loadFlutterAsset(widget.game.htmlAssetPath);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          // ─── TOP: Live Game Screen ──────────────────────────────
          Expanded(
            flex: 83, // Takes up ~83% of the height
            child: Container(
              margin: const EdgeInsets.only(bottom: 8), // zero margin on top, left, right
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    color: theme.primaryColor.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  // Always live WebView handling its own touches
                  Positioned.fill(
                    child: SafeArea(
                      bottom: false,
                      child: WebViewWidget(controller: _controller),
                    ),
                  ),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                ],
              ),
            ),
          ),

          // ─── BOTTOM: Native Flutter UI ───────────────────────────
          // Swiping vertically inside this Expanded area will trigger the PageView perfectly
          Expanded(
            flex: 17, 
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity != null) {
                  if (details.primaryVelocity! < -300) {
                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  } else if (details.primaryVelocity! > 300) {
                    widget.pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                }
              },
              child: Container(
                color: Colors.transparent, // Required to catch drag events in empty spaces
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  // 1. Stats row in a rounded outlined box
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withValues(alpha: 0.05) : theme.primaryColor.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: theme.primaryColor.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatItem(
                          icon: Icons.remove_red_eye_rounded,
                          value: _formatCount(widget.game.score * 5),
                          color: theme.primaryColor,
                        ),
                        _StatItem(
                          icon: Icons.share_rounded,
                          value: _formatCount(widget.game.comments + 45), // proxy share count
                          color: Colors.white,
                        ),
                        _StatItem(
                          icon: Icons.favorite_rounded,
                          value: _formatCount(widget.game.likes),
                          color: Colors.orangeAccent,
                        ),
                        _StatItem(
                          icon: Icons.chat_bubble_rounded,
                          value: _formatCount(widget.game.comments),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 2. Profile Info Row
                  Row(
                    children: [
                      // Avatar with overlay plus icon
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: Stack(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.primaryColor.withValues(alpha: 0.2),
                                image: const DecorationImage(
                                  // Placeholder avatar using an asset or network is ideal, 
                                  // but we'll use a colorful gradient to simulate it.
                                  image: NetworkImage('https://picsum.photos/100'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.orangeAccent,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.add, size: 12, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Text Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.game.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '@nemos_creator',
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Right Action Button (Shuffle/Play)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: theme.dividerColor, width: 1.5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.shuffle_rounded, size: 18, color: theme.iconTheme.color),
                            const SizedBox(width: 6),
                            Text(
                              '4', // Match the mockup
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.textTheme.bodyLarge?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCount(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fallbackColor = theme.brightness == Brightness.dark ? Colors.white : Colors.black87;
    // We override color if it's strictly "white" but we are in light theme
    final finalIconColor = (color == Colors.white && theme.brightness == Brightness.light) ? Colors.black54 : color;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: finalIconColor),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 14,
            color: fallbackColor,
          ),
        ),
      ],
    );
  }
}
