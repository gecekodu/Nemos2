import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../domain/game_models.dart';
import '../../../data/mock_game_repository.dart';

class DiscoverTab extends StatelessWidget {
  const DiscoverTab({
    required this.repository,
    super.key,
  });

  final MockGameRepository repository;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: repository.featuredGames.length,
      itemBuilder: (context, index) {
        final game = repository.featuredGames[index];
        return _FeedGameItem(game: game);
      },
    );
  }
}

class _FeedGameItem extends StatefulWidget {
  const _FeedGameItem({required this.game});

  final GameProfile game;

  @override
  State<_FeedGameItem> createState() => _FeedGameItemState();
}

class _FeedGameItemState extends State<_FeedGameItem> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _isPlaying = false; // When true, webview takes touches.

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
        ),
      )
      ..loadFlutterAsset(widget.game.htmlAssetPath);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Webview (The Game)
        Positioned.fill(
          child: WebViewWidget(controller: _controller),
        ),
        
        if (_isLoading)
          const Center(child: CircularProgressIndicator()),

        // A touch absorber when not playing, to allow PageView scrolling
        if (!_isPlaying)
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() => _isPlaying = true);
              },
              child: Container(color: Colors.transparent),
            ),
          ),

        // Semi-transparent gradient overlay at bottom for UI
        if (!_isPlaying)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.9),
                    Colors.black.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),

        // UI Overlay (TikTok style sidebar & bottom info)
        if (!_isPlaying)
          Positioned(
            left: 16,
            right: 80,
            bottom: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Keşfet Akışı', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.game.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.8), blurRadius: 8)],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.game.shortDescription,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.8), blurRadius: 4)],
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.game.tags.map((tag) => 
                    Chip(
                      label: Text(tag, style: const TextStyle(fontSize: 11)),
                      visualDensity: VisualDensity.compact,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      side: BorderSide.none,
                    )
                  ).toList(),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => setState(() => _isPlaying = true),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Oynamak için dokun'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ),
          
        // Sidebar (Likes, comments, etc.)
        if (!_isPlaying)
          Positioned(
            right: 12,
            bottom: 40,
            child: Column(
              children: [
                _SidebarAction(icon: Icons.favorite, label: '${widget.game.likes}'),
                const SizedBox(height: 24),
                _SidebarAction(icon: Icons.chat_bubble_rounded, label: '${widget.game.comments}'),
                const SizedBox(height: 24),
                _SidebarAction(icon: Icons.share_rounded, label: 'Paylaş'),
                const SizedBox(height: 24),
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.gamepad, color: Colors.white),
                ),
              ],
            ),
          ),

        // If playing, an exit button
        if (_isPlaying)
          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(
              child: IconButton(
                onPressed: () => setState(() => _isPlaying = false),
                icon: const Icon(Icons.close),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black54,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _SidebarAction extends StatelessWidget {
  const _SidebarAction({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 36, color: Colors.white, shadows: [Shadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 8)]),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, shadows: [Shadow(color: Colors.black, blurRadius: 4)])),
      ],
    );
  }
}
