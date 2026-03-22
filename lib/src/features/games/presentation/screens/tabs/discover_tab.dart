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
      // Stable physics: snapping with dampening so scroll settles on a page
      physics: const _SnapPageScrollPhysics(),
      itemCount: widget.repository.featuredGames.length,
      itemBuilder: (context, index) {
        final game = widget.repository.featuredGames[index];
        return _FeedPage(game: game);
      },
    );
  }
}

/// Custom physics that keeps PageView stable and snapping cleanly.
class _SnapPageScrollPhysics extends ScrollPhysics {
  const _SnapPageScrollPhysics({super.parent});

  @override
  _SnapPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _SnapPageScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 80,
        stiffness: 100,
        damping: 1.2,
      );
}

/// A single game page in the feed: WebView lives always, overlay sits on top.
class _FeedPage extends StatefulWidget {
  const _FeedPage({required this.game});

  final GameProfile game;

  @override
  State<_FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<_FeedPage>
    with AutomaticKeepAliveClientMixin {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _showOverlay = true;

  @override
  bool get wantKeepAlive => true; // Keep WebView alive when swiped away

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
    final media = MediaQuery.of(context);
    final size = media.size;

    return SizedBox.expand(
      child: Stack(
        children: [
          // ─── Always-live game WebView ───────────────────────────────────
          Positioned.fill(
            child: WebViewWidget(controller: _controller),
          ),

          if (_isLoading)
            Container(
              color: Colors.black,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 16),
                    Text('Oyun yükleniyor...', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ),

          // ─── Info overlay (slides up to hide when user wants full screen) ──
          if (_showOverlay) ...[
            // Bottom gradient
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: size.height * 0.5,
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0, 0.6, 1],
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.55),
                        Colors.black.withValues(alpha: 0.88),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Top gradient (safe area)
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: size.height * 0.18,
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Top bar
            Positioned(
              top: media.padding.top + 12,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  _TagBadge(label: _modeLabel(widget.game.mode)),
                  const SizedBox(width: 8),
                  _TagBadge(label: _sessionLabel(widget.game.sessionLength)),
                  const Spacer(),
                  _CircleButton(
                    icon: Icons.fullscreen,
                    onTap: () => setState(() => _showOverlay = false),
                    tooltip: 'Tam ekran',
                  ),
                ],
              ),
            ),

            // Bottom info + actions
            Positioned(
              left: 16,
              right: 80,
              bottom: media.padding.bottom + 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.game.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 8)],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.game.shortDescription,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: widget.game.tags
                        .take(4)
                        .map((t) => _TagBadge(label: t))
                        .toList(),
                  ),
                ],
              ),
            ),

            // Right sidebar actions
            Positioned(
              right: 12,
              bottom: media.padding.bottom + 24,
              child: Column(
                children: [
                  _SideAction(
                    icon: Icons.favorite_rounded,
                    label: _formatCount(widget.game.likes),
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 20),
                  _SideAction(
                    icon: Icons.chat_bubble_rounded,
                    label: _formatCount(widget.game.comments),
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  _SideAction(
                    icon: Icons.share_rounded,
                    label: 'Paylaş',
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  _SideAction(
                    icon: Icons.local_fire_department_rounded,
                    label: _formatCount(widget.game.score),
                    color: Colors.orangeAccent,
                  ),
                ],
              ),
            ),
          ],

          // ─── Full-screen exit button ────────────────────────────────────
          if (!_showOverlay)
            Positioned(
              top: media.padding.top + 12,
              right: 16,
              child: _CircleButton(
                icon: Icons.fullscreen_exit,
                onTap: () => setState(() => _showOverlay = true),
                tooltip: 'Çık',
              ),
            ),

          // ─── Swipe indicator at top ─────────────────────────────────────
          if (_showOverlay)
            Positioned(
              top: media.padding.top + 14,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
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

  String _modeLabel(GameMode mode) => mode.label;
  String _sessionLabel(SessionLength s) => s.label;
}

class _TagBadge extends StatelessWidget {
  const _TagBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 0.5),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _SideAction extends StatelessWidget {
  const _SideAction({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            shadows: [Shadow(color: Colors.black, blurRadius: 4)],
          ),
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}
