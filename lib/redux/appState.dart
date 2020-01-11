import 'package:desafio_campominado/views/minefield.dart';

class AppState{
  AppState({this.minefield, this.totalMines, this.gameOver});

  final MineField minefield;
  final int totalMines;
  final bool gameOver;

  AppState copy({MineField minefield, int totalMines, bool gameOver}) => AppState(
        minefield: minefield ?? this.minefield,
        totalMines: totalMines ?? this.totalMines,
        gameOver: gameOver ?? this.gameOver
      );

  static AppState initialState() => AppState(minefield: null, totalMines: 0, gameOver: false);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          minefield == other.minefield &&
          totalMines == other.totalMines &&
          gameOver == other.gameOver;

  @override
  int get hashCode => minefield.hashCode ^ totalMines.hashCode ^ gameOver.hashCode;
}