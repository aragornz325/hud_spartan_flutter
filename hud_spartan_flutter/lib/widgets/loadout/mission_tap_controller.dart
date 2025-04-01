import 'dart:async';

class MissionTapController {
  static final MissionTapController _instance = MissionTapController._internal();
  factory MissionTapController() => _instance;
  MissionTapController._internal();

  Completer<void>? _tapCompleter;

  Future<void> waitForTap() {
    _tapCompleter = Completer<void>();
    return _tapCompleter!.future;
  }

  void registerTap() {
    if (_tapCompleter != null && !_tapCompleter!.isCompleted) {
      _tapCompleter!.complete();
    }
  }
}
