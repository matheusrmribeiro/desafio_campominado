import 'dart:math';
import 'package:flutter/material.dart';

import 'field.dart';

enum Difficulty { easy, medium, hard }

class MineField{
  
  MineField({this.difficulty, this.totalMines});
  
  final Difficulty difficulty;
  final int totalMines;
  List<Field> fields; 
  Map<String, Field> matrix = {};

  List<Field> buildFields(){
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
      
      final field = Field(posX: _column, posY: _line, hasMine: mines.contains(index)??false); 

      matrix[[_column, _line].toString()] = field;
      return field;
    });

    _adjacentMines();

    return fields;
  }

  List<int> _getDimension(){
    switch (difficulty) {
      case Difficulty.easy : /* [10x15] */
        return [10, 15]; 
      default:
        return [10, 15];
    }
  }

  bool _mineAt(int x, int y){
    Field field = matrix[[x, y].toString()];

    if (field == null)
      return false;
    else
      return field.hasMine;
  }

  void _adjacentMines(){
    fields.forEach((field){
      int count = 0;
      int x = field.posX;
      int y = field.posY;

      // left
      if (_mineAt(x-1, y+1)) count++; // top
      if (_mineAt(x-1, y)) count++; // middle
      if (_mineAt(x-1, y-1)) count++; // bottom

      // top
      if (_mineAt(x, y+1)) count++; // middle
      if (_mineAt(x+1, y+1)) count++; // right

      // right
      if (_mineAt(x+1, y)) count++; // middle
      if (_mineAt(x+1, y-1)) count++; // bottom

      // bottom
      if (_mineAt(x, y-1)) count++; // middle

      field.minesAround = count;
    });
  }

  void uncoverAdjacentFields({@required Field field, Map<String, bool> visited}){
    final dimension = _getDimension();

    if (field == null)
      return;

    int x = field.posX;
    int y = field.posY;

    if ((x >= 0) && (y >= 0 ) && (x < dimension[0]) && (y < dimension[1])){
      if (visited[[x, y].toString()])
        return;
      else
        visited[[x,y].toString()]=true;
      
      if (field.minesAround == 0)
        field.isCovered = false;
      else
        return

      uncoverAdjacentFields(field: matrix[[x-1, y]]);
      uncoverAdjacentFields(field: matrix[[x+1, y]]);
      uncoverAdjacentFields(field: matrix[[x, y-1]]);
      uncoverAdjacentFields(field: matrix[[x, y+1]]);
    }
  }

}