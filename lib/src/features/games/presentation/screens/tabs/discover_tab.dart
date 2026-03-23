import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/mock_game_repository.dart';
import '../../../domain/game_models.dart';

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
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.repository.featuredGames.length,
      itemBuilder: (context, index) {
        final game = widget.repository.featuredGames[index];
        final creator =
            widget.repository.friends[index % widget.repository.friends.length];
        return _DiscoverGamePage(
          game: game,
          creator: creator,
          pageController: _pageController,
          pageCount: widget.repository.featuredGames.length,
          index: index,
        );
      },
    );
  }
}

class _DiscoverGamePage extends StatefulWidget {
  const _DiscoverGamePage({
    required this.game,
    required this.creator,
    required this.pageController,
    required this.pageCount,
    required this.index,
  });

  final GameProfile game;
  final FriendProfile creator;
  final PageController pageController;
  final int pageCount;
  final int index;

  @override
  State<_DiscoverGamePage> createState() => _DiscoverGamePageState();
}

class _DiscoverGamePageState extends State<_DiscoverGamePage>
    with AutomaticKeepAliveClientMixin {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (!mounted) return;
            setState(() => _isLoading = false);
          },
        ),
      )
      ..loadFlutterAsset(widget.game.htmlAssetPath);
  }

  void _handleVerticalSwipe(double velocity) {
    if (velocity < -240 && widget.index < widget.pageCount - 1) {
      widget.pageController.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    } else if (velocity > 240 && widget.index > 0) {
      widget.pageController.previousPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final views = widget.game.score * 8 + widget.game.likes;

    return ColoredBox(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            flex: 76,
            child: Stack(
              fit: StackFit.expand,
              children: [
                DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.black),
                  child: WebViewWidget(controller: _controller),
                ),
                Positioned(
                  top: 18,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.36),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                    child: Text(
                      '${widget.index + 1}/${widget.pageCount}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 72,
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.92),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 24,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragEnd: (details) {
                final velocity = details.primaryVelocity;
                if (velocity != null) {
                  _handleVerticalSwipe(velocity);
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 10),
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _MetricItem(
                          icon: Icons.remove_red_eye_outlined,
                          value: _formatMetric(views),
                        ),
                        _MetricItem(
                          icon: Icons.favorite_border_rounded,
                          value: _formatMetric(widget.game.likes),
                        ),
                        _MetricItem(
                          icon: Icons.chat_bubble_outline_rounded,
                          value: _formatMetric(widget.game.comments),
                        ),
                        IconButton(
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                Colors.white.withValues(alpha: 0.06),
                            minimumSize: const Size(42, 42),
                          ),
                          icon: const Icon(Icons.share_outlined, size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      widget.game.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.4,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                color:
                                    theme.primaryColor.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(18),
                                image: const DecorationImage(
                                  image: AssetImage('assets/app/logo.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: -2,
                              bottom: -2,
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF22C55E),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.creator.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                widget.creator.handle,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.58),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.game.shortDescription,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.78),
                                  fontSize: 13.2,
                                  height: 1.3,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              style: IconButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.white.withValues(
                                  alpha: 0.06,
                                ),
                                minimumSize: const Size(42, 42),
                              ),
                              icon: const Icon(
                                Icons.videocam_outlined,
                                size: 20,
                              ),
                            ),
                            const SizedBox(height: 8),
                            IconButton(
                              onPressed: () {},
                              style: IconButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.white.withValues(
                                  alpha: 0.06,
                                ),
                                minimumSize: const Size(42, 42),
                              ),
                              icon: const Icon(Icons.more_vert, size: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  const _MetricItem({
    required this.icon,
    required this.value,
  });

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 23),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

String _formatMetric(int value) {
  if (value >= 1000000) {
    final formatted = (value / 1000000).toStringAsFixed(1).replaceAll('.', ',');
    return '${formatted}m';
  }

  if (value >= 1000) {
    final formatted = (value / 1000).toStringAsFixed(1).replaceAll('.', ',');
    return '${formatted}k';
  }

  return '$value';
}
