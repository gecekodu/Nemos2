import 'package:flutter_test/flutter_test.dart';
import 'package:nemos/src/core/utils/game_matcher.dart';
import 'package:nemos/src/features/games/domain/game_models.dart';

void main() {
  test('game matcher returns the strongest matching game', () {
    const matcher = GameMatcher();
    const selection = BuilderSelection(
      mode: GameMode.rekabet,
      tempo: GameTempo.hizli,
      socialStyle: SocialStyle.arkadaslarla,
      theme: WorldTheme.bilimKurgu,
    );

    const library = [
      GameProfile(
        id: '1',
        title: 'Exact',
        shortDescription: 'desc',
        experience: 'exp',
        mode: GameMode.rekabet,
        tempo: GameTempo.hizli,
        socialStyle: SocialStyle.arkadaslarla,
        theme: WorldTheme.bilimKurgu,
        tags: ['Rekabet', 'Hızlı'],
        likes: 0,
        comments: 0,
        score: 0,
      ),
      GameProfile(
        id: '2',
        title: 'Weak',
        shortDescription: 'desc',
        experience: 'exp',
        mode: GameMode.rahat,
        tempo: GameTempo.orta,
        socialStyle: SocialStyle.tekKisilik,
        theme: WorldTheme.fantastik,
        tags: ['Rahat'],
        likes: 0,
        comments: 0,
        score: 0,
      ),
    ];

    final result = matcher.match(selection: selection, library: library);

    expect(result.title, 'Exact');
  });
}
