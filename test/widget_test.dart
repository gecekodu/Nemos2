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
      skillLevel: SkillLevel.orta,
      sessionLength: SessionLength.orta,
    );

    final library = [
      _game(
        id: '1',
        title: 'Exact',
        mode: GameMode.rekabet,
        tempo: GameTempo.hizli,
        socialStyle: SocialStyle.arkadaslarla,
        theme: WorldTheme.bilimKurgu,
        skillLevel: SkillLevel.orta,
        sessionLength: SessionLength.orta,
        tags: ['Rekabet', 'Hızlı', 'Orta', '20-30 dk'],
      ),
      _game(
        id: '2',
        title: 'Weak',
        mode: GameMode.rahat,
        tempo: GameTempo.orta,
        socialStyle: SocialStyle.tekKisilik,
        theme: WorldTheme.fantastik,
        skillLevel: SkillLevel.baslangic,
        sessionLength: SessionLength.uzun,
        tags: ['Rahat'],
      ),
    ];

    final result = matcher.match(selection: selection, library: library);

    expect(result.title, 'Exact');
  });

  test('game matcher supports partial selection without throwing', () {
    const matcher = GameMatcher();
    const selection = BuilderSelection(mode: GameMode.rekabet);

    final library = [
      _game(
        id: '1',
        title: 'Competitive Pick',
        mode: GameMode.rekabet,
        tempo: GameTempo.orta,
        socialStyle: SocialStyle.tekKisilik,
        theme: WorldTheme.fantastik,
        skillLevel: SkillLevel.baslangic,
        sessionLength: SessionLength.kisa,
        tags: ['Rekabet'],
      ),
      _game(
        id: '2',
        title: 'Relaxed Pick',
        mode: GameMode.rahat,
        tempo: GameTempo.orta,
        socialStyle: SocialStyle.tekKisilik,
        theme: WorldTheme.fantastik,
        skillLevel: SkillLevel.baslangic,
        sessionLength: SessionLength.kisa,
        tags: ['Rahat'],
      ),
    ];

    final result = matcher.match(selection: selection, library: library);

    expect(result.id, '1');
  });

  test('game matcher throws an error when library is empty', () {
    const matcher = GameMatcher();

    expect(
      () => matcher.match(
        selection: const BuilderSelection(),
        library: const [],
      ),
      throwsArgumentError,
    );
  });

  test('game matcher uses popularity as tie breaker for equal scores', () {
    const matcher = GameMatcher();
    const selection = BuilderSelection(mode: GameMode.hikaye);

    final library = [
      _game(
        id: 'a',
        title: 'Story Low',
        mode: GameMode.hikaye,
        tempo: GameTempo.orta,
        socialStyle: SocialStyle.tekKisilik,
        theme: WorldTheme.fantastik,
        skillLevel: SkillLevel.orta,
        sessionLength: SessionLength.orta,
        tags: ['Hikâye'],
        score: 90,
      ),
      _game(
        id: 'b',
        title: 'Story High',
        mode: GameMode.hikaye,
        tempo: GameTempo.orta,
        socialStyle: SocialStyle.tekKisilik,
        theme: WorldTheme.fantastik,
        skillLevel: SkillLevel.orta,
        sessionLength: SessionLength.orta,
        tags: ['Hikâye'],
        score: 100,
      ),
    ];

    final result = matcher.match(selection: selection, library: library);

    expect(result.id, 'b');
  });
}

GameProfile _game({
  required String id,
  required String title,
  required GameMode mode,
  required GameTempo tempo,
  required SocialStyle socialStyle,
  required WorldTheme theme,
  required SkillLevel skillLevel,
  required SessionLength sessionLength,
  required List<String> tags,
  int score = 0,
}) {
  return GameProfile(
    id: id,
    title: title,
    shortDescription: 'desc',
    experience: 'exp',
    htmlAssetPath: 'assets/games/html/duel_dash.html',
    mode: mode,
    tempo: tempo,
    socialStyle: socialStyle,
    theme: theme,
    skillLevel: skillLevel,
    sessionLength: sessionLength,
    tags: tags,
    likes: 0,
    comments: 0,
    score: score,
  );
}
