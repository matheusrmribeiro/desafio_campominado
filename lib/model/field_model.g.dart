// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FieldModel on _FieldModel, Store {
  Computed<String> _$minesAroundDescriptionComputed;

  @override
  String get minesAroundDescription => (_$minesAroundDescriptionComputed ??=
          Computed<String>(() => super.minesAroundDescription))
      .value;
  Computed<dynamic> _$colorComputed;

  @override
  dynamic get color =>
      (_$colorComputed ??= Computed<dynamic>(() => super.color)).value;
  Computed<dynamic> _$hintColorComputed;

  @override
  dynamic get hintColor =>
      (_$hintColorComputed ??= Computed<dynamic>(() => super.hintColor)).value;
  Computed<dynamic> _$borderColorComputed;

  @override
  dynamic get borderColor =>
      (_$borderColorComputed ??= Computed<dynamic>(() => super.borderColor))
          .value;
  Computed<Widget> _$iconComputed;

  @override
  Widget get icon =>
      (_$iconComputed ??= Computed<Widget>(() => super.icon)).value;

  final _$hasMineAtom = Atom(name: '_FieldModel.hasMine');

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

  final _$hasFlagAtom = Atom(name: '_FieldModel.hasFlag');

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

  final _$isCoveredAtom = Atom(name: '_FieldModel.isCovered');

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

  final _$minesAroundAtom = Atom(name: '_FieldModel.minesAround');

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
