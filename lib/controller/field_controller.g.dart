// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FieldController on _FieldController, Store {
  final _$hasMineAtom = Atom(name: '_FieldController.hasMine');

  @override
  bool get hasMine {
    _$hasMineAtom.context.enforceReadPolicy(_$hasMineAtom);
    _$hasMineAtom.reportObserved();
    return super.hasMine;
  }

  @override
  set hasMine(bool value) {
    _$hasMineAtom.context.conditionallyRunInAction(() {
      super.hasMine = value;
      _$hasMineAtom.reportChanged();
    }, _$hasMineAtom, name: '${_$hasMineAtom.name}_set');
  }

  final _$hasFlagAtom = Atom(name: '_FieldController.hasFlag');

  @override
  bool get hasFlag {
    _$hasFlagAtom.context.enforceReadPolicy(_$hasFlagAtom);
    _$hasFlagAtom.reportObserved();
    return super.hasFlag;
  }

  @override
  set hasFlag(bool value) {
    _$hasFlagAtom.context.conditionallyRunInAction(() {
      super.hasFlag = value;
      _$hasFlagAtom.reportChanged();
    }, _$hasFlagAtom, name: '${_$hasFlagAtom.name}_set');
  }

  final _$isCoveredAtom = Atom(name: '_FieldController.isCovered');

  @override
  bool get isCovered {
    _$isCoveredAtom.context.enforceReadPolicy(_$isCoveredAtom);
    _$isCoveredAtom.reportObserved();
    return super.isCovered;
  }

  @override
  set isCovered(bool value) {
    _$isCoveredAtom.context.conditionallyRunInAction(() {
      super.isCovered = value;
      _$isCoveredAtom.reportChanged();
    }, _$isCoveredAtom, name: '${_$isCoveredAtom.name}_set');
  }

  final _$minesAroundAtom = Atom(name: '_FieldController.minesAround');

  @override
  int get minesAround {
    _$minesAroundAtom.context.enforceReadPolicy(_$minesAroundAtom);
    _$minesAroundAtom.reportObserved();
    return super.minesAround;
  }

  @override
  set minesAround(int value) {
    _$minesAroundAtom.context.conditionallyRunInAction(() {
      super.minesAround = value;
      _$minesAroundAtom.reportChanged();
    }, _$minesAroundAtom, name: '${_$minesAroundAtom.name}_set');
  }
}
