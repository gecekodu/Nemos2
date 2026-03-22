import 'package:flutter/foundation.dart';

enum GameMode { rekabet, rahat, hikaye, parti, strateji }

enum GameTempo { hizli, orta, uzun, refleks, dusunerek }

enum SocialStyle { tekKisilik, arkadaslarla }

enum WorldTheme { fantastik, bilimKurgu }

enum SkillLevel { baslangic, orta, uzman }

enum SessionLength { cokKisa, kisa, orta, uzun }

enum FeedReaction { begeni, favori, ates }

extension GameModeX on GameMode {
  String get label => switch (this) {
        GameMode.rekabet => 'Rekabet',
        GameMode.rahat => 'Rahat',
        GameMode.hikaye => 'Hikâye',
        GameMode.parti => 'Parti',
        GameMode.strateji => 'Strateji',
      };
}

extension GameTempoX on GameTempo {
  String get label => switch (this) {
        GameTempo.hizli => 'Hızlı',
        GameTempo.orta => 'Orta',
        GameTempo.uzun => 'Uzun',
        GameTempo.refleks => 'Refleks',
        GameTempo.dusunerek => 'Düşünerek',
      };
}

extension SocialStyleX on SocialStyle {
  String get label => switch (this) {
        SocialStyle.tekKisilik => 'Tek başıma',
        SocialStyle.arkadaslarla => 'Arkadaşlarla',
      };
}

extension WorldThemeX on WorldTheme {
  String get label => switch (this) {
        WorldTheme.fantastik => 'Fantastik',
        WorldTheme.bilimKurgu => 'Bilim kurgu',
      };
}

extension SkillLevelX on SkillLevel {
  String get label => switch (this) {
        SkillLevel.baslangic => 'Başlangıç',
        SkillLevel.orta => 'Orta',
        SkillLevel.uzman => 'Uzman',
      };
}

extension SessionLengthX on SessionLength {
  String get label => switch (this) {
        SessionLength.cokKisa => '5-10 dk',
        SessionLength.kisa => '10-20 dk',
        SessionLength.orta => '20-30 dk',
        SessionLength.uzun => '30+ dk',
      };
}

@immutable
class BuilderSelection {
  const BuilderSelection({
    this.mode,
    this.tempo,
    this.socialStyle,
    this.theme,
    this.skillLevel,
    this.sessionLength,
  });

  final GameMode? mode;
  final GameTempo? tempo;
  final SocialStyle? socialStyle;
  final WorldTheme? theme;
  final SkillLevel? skillLevel;
  final SessionLength? sessionLength;

  bool get isComplete =>
      mode != null &&
      tempo != null &&
      socialStyle != null &&
      theme != null &&
      skillLevel != null &&
      sessionLength != null;

  BuilderSelection copyWith({
    GameMode? mode,
    GameTempo? tempo,
    SocialStyle? socialStyle,
    WorldTheme? theme,
    SkillLevel? skillLevel,
    SessionLength? sessionLength,
  }) {
    return BuilderSelection(
      mode: mode ?? this.mode,
      tempo: tempo ?? this.tempo,
      socialStyle: socialStyle ?? this.socialStyle,
      theme: theme ?? this.theme,
      skillLevel: skillLevel ?? this.skillLevel,
      sessionLength: sessionLength ?? this.sessionLength,
    );
  }
}

@immutable
class GameProfile {
  const GameProfile({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.experience,
    required this.htmlAssetPath,
    required this.mode,
    required this.tempo,
    required this.socialStyle,
    required this.theme,
    required this.skillLevel,
    required this.sessionLength,
    required this.tags,
    required this.likes,
    required this.comments,
    required this.score,
  });

  final String id;
  final String title;
  final String shortDescription;
  final String experience;
  final String htmlAssetPath;
  final GameMode mode;
  final GameTempo tempo;
  final SocialStyle socialStyle;
  final WorldTheme theme;
  final SkillLevel skillLevel;
  final SessionLength sessionLength;
  final List<String> tags;
  final int likes;
  final int comments;
  final int score;
}

@immutable
class FriendProfile {
  const FriendProfile({
    required this.name,
    required this.handle,
    required this.level,
    required this.status,
  });

  final String name;
  final String handle;
  final int level;
  final String status;
}

@immutable
class LeaderboardEntry {
  const LeaderboardEntry({
    required this.rank,
    required this.player,
    required this.points,
    required this.favoriteGame,
  });

  final int rank;
  final String player;
  final int points;
  final String favoriteGame;
}
