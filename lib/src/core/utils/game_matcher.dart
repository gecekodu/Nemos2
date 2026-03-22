import '../../features/games/domain/game_models.dart';

class GameMatcher {
  const GameMatcher();

  GameProfile match({
    required BuilderSelection selection,
    required List<GameProfile> library,
  }) {
    final ranked = [...library]..sort(
      (left, right) => _score(right, selection).compareTo(_score(left, selection)),
    );
    return ranked.first;
  }

  int _score(GameProfile game, BuilderSelection selection) {
    var score = 0;

    if (game.mode == selection.mode) {
      score += 30;
    }
    if (game.tempo == selection.tempo) {
      score += 25;
    }
    if (game.socialStyle == selection.socialStyle) {
      score += 20;
    }
    if (game.theme == selection.theme) {
      score += 20;
    }
    if (game.tags.contains(selection.mode.label)) {
      score += 3;
    }
    if (game.tags.contains(selection.tempo.label)) {
      score += 2;
    }

    return score;
  }
}
