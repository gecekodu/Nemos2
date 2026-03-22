import 'package:flutter/foundation.dart';

import '../../data/mock_game_repository.dart';
import '../../domain/game_models.dart';

class BuilderController extends ChangeNotifier {
  BuilderController({required MockGameRepository repository})
      : _repository = repository;

  final MockGameRepository _repository;
  BuilderSelection _selection = const BuilderSelection();
  GameProfile? _generated;

  BuilderSelection get selection => _selection;
  GameProfile? get generated => _generated;

  void selectMode(GameMode mode) {
    _selection = _selection.copyWith(mode: mode);
    _refresh();
  }

  void selectTempo(GameTempo tempo) {
    _selection = _selection.copyWith(tempo: tempo);
    _refresh();
  }

  void selectSocialStyle(SocialStyle socialStyle) {
    _selection = _selection.copyWith(socialStyle: socialStyle);
    _refresh();
  }

  void selectTheme(WorldTheme theme) {
    _selection = _selection.copyWith(theme: theme);
    _refresh();
  }

  void selectSkillLevel(SkillLevel skillLevel) {
    _selection = _selection.copyWith(skillLevel: skillLevel);
    _refresh();
  }

  void selectSessionLength(SessionLength sessionLength) {
    _selection = _selection.copyWith(sessionLength: sessionLength);
    _refresh();
  }

  void reset() {
    _selection = const BuilderSelection();
    _generated = null;
    notifyListeners();
  }

  void _refresh() {
    if (_selection.mode == null &&
        _selection.tempo == null &&
        _selection.socialStyle == null &&
        _selection.theme == null &&
        _selection.skillLevel == null &&
        _selection.sessionLength == null) {
      _generated = null;
    } else {
      _generated = _repository.generateForSelection(_selection);
    }
    notifyListeners();
  }
}
