import 'package:flutter_test/flutter_test.dart';
import 'package:nemos/src/features/games/data/mock_game_repository.dart';
import 'package:nemos/src/features/games/domain/game_models.dart';
import 'package:nemos/src/features/games/presentation/controllers/builder_controller.dart';

void main() {
  late MockGameRepository repository;
  late BuilderController controller;

  setUp(() {
    repository = MockGameRepository();
    controller = BuilderController(repository: repository);
  });

  tearDown(() {
    controller.dispose();
  });

  test('starts with no generated recommendation', () {
    expect(controller.generated, isNull);
    expect(controller.selection.isComplete, isFalse);
  });

  test('generates a recommendation after first choice', () {
    controller.selectMode(GameMode.rekabet);

    expect(controller.generated, isNotNull);
    expect(controller.selection.mode, GameMode.rekabet);
  });

  test('returns the strongest match for a complete selection', () {
    controller.selectMode(GameMode.rekabet);
    controller.selectTempo(GameTempo.hizli);
    controller.selectTheme(WorldTheme.bilimKurgu);
    controller.selectSkillLevel(SkillLevel.orta);

    expect(controller.selection.isComplete, isTrue);
    expect(controller.generated, isNotNull);
  });

  test('reset clears recommendation and selection', () {
    controller.selectMode(GameMode.rekabet);
    expect(controller.generated, isNotNull);

    controller.reset();

    expect(controller.generated, isNull);
    expect(controller.selection.mode, isNull);
    expect(controller.selection.tempo, isNull);
    expect(controller.selection.theme, isNull);
    expect(controller.selection.skillLevel, isNull);
  });
}
