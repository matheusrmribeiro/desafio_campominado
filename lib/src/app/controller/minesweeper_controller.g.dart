// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minesweeper_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MinesWeeperController on _MinesWeeperController, Store {
  Computed<int> _$totalMinesComputed;

  @override
  int get totalMines =>
      (_$totalMinesComputed ??= Computed<int>(() => super.totalMines,
              name: '_MinesWeeperController.totalMines'))
          .value;
  Computed<dynamic> _$flaggedMinesComputed;

  @override
  dynamic get flaggedMines =>
      (_$flaggedMinesComputed ??= Computed<dynamic>(() => super.flaggedMines,
              name: '_MinesWeeperController.flaggedMines'))
          .value;
  Computed<bool> _$winnerComputed;

  @override
  bool get winner => (_$winnerComputed ??= Computed<bool>(() => super.winner,
          name: '_MinesWeeperController.winner'))
      .value;
  Computed<String> _$timeComputed;

  @override
  String get time => (_$timeComputed ??= Computed<String>(() => super.time,
          name: '_MinesWeeperController.time'))
      .value;

  final _$difficultyAtom = Atom(name: '_MinesWeeperController.difficulty');

  @override
  Difficulty get difficulty {
    _$difficultyAtom.reportRead();
    return super.difficulty;
  }

  @override
  set difficulty(Difficulty value) {
    _$difficultyAtom.reportWrite(value, super.difficulty, () {
      super.difficulty = value;
    });
  }

  final _$fieldsAtom = Atom(name: '_MinesWeeperController.fields');

  @override
  ObservableList<FieldModel> get fields {
    _$fieldsAtom.reportRead();
    return super.fields;
  }

  @override
  set fields(ObservableList<FieldModel> value) {
    _$fieldsAtom.reportWrite(value, super.fields, () {
      super.fields = value;
    });
  }

  final _$gameOverAtom = Atom(name: '_MinesWeeperController.gameOver');

  @override
  bool get gameOver {
    _$gameOverAtom.reportRead();
    return super.gameOver;
  }

  @override
  set gameOver(bool value) {
    _$gameOverAtom.reportWrite(value, super.gameOver, () {
      super.gameOver = value;
    });
  }

  final _$initializedAtom = Atom(name: '_MinesWeeperController.initialized');

  @override
  bool get initialized {
    _$initializedAtom.reportRead();
    return super.initialized;
  }

  @override
  set initialized(bool value) {
    _$initializedAtom.reportWrite(value, super.initialized, () {
      super.initialized = value;
    });
  }

  final _$hourAtom = Atom(name: '_MinesWeeperController.hour');

  @override
  int get hour {
    _$hourAtom.reportRead();
    return super.hour;
  }

  @override
  set hour(int value) {
    _$hourAtom.reportWrite(value, super.hour, () {
      super.hour = value;
    });
  }

  final _$minuteAtom = Atom(name: '_MinesWeeperController.minute');

  @override
  int get minute {
    _$minuteAtom.reportRead();
    return super.minute;
  }

  @override
  set minute(int value) {
    _$minuteAtom.reportWrite(value, super.minute, () {
      super.minute = value;
    });
  }

  final _$keyAtom = Atom(name: '_MinesWeeperController.key');

  @override
  String get key {
    _$keyAtom.reportRead();
    return super.key;
  }

  @override
  set key(String value) {
    _$keyAtom.reportWrite(value, super.key, () {
      super.key = value;
    });
  }

  final _$onTapAsyncAction = AsyncAction('_MinesWeeperController.onTap');

  @override
  Future<void> onTap(FieldModel field) {
    return _$onTapAsyncAction.run(() => super.onTap(field));
  }

  final _$_MinesWeeperControllerActionController =
      ActionController(name: '_MinesWeeperController');

  @override
  void initializeGame() {
    final _$actionInfo = _$_MinesWeeperControllerActionController.startAction(
        name: '_MinesWeeperController.initializeGame');
    try {
      return super.initializeGame();
    } finally {
      _$_MinesWeeperControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void restart() {
    final _$actionInfo = _$_MinesWeeperControllerActionController.startAction(
        name: '_MinesWeeperController.restart');
    try {
      return super.restart();
    } finally {
      _$_MinesWeeperControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onLongPress(FieldModel field) {
    final _$actionInfo = _$_MinesWeeperControllerActionController.startAction(
        name: '_MinesWeeperController.onLongPress');
    try {
      return super.onLongPress(field);
    } finally {
      _$_MinesWeeperControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
difficulty: ${difficulty},
fields: ${fields},
gameOver: ${gameOver},
initialized: ${initialized},
hour: ${hour},
minute: ${minute},
key: ${key},
totalMines: ${totalMines},
flaggedMines: ${flaggedMines},
winner: ${winner},
time: ${time}
    ''';
  }
}
