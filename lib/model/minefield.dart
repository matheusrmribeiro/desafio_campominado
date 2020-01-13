import 'dart:math';

import 'package:async_redux/async_redux.dart';
import 'package:desafio_campominado/redux/actions.dart';
import 'package:desafio_campominado/redux/appState.dart';
import 'package:desafio_campominado/views/minefield.dart';
import 'package:flutter/material.dart';

import 'field.dart';

enum Difficulty { easy, medium, hard }

class MineField extends BaseModel<AppState>{
  
  MineField(){
    _buildFields();
  }
  
  MineField.build({
    this.difficulty, 
    this.totalMines, 
    this.onClick}): super(equals: [difficulty, totalMines]);

  Difficulty difficulty;
  int totalMines;
  List<Field> fields;
  Map<List<int>, Field> matrix;
  Function(Field field) onClick;

  @override
  MineField fromStore() => MineField.build(
    difficulty: difficulty,
    totalMines: totalMines,
    onClick: (field) => dispatch(ClickAction(field: field)),
  );

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
      
      final field = Field(posX: _column, posY: _line, hasMine: mines.contains(index)); 

      matrix[[_column, _line]] = field;
      return field;
    });

    adjacentMines();
  }

  List<int> _getDimension(){
    switch (difficulty) {
      case Difficulty.easy : /* [10x15] */
        return [10, 15]; 
      default:
        return [10, 15];
    }
  }

  bool mineAt(int x, int y){
    return matrix[[x, y]].hasMine;
  }

  void adjacentMines(){
    fields.forEach((field){
      int count = 0;
      int x = field.posX;
      int y = field.posY;

      // left
      if (mineAt(x-1, y+1)) count++; // top
      if (mineAt(x-1, y)) count++; // middle
      if (mineAt(x-1, y-1)) count++; // bottom

      // top
      if (mineAt(x, y+1)) count++; // middle
      if (mineAt(x+1, y+1)) count++; // right

      // right
      if (mineAt(x+1, y)) count++; // middle
      if (mineAt(x+1, y-1)) count++; // bottom

      // bottom
      if (mineAt(x, y-1)) count++; // middle

      field.minesAround = count;
    });
  }

  void uncoverAdjacentFields({@required Field field, Map<List<int>, bool> visited}){
    final dimension = _getDimension();

    fields.forEach((field){
      int x = field.posX;
      int y = field.posY;

      if ((x >= 0) && (y >= 0 ) && (x < dimension[0]) && (y < dimension[1])){
        if (visited[[x, y]])
          return;
        else
          visited[[x,y]]=true;
        
        if (field.minesAround > 0)
          return

        uncoverAdjacentFields(field: matrix[[x-1, y]]);
        uncoverAdjacentFields(field: matrix[[x+1, y]]);
        uncoverAdjacentFields(field: matrix[[x, y-1]]);
        uncoverAdjacentFields(field: matrix[[x, y+1]]);
      }
    });
  }

}