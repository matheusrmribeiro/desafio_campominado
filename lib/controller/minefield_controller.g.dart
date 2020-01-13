// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minefield_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MineFieldController on _MineFieldController, Store {
  final _$fieldsAtom = Atom(name: '_MineFieldController.fields');

  @override
  ObservableList<Field> get fields {
    _$fieldsAtom.context.enforceReadPolicy(_$fieldsAtom);
    _$fieldsAtom.reportObserved();
    return super.fields;
  }

  @override
  set fields(ObservableList<Field> value) {
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

  final _$_MineFieldControllerActionController =
      ActionController(name: '_MineFieldController');

  @override
  void initializeGame({Difficulty difficulty, int totalMines}) {
    final _$actionInfo = _$_MineFieldControllerActionController.startAction();
    try {
      return super
          .initializeGame(difficulty: difficulty, totalMines: totalMines);
    } finally {
      _$_MineFieldControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onClickItem(Field field) {
    final _$actionInfo = _$_MineFieldControllerActionController.startAction();
    try {
      return super.onClickItem(field);
    } finally {
      _$_MineFieldControllerActionController.endAction(_$actionInfo);
    }
  }
}
