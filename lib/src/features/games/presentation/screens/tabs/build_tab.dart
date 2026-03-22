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
      MaterialPageRoute(
        builder: (_) => GamePlayerScreen(game: game),
      ),
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
    final chips = <String>[];
    if (selection.mode != null) chips.add(selection.mode!.label);
    if (selection.tempo != null) chips.add(selection.tempo!.label);
    if (selection.socialStyle != null) chips.add(selection.socialStyle!.label);
    if (selection.theme != null) chips.add(selection.theme!.label);
    if (selection.skillLevel != null) chips.add(selection.skillLevel!.label);
    if (selection.sessionLength != null) {
      chips.add(selection.sessionLength!.label);
    }
    return chips;
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

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Oyununu oluştur',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '${repository.totalPossibilityCount} ihtimal içinden sana en uygun oyunu buluyoruz.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            _BuilderProgressCard(
              selectedStepCount: selectedCount,
              totalStepCount: totalSteps,
            ),
            if (summary.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    summary.map((item) => Chip(label: Text(item))).toList(),
              ),
            ],
            const SizedBox(height: 16),
            _SectionCard(
              title: '1. Oyun modu',
              subtitle: 'Ne tür bir deneyim arıyorsun?',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: GameMode.values
                    .map(
                      (mode) => ChoiceChip(
                        label: Text(mode.label),
                        selected: selection.mode == mode,
                        onSelected: (_) => controller.selectMode(mode),
                      ),
                    )
                    .toList(),
              ),
            ),
            _SectionCard(
              title: '2. Tempo',
              subtitle: 'Ritmi nasıl olsun?',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: GameTempo.values
                    .map(
                      (tempo) => ChoiceChip(
                        label: Text(tempo.label),
                        selected: selection.tempo == tempo,
                        onSelected: (_) => controller.selectTempo(tempo),
                      ),
                    )
                    .toList(),
              ),
            ),
            _SectionCard(
              title: '3. Sosyal stil',
              subtitle: 'Tek başına mı, arkadaşlarla mı?',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: SocialStyle.values
                    .map(
                      (style) => ChoiceChip(
                        label: Text(style.label),
                        selected: selection.socialStyle == style,
                        onSelected: (_) => controller.selectSocialStyle(style),
                      ),
                    )
                    .toList(),
              ),
            ),
            _SectionCard(
              title: '4. Dünya teması',
              subtitle: 'Hangi atmosfer sana daha yakın?',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: WorldTheme.values
                    .map(
                      (theme) => ChoiceChip(
                        label: Text(theme.label),
                        selected: selection.theme == theme,
                        onSelected: (_) => controller.selectTheme(theme),
                      ),
                    )
                    .toList(),
              ),
            ),
            _SectionCard(
              title: '5. Zorluk seviyesi',
              subtitle: 'Ne kadar meydan okuma istiyorsun?',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: SkillLevel.values
                    .map(
                      (skillLevel) => ChoiceChip(
                        label: Text(skillLevel.label),
                        selected: selection.skillLevel == skillLevel,
                        onSelected: (_) =>
                            controller.selectSkillLevel(skillLevel),
                      ),
                    )
                    .toList(),
              ),
            ),
            _SectionCard(
              title: '6. Oturum süresi',
              subtitle: 'Bir seferde ne kadar oynamak istersin?',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: SessionLength.values
                    .map(
                      (sessionLength) => ChoiceChip(
                        label: Text(sessionLength.label),
                        selected: selection.sessionLength == sessionLength,
                        onSelected: (_) =>
                            controller.selectSessionLength(sessionLength),
                      ),
                    )
                    .toList(),
              ),
            ),
            if (generated != null) ...[
              const SizedBox(height: 8),
              GradientCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isComplete
                          ? 'Sana özel seçilen oyun'
                          : 'Şu ana kadar en uyumlu oyun',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      generated.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      generated.shortDescription,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      generated.experience,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (!isComplete) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Tüm adımları tamamladığında eşleşme daha da netleşir.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: generated.tags
                          .map((tag) => Chip(label: Text(tag)))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: controller.reset,
                            child: const Text('Seçimi sıfırla'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton(
                            onPressed: () => _openGame(context, generated),
                            child: const Text('Oyunu göster'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _BuilderProgressCard extends StatelessWidget {
  const _BuilderProgressCard({
    required this.selectedStepCount,
    required this.totalStepCount,
  });

  final int selectedStepCount;
  final int totalStepCount;

  @override
  Widget build(BuildContext context) {
    final progress = selectedStepCount / totalStepCount;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'İlerleme',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Text(
                  '$selectedStepCount/$totalStepCount adım',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
