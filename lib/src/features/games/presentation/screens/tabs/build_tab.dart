import 'package:flutter/material.dart';

import '../../../domain/game_models.dart';
import '../../../data/mock_game_repository.dart';
import '../../controllers/builder_controller.dart';
import '../game_player_screen.dart';
import '../../widgets/gradient_card.dart';

class BuildTab extends StatelessWidget {
  const BuildTab({
    required this.repository,
    required this.controller,
    super.key,
  });

  final MockGameRepository repository;
  final BuilderController controller;

  void _openGame(BuildContext context, GameProfile game) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => GamePlayerScreen(game: game)),
    );
  }

  int _selectedStepCount(BuilderSelection selection) {
    var count = 0;
    if (selection.mode != null) count++;
    if (selection.tempo != null) count++;
    if (selection.socialStyle != null) count++;
    if (selection.theme != null) count++;
    if (selection.skillLevel != null) count++;
    if (selection.sessionLength != null) count++;
    return count;
  }

  List<String> _selectionSummary(BuilderSelection selection) {
    return [
      if (selection.mode != null) selection.mode!.label,
      if (selection.tempo != null) selection.tempo!.label,
      if (selection.socialStyle != null) selection.socialStyle!.label,
      if (selection.theme != null) selection.theme!.label,
      if (selection.skillLevel != null) selection.skillLevel!.label,
      if (selection.sessionLength != null) selection.sessionLength!.label,
    ];
  }

  @override
  Widget build(BuildContext context) {
    const totalSteps = 6;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final selection = controller.selection;
        final generated = controller.generated;
        final isComplete = selection.isComplete;
        final selectedCount = _selectedStepCount(selection);
        final summary = _selectionSummary(selection);

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              title: const Text('Oyun Oluştur'),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${repository.totalPossibilityCount} ihtimal içinden sana en uygun oyunu buluyoruz.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    // Progress card
                    _ProgressCard(selectedCount: selectedCount, totalSteps: totalSteps),
                    if (summary.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: summary.map((item) => Chip(label: Text(item))).toList(),
                      ),
                    ],
                    const SizedBox(height: 16),
                    _StepCard(
                      step: 1,
                      title: 'Oyun modu',
                      subtitle: 'Ne tür bir deneyim arıyorsun?',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: GameMode.values.map((mode) => ChoiceChip(
                          label: Text(mode.label),
                          selected: selection.mode == mode,
                          onSelected: (_) => controller.selectMode(mode),
                        )).toList(),
                      ),
                    ),
                    _StepCard(
                      step: 2,
                      title: 'Tempo',
                      subtitle: 'Ritmi nasıl olsun?',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: GameTempo.values.map((tempo) => ChoiceChip(
                          label: Text(tempo.label),
                          selected: selection.tempo == tempo,
                          onSelected: (_) => controller.selectTempo(tempo),
                        )).toList(),
                      ),
                    ),
                    _StepCard(
                      step: 3,
                      title: 'Sosyal stil',
                      subtitle: 'Tek başına mı, arkadaşlarla mı?',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: SocialStyle.values.map((style) => ChoiceChip(
                          label: Text(style.label),
                          selected: selection.socialStyle == style,
                          onSelected: (_) => controller.selectSocialStyle(style),
                        )).toList(),
                      ),
                    ),
                    _StepCard(
                      step: 4,
                      title: 'Dünya teması',
                      subtitle: 'Hangi atmosfer sana daha yakın?',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: WorldTheme.values.map((t) => ChoiceChip(
                          label: Text(t.label),
                          selected: selection.theme == t,
                          onSelected: (_) => controller.selectTheme(t),
                        )).toList(),
                      ),
                    ),
                    _StepCard(
                      step: 5,
                      title: 'Zorluk seviyesi',
                      subtitle: 'Ne kadar meydan okuma istiyorsun?',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: SkillLevel.values.map((sl) => ChoiceChip(
                          label: Text(sl.label),
                          selected: selection.skillLevel == sl,
                          onSelected: (_) => controller.selectSkillLevel(sl),
                        )).toList(),
                      ),
                    ),
                    _StepCard(
                      step: 6,
                      title: 'Oturum süresi',
                      subtitle: 'Bir seferde ne kadar oynamak istersin?',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: SessionLength.values.map((sl) => ChoiceChip(
                          label: Text(sl.label),
                          selected: selection.sessionLength == sl,
                          onSelected: (_) => controller.selectSessionLength(sl),
                        )).toList(),
                      ),
                    ),
                    // Match result card
                    if (generated != null) ...[
                      const SizedBox(height: 8),
                      GradientCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('✨', style: TextStyle(fontSize: 20)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    isComplete ? 'Sana Özel Seçilen Oyun' : 'En Uyumlu Oyun',
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(generated.title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                            const SizedBox(height: 6),
                            Text(generated.shortDescription, style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4)),
                            const SizedBox(height: 8),
                            Text(generated.experience, style: const TextStyle(color: Colors.white60, fontSize: 13, height: 1.4)),
                            if (!isComplete) ...[
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  '💡 Tüm adımları tamamlayınca eşleşme daha da netleşir.',
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: generated.tags
                                  .map((t) => Chip(
                                        label: Text(t, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                                        side: BorderSide.none,
                                        visualDensity: VisualDensity.compact,
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: controller.reset,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      side: const BorderSide(color: Colors.white54),
                                    ),
                                    child: const Text('Sıfırla'),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: FilledButton(
                                    onPressed: () => _openGame(context, generated),
                                    style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF6366F1)),
                                    child: const Text('Oyna'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.selectedCount, required this.totalSteps});

  final int selectedCount;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final progress = selectedCount / totalSteps;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('İlerleme', style: theme.textTheme.titleMedium),
              const Spacer(),
              Text('$selectedCount / $totalSteps adım', style: theme.textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(value: progress, minHeight: 8),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.step,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int step;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('$step', style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.w900, fontSize: 13)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleMedium),
                    Text(subtitle, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
