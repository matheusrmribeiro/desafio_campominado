import 'package:async_redux/async_redux.dart';
import 'package:desafio_campominado/model/field.dart';
import 'package:flutter/material.dart';
import 'appState.dart';

class ClickAction extends ReduxAction<AppState> {
  final Field field;

  ClickAction({@required this.field}) : assert(field != null);

  @override
  AppState reduce() => state.copy(minefield: state.minefield);
}