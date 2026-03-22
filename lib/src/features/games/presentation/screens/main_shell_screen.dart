import 'package:flutter/material.dart';

import '../../data/mock_game_repository.dart';
import '../controllers/builder_controller.dart';
import '../../domain/game_models.dart';

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
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _HomeTab(repository: widget.repository),
      _DiscoverTab(repository: widget.repository),
      _BuildTab(
        repository: widget.repository,
        controller: widget.builderController,
      ),
      _LeaderboardTab(repository: widget.repository),
      _ProfileTab(repository: widget.repository),
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: currentIndex, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (value) => setState(() => currentIndex = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Ana Sayfa'),
          NavigationDestination(icon: Icon(Icons.play_circle_outline), label: 'Keşfet'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), label: 'Oluştur'),
          NavigationDestination(icon: Icon(Icons.emoji_events_outlined), label: 'Liderlik'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab({required this.repository});

  final MockGameRepository repository;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Nemos', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Türkçe sosyal oyun keşif uygulamasının ilk profesyonel Flutter temeli.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        _GradientCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ürün özeti', style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              _Bullet(text: '100 seçim ihtimali için kurgulanmış oyun oluşturma akışı'),
              _Bullet(text: '20 oyunluk başlangıç kütüphanesi ve editoryal eşleme sistemi'),
              _Bullet(text: 'TikTok/Reels tarzı kaydırmalı keşfet ekranı yaklaşımı'),
              _Bullet(text: 'Arkadaşlık sistemi, yorum, beğeni ve liderlik kurgusu'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('Öne çıkan oyunlar', style: theme.textTheme.titleLarge),
        const SizedBox(height: 12),
        ...repository.featuredGames.take(3).map((game) => _GameListCard(game: game)),
      ],
    );
  }
}

class _DiscoverTab extends StatelessWidget {
  const _DiscoverTab({required this.repository});

  final MockGameRepository repository;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: repository.featuredGames.length,
      itemBuilder: (context, index) {
        final game = repository.featuredGames[index];
        return Padding(
          padding: const EdgeInsets.all(20),
          child: _GradientCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text('Keşfet / Reels Akışı'),
                    ),
                    const Spacer(),
                    const Icon(Icons.more_horiz),
                  ],
                ),
                const Spacer(),
                Text(game.title, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text(game.shortDescription, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: game.tags.map((tag) => Chip(label: Text(tag))).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _StatColumn(icon: Icons.favorite_border, value: '${game.likes}'),
                    _StatColumn(icon: Icons.mode_comment_outlined, value: '${game.comments}'),
                    _StatColumn(icon: Icons.whatshot_outlined, value: '${game.score}'),
                    const Spacer(),
                    FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Oyunu Aç'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BuildTab extends StatelessWidget {
  const _BuildTab({
    required this.repository,
    required this.controller,
  });

  final MockGameRepository repository;
  final BuilderController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final selection = controller.selection;
        final generated = controller.generated;

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Oyununu oluştur', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              '${repository.totalPossibilityCount} ihtimal içinden sana en uygun oyunu getiriyoruz.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            _SectionCard(
              title: '1. Oyun modu',
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
            if (generated != null) ...[
              const SizedBox(height: 8),
              _GradientCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sana özel seçilen oyun', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    Text(generated.title, style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    Text(generated.shortDescription, style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 12),
                    Text(generated.experience, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: generated.tags.map((tag) => Chip(label: Text(tag))).toList(),
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
                            onPressed: () {},
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

class _LeaderboardTab extends StatelessWidget {
  const _LeaderboardTab({required this.repository});

  final MockGameRepository repository;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Liderlik sıralaması', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        ...repository.leaderboard.map(
          (entry) => Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('${entry.rank}')),
              title: Text(entry.player),
              subtitle: Text('Favori oyun: ${entry.favoriteGame}'),
              trailing: Text('${entry.points}'),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab({required this.repository});

  final MockGameRepository repository;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Profil ve arkadaşlar', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        _GradientCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('nemos_user', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
              SizedBox(height: 8),
              Text('Seviye 12 • 4 gündür aktif • 3 oyun favoride'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('Arkadaşlık sistemi', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        ...repository.friends.map(
          (friend) => Card(
            child: ListTile(
              leading: CircleAvatar(child: Text(friend.name.characters.first)),
              title: Text(friend.name),
              subtitle: Text('${friend.handle} • ${friend.status}'),
              trailing: Text('Lv.${friend.level}'),
            ),
          ),
        ),
      ],
    );
  }
}

class _GradientCard extends StatelessWidget {
  const _GradientCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7C3AED), Color(0xFF0EA5E9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: child,
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
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
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _GameListCard extends StatelessWidget {
  const _GameListCard({required this.game});

  final GameProfile game;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(game.title),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(game.shortDescription),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Icon(icon),
          const SizedBox(height: 6),
          Text(value),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 7),
            child: Icon(Icons.circle, size: 8),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
