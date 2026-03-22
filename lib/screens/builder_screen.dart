import 'package:flutter/material.dart';
import 'package:nemos/data/game_data.dart';
import 'package:nemos/models/game.dart';

class BuilderScreen extends StatefulWidget {
  const BuilderScreen({super.key});

  @override
  State<BuilderScreen> createState() => _BuilderScreenState();
}

class _BuilderScreenState extends State<BuilderScreen> {
  int currentStepIndex = 0;
  SelectionState selection = const SelectionState();

  void handleSelection(dynamic option) {
    setState(() {
      switch (currentStepIndex) {
        case 0:
          selection = selection.copyWith(category: option as GameCategory);
          break;
        case 1:
          selection = selection.copyWith(sessionType: option as SessionType);
          break;
        case 2:
          selection = selection.copyWith(theme: option as ThemeStyle);
          break;
        case 3:
          selection = selection.copyWith(playTime: option as PlayTime);
          break;
      }

      currentStepIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isComplete = currentStepIndex >= builderSteps.length;
    final result = generateGameConcept(selection);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _HeroCard(),
        const SizedBox(height: 16),
        if (!isComplete)
          _StepCard(
            stepIndex: currentStepIndex,
            onSelect: handleSelection,
          )
        else
          _ResultCard(
            result: result,
            onRestart: () {
              setState(() {
                currentStepIndex = 0;
                selection = const SelectionState();
              });
            },
          ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF101A33),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nemos Builder', style: TextStyle(color: Color(0xFF7DD3FC), fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text(
            'HTML oyun fikirlerini mobil ürüne çeviren seçim akışı',
            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text(
            'Kullanıcı birkaç adımda seçim yapar, sistem uygun oyunu seçer ve hazır ürün hissi verir.',
            style: TextStyle(color: Color(0xFFCBD5E1), height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.stepIndex, required this.onSelect});

  final int stepIndex;
  final void Function(dynamic option) onSelect;

  @override
  Widget build(BuildContext context) {
    final step = builderSteps[stepIndex];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Adım ${stepIndex + 1} / ${builderSteps.length}', style: const TextStyle(color: Color(0xFF94A3B8))),
          const SizedBox(height: 8),
          Text(step.title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(step.description, style: const TextStyle(color: Color(0xFFCBD5E1))),
          const SizedBox(height: 16),
          ...step.options.map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF172554),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  ),
                  onPressed: () => onSelect(option),
                  child: Text(_labelForOption(option)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _labelForOption(dynamic option) {
    if (option is GameCategory) return option.label;
    if (option is SessionType) return option.label;
    if (option is ThemeStyle) return option.label;
    if (option is PlayTime) return option.label;
    return option.toString();
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result, required this.onRestart});

  final GameConcept result;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Oyun sonucu hazır', style: TextStyle(color: Color(0xFF94A3B8))),
          const SizedBox(height: 8),
          Text(result.title, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(result.pitch, style: const TextStyle(color: Color(0xFFCBD5E1), height: 1.5)),
          const SizedBox(height: 16),
          Text(result.htmlDelivery, style: const TextStyle(color: Color(0xFFDBEAFE))),
          const SizedBox(height: 16),
          const Text('Önerilen mekanikler', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...result.mechanics.map((item) => Text('• $item', style: const TextStyle(color: Color(0xFFCBD5E1)))),
          const SizedBox(height: 12),
          Text('Multiplayer notu: ${result.multiplayerNote}', style: const TextStyle(color: Color(0xFFDBEAFE))),
          const SizedBox(height: 12),
          Text('Ürün notu: ${result.monetizationHint}', style: const TextStyle(color: Color(0xFFDBEAFE))),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(onPressed: onRestart, child: const Text('Yeni seçim başlat')),
          ),
        ],
      ),
    );
  }
}
