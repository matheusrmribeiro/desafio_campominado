import 'dart:math';

import 'package:async_redux/async_redux.dart';
import 'package:desafio_campominado/redux/appState.dart';

import 'field.dart';

enum Difficulty { easy, medium, hard }

class MineField extends BaseModel<AppState>{
  
  MineField.build({this.difficulty, this.totalMines}){
    _buildFields();
  }

  final Difficulty difficulty;
  final int totalMines;
  List<Field> fields;
  List<List<int>> matrix;

  void _buildFields(){
    final dimension = _getDimension();
    final dimensionLength = dimension[0]*dimension[1];
    final tryMine = Random();
    int _line = 0;
    int _column = 0;
    List<int> mines = List.generate(totalMines, (_) => tryMine.nextInt(dimensionLength));

    fields = List.generate(dimensionLength, (index){
      if (_column == dimension[1]){
        _line++;
        _column = 0;
      }
      else
        _column++;
      
      matrix.add([_column, _line]);
      return Field(posX: _column, posY: _line, hasMine: mines.contains(index));
    });
  }

  List<int> _getDimension(){
    switch (difficulty) {
      case Difficulty.easy : /* [10x15] */
        return [10, 15]; 
      default:
        return [10, 15];
    }
  }


}