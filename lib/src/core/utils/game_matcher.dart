import '../../features/games/domain/game_models.dart';

class GameMatcher {
  const GameMatcher();

  GameProfile match({
    required BuilderSelection selection,
    required List<GameProfile> library,
  }) {
    if (library.isEmpty) {
      throw ArgumentError.value(
        library,
        'library',
        'Game library cannot be empty.',
      );
    }

    final ranked = library
        .map(
          (game) => _RankedGame(
            game: game,
            score: _score(game, selection),
          ),
        )
        .toList()
      ..sort((left, right) {
        final scoreComparison = right.score.compareTo(left.score);
        if (scoreComparison != 0) {
          return scoreComparison;
        }

        final popularityComparison =
            right.game.score.compareTo(left.game.score);
        if (popularityComparison != 0) {
          return popularityComparison;
        }

        return left.game.id.compareTo(right.game.id);
      });

    return ranked.first.game;
  }

  int _score(GameProfile game, BuilderSelection selection) {
    var score = 0;

    final mode = selection.mode;
    if (mode != null) {
      if (game.mode == mode) {
        score += 24;
      }
      if (game.tags.contains(mode.label)) {
        score += 2;
      }
    }

    final tempo = selection.tempo;
    if (tempo != null) {
      if (game.tempo == tempo) {
        score += 20;
      }
      if (game.tags.contains(tempo.label)) {
        score += 2;
      }
    }

    if (selection.socialStyle != null &&
        game.socialStyle == selection.socialStyle) {
      score += 16;
    }

    if (selection.theme != null && game.theme == selection.theme) {
      score += 16;
    }

    final skillLevel = selection.skillLevel;
    if (skillLevel != null) {
      if (game.skillLevel == skillLevel) {
        score += 12;
      }
      if (game.tags.contains(skillLevel.label)) {
        score += 1;
      }
    }

    final sessionLength = selection.sessionLength;
    if (sessionLength != null) {
      if (game.sessionLength == sessionLength) {
        score += 12;
      }
      if (game.tags.contains(sessionLength.label)) {
        score += 1;
      }
    }

    return score;
  }
}

class _RankedGame {
  const _RankedGame({
    required this.game,
    required this.score,
  });

  final GameProfile game;
  final int score;
}
