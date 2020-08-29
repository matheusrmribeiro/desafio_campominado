// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FieldModel on _FieldModel, Store {
  Computed<String> _$minesAroundDescriptionComputed;

  @override
  String get minesAroundDescription => (_$minesAroundDescriptionComputed ??=
          Computed<String>(() => super.minesAroundDescription,
              name: '_FieldModel.minesAroundDescription'))
      .value;
  Computed<dynamic> _$colorComputed;

  @override
  dynamic get color => (_$colorComputed ??=
          Computed<dynamic>(() => super.color, name: '_FieldModel.color'))
      .value;
  Computed<dynamic> _$hintColorComputed;

  @override
  dynamic get hintColor =>
      (_$hintColorComputed ??= Computed<dynamic>(() => super.hintColor,
              name: '_FieldModel.hintColor'))
          .value;
  Computed<dynamic> _$borderColorComputed;

  @override
  dynamic get borderColor =>
      (_$borderColorComputed ??= Computed<dynamic>(() => super.borderColor,
              name: '_FieldModel.borderColor'))
          .value;
  Computed<Widget> _$iconComputed;

  @override
  Widget get icon => (_$iconComputed ??=
          Computed<Widget>(() => super.icon, name: '_FieldModel.icon'))
      .value;

  final _$hasMineAtom = Atom(name: '_FieldModel.hasMine');

  @override
  bool get hasMine {
    _$hasMineAtom.reportRead();
    return super.hasMine;
  }

  @override
  set hasMine(bool value) {
    _$hasMineAtom.reportWrite(value, super.hasMine, () {
      super.hasMine = value;
    });
  }

  final _$hasFlagAtom = Atom(name: '_FieldModel.hasFlag');

  @override
  bool get hasFlag {
    _$hasFlagAtom.reportRead();
    return super.hasFlag;
  }

  @override
  set hasFlag(bool value) {
    _$hasFlagAtom.reportWrite(value, super.hasFlag, () {
      super.hasFlag = value;
    });
  }

  final _$isCoveredAtom = Atom(name: '_FieldModel.isCovered');

  @override
  bool get isCovered {
    _$isCoveredAtom.reportRead();
    return super.isCovered;
  }

  @override
  set isCovered(bool value) {
    _$isCoveredAtom.reportWrite(value, super.isCovered, () {
      super.isCovered = value;
    });
  }

  final _$minesAroundAtom = Atom(name: '_FieldModel.minesAround');

  @override
  int get minesAround {
    _$minesAroundAtom.reportRead();
    return super.minesAround;
  }

  @override
  set minesAround(int value) {
    _$minesAroundAtom.reportWrite(value, super.minesAround, () {
      super.minesAround = value;
    });
  }

  @override
  String toString() {
    return '''
hasMine: ${hasMine},
hasFlag: ${hasFlag},
isCovered: ${isCovered},
minesAround: ${minesAround},
minesAroundDescription: ${minesAroundDescription},
color: ${color},
hintColor: ${hintColor},
borderColor: ${borderColor},
icon: ${icon}
    ''';
  }
}
