import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../domain/game_models.dart';

class GamePlayerScreen extends StatefulWidget {
  const GamePlayerScreen({
    required this.game,
    super.key,
  });

  final GameProfile game;

  @override
  State<GamePlayerScreen> createState() => _GamePlayerScreenState();
}

class _GamePlayerScreenState extends State<GamePlayerScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _errorText;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (!mounted) return;
            setState(() => _isLoading = false);
          },
          onWebResourceError: (error) {
            if (!mounted) return;
            setState(() {
              _errorText = error.description;
              _isLoading = false;
            });
          },
        ),
      )
      ..setBackgroundColor(Colors.black)
      ..loadFlutterAsset(widget.game.htmlAssetPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game.title),
      ),
      body: Stack(
        children: [
          if (_errorText == null) WebViewWidget(controller: _controller),
          if (_errorText != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Oyun yüklenemedi.\n$_errorText',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
