import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';

import 'package:desafio_campominado/controller/field_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'minefield_controller.g.dart';

class MineFieldController = _MineFieldController with _$MineFieldController;

enum Difficulty { easy, medium, hard }

abstract class _MineFieldController with Store {

  _MineFieldController({this.difficulty, this.totalMines}){
    initializeGame();
    dimension = _getDimension();
  }
  
  final Difficulty difficulty;
  final int totalMines;
  var dimension;

  @observable
  ObservableList<FieldController> fields;

  @observable
  bool gameOver = false;

  @observable
  bool initialized = false;

  @observable
  int hour = 0;

  @observable
  int minute = 0;

  Timer _timer;

  Map<String, FieldController> matrix = {};

  @action
  void initializeGame(){
    fields = buildFields();
  }

  @action
  void restart(){
    gameOver = false;
    initialized = false;
    matrix = {};
    fields.clear();
    _timer = null;
    minute = 0;
    hour = 0;
    initializeGame();
  }

  @action
  void onTap(FieldController field){
    if (!initialized)
      initialized = true;

    if ((gameOver) || (winner) || (field.hasFlag))
      return;
    
    if (field.hasMine){
      gameOver = true;

      fields.where((item) => item.hasMine).forEach((item){
        item.isCovered = false;
      });

      return;
    }

    uncoverAdjacentFields(field: field, 
      visited: {[field.posX, field.posY].toString(): false}, 
      clicked: true);
  }

  @action
  void onLongPress(FieldController field){
    if (!initialized)
      initialized = true;

    if ((gameOver) || (winner) || (field.hasFlag))
      return;

    if (field.isCovered)
      field.hasFlag=!field.hasFlag;
  }

  @computed
  get flaggedMines => totalMines - fields.where((item) => item.hasFlag).length;

  @computed
  bool get winner{
    bool isWinner = true;
    if (flaggedMines == 0){
      fields.where((item) => item.hasFlag).forEach((item){
        if (!item.hasMine){
          isWinner = false;
          return;
        }
          
      });
    }
    else
      isWinner = false;

    if (fields.where((item) => item.isCovered).length > 0)
      isWinner = false;

    return isWinner;
  }

  @computed
  String get time{
    if ((initialized) && (_timer == null)){
      final oneSec = const Duration(seconds: 1);
      _timer = Timer.periodic(oneSec,
        (Timer timer) {
          if (minute == 59){
            minute = 0;
            hour++;
          }
            
          minute++;    
        }
      );
    }

    if ((gameOver) || (winner))
      _timer.cancel();

    NumberFormat formatter = NumberFormat("00"); 

    return "${formatter.format(hour)}:${formatter.format(minute)}";
  }

  ObservableList<FieldController> buildFields(){
    final dimension = _getDimension();
    final dimensionLength = dimension[0]*dimension[1];
    
    int _line = 0;
    int _column = -1;
    List<int> mines = [];
    
    generateMines(mines, dimensionLength);

    fields = List.generate(dimensionLength, (index){
      if (_column >= dimension[0]-1){
        _line++;
        _column = 0;
      }
      else
        _column++;
      
      final field = FieldController(posX: _column, posY: _line, hasMine: mines.contains(index)??false); 

      matrix[[_column, _line].toString()] = field;
      return field;
    }).asObservable();

    _adjacentMines();

    return fields;
  }  

  void generateMines(List<int> mines, int dimensionLength){
    if (mines.length < totalMines){
      final tryMine = Random();
      int mine = tryMine.nextInt(dimensionLength);

      if (!mines.contains(mine))
        mines.add(tryMine.nextInt(dimensionLength));
      generateMines(mines, dimensionLength);
    }
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
    FieldController field = matrix[[x, y].toString()];

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

      if (!field.hasMine)
         field.minesAround = count;
    });
  }

  void uncoverAdjacentFields({@required FieldController field, Map<String, bool> visited, bool clicked = false}){
    if (field == null)
      return;

    int x = field.posX;
    int y = field.posY;

    if ((x >= 0) && (y >= 0 ) && (x < dimension[0]) && (y < dimension[1])){
      if (visited[[x, y].toString()]??false)
        return;
      else
        visited[[x,y].toString()]=true;
      
      if (field.hasMine)
        return;

      if (clicked)
        field.isCovered = false;
      else if (field.hasFlag)
        return;
      else if (field.minesAround == 0)
        field.isCovered = false;
      else if (field.minesAround > 0){
        field.isCovered = false;
        return;
      }
      else
        return;

      uncoverAdjacentFields(field: matrix[[x-1, y].toString()], visited: visited);
      uncoverAdjacentFields(field: matrix[[x+1, y].toString()], visited: visited);
      uncoverAdjacentFields(field: matrix[[x, y-1].toString()], visited: visited);
      uncoverAdjacentFields(field: matrix[[x, y+1].toString()], visited: visited);
    }
  }
}