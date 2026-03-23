import 'package:flutter/material.dart';

import '../../../domain/game_models.dart';
import '../../../data/mock_game_repository.dart';
import '../../controllers/builder_controller.dart';
import '../game_player_screen.dart';
import '../../widgets/gradient_card.dart';

class BuildTab extends StatefulWidget {
  const BuildTab({
    required this.repository,
    required this.controller,
    super.key,
  });

  final MockGameRepository repository;
  final BuilderController controller;

  @override
  State<BuildTab> createState() => _BuildTabState();
}

class _BuildTabState extends State<BuildTab> {
  late final PageController _pageController;
  final TextEditingController _captionController = TextEditingController();
  
  bool _isGenerating = false;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  void _nextStep() {
    FocusScope.of(context).unfocus();
    final currentPage = _pageController.page?.toInt() ?? 0;
    
    if (currentPage < 5) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      _startGeneration();
    }
  }

  Future<void> _startGeneration() async {
    setState(() {
      _isGenerating = true;
    });
    
    // Fake delay for "Epic Creation" effect
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      setState(() {
        _isGenerating = false;
        _isFinished = true;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutExpo,
      );
    }
  }

  void _resetFlow() {
    widget.controller.reset();
    setState(() {
      _isGenerating = false;
      _isFinished = false;
    });
    _captionController.clear();
    _pageController.jumpToPage(0);
  }

  void _shareGame() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎉 Oyun akışta başarıyla paylaşıldı!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
    _resetFlow();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final selection = widget.controller.selection;
        final generated = widget.controller.generated;

        return Column(
          children: [
            // Header
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    const Text(
                      'Oyun Oluştur',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                    const Spacer(),
                    if (!_isGenerating && !_isFinished && selection.mode != null)
                      TextButton.icon(
                        onPressed: _resetFlow,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Baştan Başla'),
                      ),
                  ],
                ),
              ),
            ),
            
            // Progress Bar
            if (!_isGenerating && !_isFinished)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: _ProgressBar(
                  controller: _pageController,
                  totalSteps: 6,
                ),
              ),

            // Page View
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Only programmatic scroll
                children: [
                  _SelectionPage(
                    title: 'Ne tür bir oyun arıyorsun?',
                    subtitle: 'Oyunun temel türünü belirle.',
                    options: GameMode.values.map((e) => e.label).toList(),
                    selectedIndex: selection.mode?.index,
                    onSelected: (i) {
                      widget.controller.selectMode(GameMode.values[i]);
                      _nextStep();
                    },
                  ),
                  _SelectionPage(
                    title: 'Oyunun mekaniği nasıl olsun?',
                    subtitle: 'Tepki mi, planlama mı?',
                    options: GameTempo.values.map((e) => e.label).toList(),
                    selectedIndex: selection.tempo?.index,
                    onSelected: (i) {
                      widget.controller.selectTempo(GameTempo.values[i]);
                      _nextStep();
                    },
                  ),
                  _SelectionPage(
                    title: 'Peki tarzın nedir?',
                    subtitle: 'Kimlerle oynamak istersin?',
                    options: SocialStyle.values.map((e) => e.label).toList(),
                    selectedIndex: selection.socialStyle?.index,
                    onSelected: (i) {
                      widget.controller.selectSocialStyle(SocialStyle.values[i]);
                      _nextStep();
                    },
                  ),
                  _SelectionPage(
                    title: 'Hangi evrene gidelim?',
                    subtitle: 'Kurgu ve vizyonu seç.',
                    options: WorldTheme.values.map((e) => e.label).toList(),
                    selectedIndex: selection.theme?.index,
                    onSelected: (i) {
                      widget.controller.selectTheme(WorldTheme.values[i]);
                      _nextStep();
                    },
                  ),
                  _SelectionPage(
                    title: 'Zorluk ne seviyede olsun?',
                    subtitle: 'Sınırlarını ne kadar zorlamak istiyorsun?',
                    options: SkillLevel.values.map((e) => e.label).toList(),
                    selectedIndex: selection.skillLevel?.index,
                    onSelected: (i) {
                      widget.controller.selectSkillLevel(SkillLevel.values[i]);
                      _nextStep();
                    },
                  ),
                  _SelectionPage(
                    title: 'Ne kadar vaktin var?',
                    subtitle: 'Oyunda harcayacağın seans süresi.',
                    options: SessionLength.values.map((e) => e.label).toList(),
                    selectedIndex: selection.sessionLength?.index,
                    onSelected: (i) {
                      widget.controller.selectSessionLength(SessionLength.values[i]);
                      _nextStep();
                    },
                  ),
                  
                  // Step 7: Loading or Result
                  _isGenerating 
                    ? const _LoadingScreen() 
                    : _ResultScreen(
                        game: generated,
                        captionController: _captionController,
                        onShare: _shareGame,
                        onPlay: () {
                          if (generated != null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => GamePlayerScreen(game: generated)),
                            );
                          }
                        },
                      ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProgressBar extends AnimatedWidget {
  const _ProgressBar({
    required this.controller,
    required this.totalSteps,
  }) : super(listenable: controller);

  final PageController controller;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    double progress = 0.0;
    if (controller.hasClients && controller.page != null) {
      progress = controller.page! / (totalSteps - 1);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 10,
        backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
      ),
    );
  }
}

class _SelectionPage extends StatelessWidget {
  const _SelectionPage({
    required this.title,
    required this.subtitle,
    required this.options,
    required this.selectedIndex,
    required this.onSelected,
  });

  final String title;
  final String subtitle;
  final List<String> options;
  final int? selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, height: 1.1),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 48),
          ...List.generate(options.length, (index) {
            final isSelected = selectedIndex == index;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: () => onSelected(index),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  decoration: BoxDecoration(
                    color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).dividerColor,
                      width: 2,
                    ),
                    boxShadow: isSelected
                        ? [BoxShadow(color: Theme.of(context).primaryColor.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 8))]
                        : [],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          options[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? Colors.white : Theme.of(context).textTheme.titleMedium?.color,
                          ),
                        ),
                      ),
                      if (isSelected) const Icon(Icons.check_circle, color: Colors.white),
                    ],
                  ),
                ),
              ),
            );
          }),
          const Spacer(),
        ],
      ),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              color: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            'Evren Yapılandırılıyor...',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          const Text(
            'Yapay zeka analizleri tamamlanıyor.\nSeçimlerinize en uygun oyun hazırlanıyor.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _ResultScreen extends StatelessWidget {
  const _ResultScreen({
    required this.game,
    required this.captionController,
    required this.onShare,
    required this.onPlay,
  });

  final GameProfile? game;
  final TextEditingController captionController;
  final VoidCallback onShare;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    if (game == null) return const SizedBox.shrink();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Text('🎉 Tamamlandı!', style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),
          const Text(
            'İşte Senin Oyunun',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, height: 1.1),
          ),
          const SizedBox(height: 32),
          
          GradientCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(game!.title, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                Text(game!.shortDescription, style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.4)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: game!.tags.map((t) => Chip(
                    label: Text(t, style: const TextStyle(color: Colors.white, fontSize: 12)),
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    side: BorderSide.none,
                  )).toList(),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: onPlay,
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Hemen Oyna'),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6366F1),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 40),
          const Text('Toplulukla Paylaş', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          TextField(
            controller: captionController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Oyunun hakkında neler düşünüyorsun? Akışta paylaşırken bu not görünecek.',
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: onShare,
            style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 18)),
            child: const Text('Akışta Paylaş'),
          ),
        ],
      ),
    );
  }
}
