// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minefield_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MineFieldController on _MineFieldController, Store {
  Computed<int> _$totalMinesComputed;

  @override
  int get totalMines =>
      (_$totalMinesComputed ??= Computed<int>(() => super.totalMines)).value;
  Computed<dynamic> _$flaggedMinesComputed;

  @override
  dynamic get flaggedMines =>
      (_$flaggedMinesComputed ??= Computed<dynamic>(() => super.flaggedMines))
          .value;
  Computed<bool> _$winnerComputed;

  @override
  bool get winner =>
      (_$winnerComputed ??= Computed<bool>(() => super.winner)).value;
  Computed<String> _$timeComputed;

  @override
  String get time =>
      (_$timeComputed ??= Computed<String>(() => super.time)).value;

  final _$difficultyAtom = Atom(name: '_MineFieldController.difficulty');

  @override
  Difficulty get difficulty {
    _$difficultyAtom.context.enforceReadPolicy(_$difficultyAtom);
    _$difficultyAtom.reportObserved();
    return super.difficulty;
  }

  @override
  set difficulty(Difficulty value) {
    _$difficultyAtom.context.conditionallyRunInAction(() {
      super.difficulty = value;
      _$difficultyAtom.reportChanged();
    }, _$difficultyAtom, name: '${_$difficultyAtom.name}_set');
  }

  final _$playingAtom = Atom(name: '_MineFieldController.playing');

  @override
  bool get playing {
    _$playingAtom.context.enforceReadPolicy(_$playingAtom);
    _$playingAtom.reportObserved();
    return super.playing;
  }

  @override
  set playing(bool value) {
    _$playingAtom.context.conditionallyRunInAction(() {
      super.playing = value;
      _$playingAtom.reportChanged();
    }, _$playingAtom, name: '${_$playingAtom.name}_set');
  }

  final _$fieldsAtom = Atom(name: '_MineFieldController.fields');

  @override
  ObservableList<FieldModel> get fields {
    _$fieldsAtom.context.enforceReadPolicy(_$fieldsAtom);
    _$fieldsAtom.reportObserved();
    return super.fields;
  }

  @override
  set fields(ObservableList<FieldModel> value) {
    _$fieldsAtom.context.conditionallyRunInAction(() {
      super.fields = value;
      _$fieldsAtom.reportChanged();
    }, _$fieldsAtom, name: '${_$fieldsAtom.name}_set');
  }

  final _$gameOverAtom = Atom(name: '_MineFieldController.gameOver');

  @override
  bool get gameOver {
    _$gameOverAtom.context.enforceReadPolicy(_$gameOverAtom);
    _$gameOverAtom.reportObserved();
    return super.gameOver;
  }

  @override
  set gameOver(bool value) {
    _$gameOverAtom.context.conditionallyRunInAction(() {
      super.gameOver = value;
      _$gameOverAtom.reportChanged();
    }, _$gameOverAtom, name: '${_$gameOverAtom.name}_set');
  }

  final _$initializedAtom = Atom(name: '_MineFieldController.initialized');

  @override
  bool get initialized {
    _$initializedAtom.context.enforceReadPolicy(_$initializedAtom);
    _$initializedAtom.reportObserved();
    return super.initialized;
  }

  @override
  set initialized(bool value) {
    _$initializedAtom.context.conditionallyRunInAction(() {
      super.initialized = value;
      _$initializedAtom.reportChanged();
    }, _$initializedAtom, name: '${_$initializedAtom.name}_set');
  }

  final _$hourAtom = Atom(name: '_MineFieldController.hour');

  @override
  int get hour {
    _$hourAtom.context.enforceReadPolicy(_$hourAtom);
    _$hourAtom.reportObserved();
    return super.hour;
  }

  @override
  set hour(int value) {
    _$hourAtom.context.conditionallyRunInAction(() {
      super.hour = value;
      _$hourAtom.reportChanged();
    }, _$hourAtom, name: '${_$hourAtom.name}_set');
  }

  final _$minuteAtom = Atom(name: '_MineFieldController.minute');

  @override
  int get minute {
    _$minuteAtom.context.enforceReadPolicy(_$minuteAtom);
    _$minuteAtom.reportObserved();
    return super.minute;
  }

  @override
  set minute(int value) {
    _$minuteAtom.context.conditionallyRunInAction(() {
      super.minute = value;
      _$minuteAtom.reportChanged();
    }, _$minuteAtom, name: '${_$minuteAtom.name}_set');
  }

  final _$keyAtom = Atom(name: '_MineFieldController.key');

  @override
  String get key {
    _$keyAtom.context.enforceReadPolicy(_$keyAtom);
    _$keyAtom.reportObserved();
    return super.key;
  }

  @override
  set key(String value) {
    _$keyAtom.context.conditionallyRunInAction(() {
      super.key = value;
      _$keyAtom.reportChanged();
    }, _$keyAtom, name: '${_$keyAtom.name}_set');
  }

  final _$firebaseLoginAsyncAction = AsyncAction('firebaseLogin');

  @override
  Future<void> firebaseLogin() {
    return _$firebaseLoginAsyncAction.run(() => super.firebaseLogin());
  }

  final _$onTapAsyncAction = AsyncAction('onTap');

  @override
  Future<void> onTap(FieldModel field) {
    return _$onTapAsyncAction.run(() => super.onTap(field));
  }

  final _$_MineFieldControllerActionController =
      ActionController(name: '_MineFieldController');

  @override
  void initializeGame() {
    final _$actionInfo = _$_MineFieldControllerActionController.startAction();
    try {
      return super.initializeGame();
    } finally {
      _$_MineFieldControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void restart() {
    final _$actionInfo = _$_MineFieldControllerActionController.startAction();
    try {
      return super.restart();
    } finally {
      _$_MineFieldControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onLongPress(FieldModel field) {
    final _$actionInfo = _$_MineFieldControllerActionController.startAction();
    try {
      return super.onLongPress(field);
    } finally {
      _$_MineFieldControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlaying() {
    final _$actionInfo = _$_MineFieldControllerActionController.startAction();
    try {
      return super.setPlaying();
    } finally {
      _$_MineFieldControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWatching(String userKey) {
    final _$actionInfo = _$_MineFieldControllerActionController.startAction();
    try {
      return super.setWatching(userKey);
    } finally {
      _$_MineFieldControllerActionController.endAction(_$actionInfo);
    }
  }
}
