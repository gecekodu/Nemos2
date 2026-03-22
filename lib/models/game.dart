enum GameCategory { arcade, puzzle, strategy, adventure, party }
enum SessionType { solo, localMultiplayer, remoteMultiplayer }
enum ThemeStyle { retroNeon, minimal, fantasy, sciFi }
enum PlayTime { short, medium, long }
enum PackageStatus { ready, prototype, planned }

extension GameCategoryLabel on GameCategory {
  String get label {
    switch (this) {
      case GameCategory.arcade:
        return 'Arcade';
      case GameCategory.puzzle:
        return 'Bulmaca';
      case GameCategory.strategy:
        return 'Strateji';
      case GameCategory.adventure:
        return 'Macera';
      case GameCategory.party:
        return 'Parti';
    }
  }
}

extension SessionTypeLabel on SessionType {
  String get label {
    switch (this) {
      case SessionType.solo:
        return 'Tek Oyuncu';
      case SessionType.localMultiplayer:
        return 'Aynı Ekran Çoklu';
      case SessionType.remoteMultiplayer:
        return 'Uzaktan Çoklu';
    }
  }
}

extension ThemeStyleLabel on ThemeStyle {
  String get label {
    switch (this) {
      case ThemeStyle.retroNeon:
        return 'Retro Neon';
      case ThemeStyle.minimal:
        return 'Minimal';
      case ThemeStyle.fantasy:
        return 'Fantastik';
      case ThemeStyle.sciFi:
        return 'Bilim Kurgu';
    }
  }
}

extension PlayTimeLabel on PlayTime {
  String get label {
    switch (this) {
      case PlayTime.short:
        return '3-5 dk';
      case PlayTime.medium:
        return '5-10 dk';
      case PlayTime.long:
        return '10+ dk';
    }
  }
}

extension PackageStatusLabel on PackageStatus {
  String get label {
    switch (this) {
      case PackageStatus.ready:
        return 'Hazır';
      case PackageStatus.prototype:
        return 'Prototip';
      case PackageStatus.planned:
        return 'Planlandı';
    }
  }
}

class GameConcept {
  const GameConcept({
    required this.id,
    required this.title,
    required this.category,
    required this.sessionType,
    required this.theme,
    required this.playTime,
    required this.pitch,
    required this.mechanics,
    required this.monetizationHint,
    required this.packageStatus,
    required this.htmlDelivery,
    required this.multiplayerNote,
  });

  final String id;
  final String title;
  final GameCategory category;
  final SessionType sessionType;
  final ThemeStyle theme;
  final PlayTime playTime;
  final String pitch;
  final List<String> mechanics;
  final String monetizationHint;
  final PackageStatus packageStatus;
  final String htmlDelivery;
  final String multiplayerNote;
}

class SelectionState {
  const SelectionState({
    this.category,
    this.sessionType,
    this.theme,
    this.playTime,
  });

  final GameCategory? category;
  final SessionType? sessionType;
  final ThemeStyle? theme;
  final PlayTime? playTime;

  SelectionState copyWith({
    GameCategory? category,
    SessionType? sessionType,
    ThemeStyle? theme,
    PlayTime? playTime,
  }) {
    return SelectionState(
      category: category ?? this.category,
      sessionType: sessionType ?? this.sessionType,
      theme: theme ?? this.theme,
      playTime: playTime ?? this.playTime,
    );
  }
}
