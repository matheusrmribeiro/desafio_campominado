import 'package:desafio_campominado/model/minefield.dart';

class AppState{
  AppState({this.minefield, this.gameOver});

  final MineField minefield;
  final bool gameOver;

  AppState copy({MineField minefield, int totalMines, bool gameOver}) => AppState(
        minefield: minefield ?? this.minefield,
        gameOver: gameOver ?? this.gameOver
      );

  static AppState initialState() => AppState(minefield: null, gameOver: false);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          minefield == other.minefield &&
          gameOver == other.gameOver;

  @override
  int get hashCode => minefield.hashCode ^ gameOver.hashCode;
}