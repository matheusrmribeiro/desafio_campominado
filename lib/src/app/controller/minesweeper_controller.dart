import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';
import 'package:desafio_campominado/src/domain/model/field_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'minesweeper_controller.g.dart';

class MinesWeeperController = _MinesWeeperController with _$MinesWeeperController;

enum Difficulty { easy, medium, hard }

abstract class _MinesWeeperController with Store {

  _MinesWeeperController({this.difficulty}){
    initializeGame();
    dimension = _getDimension();
  }

  var dimension;
  List<int> mines = [];

  @observable
  Difficulty difficulty;

  @observable
  ObservableList<FieldModel> fields = <FieldModel>[].asObservable();

  @observable
  bool gameOver = false;

  @observable
  bool initialized = false;

  @observable
  int hour = 0;

  @observable
  int minute = 0;

  @observable
  String key = "";

  Timer _timer;

  Map<String, FieldModel> matrix = {};

  @action
  void initializeGame() {
    buildFields();
  }

  @action
  void restart(){
    gameOver = false;
    initialized = false;
    matrix = {};
    if (fields.isNotEmpty)
      fields.clear();
    mines = [];
    _timer = null;
    minute = 0;
    hour = 0;
    initializeGame();
  }

  @action
  Future<void> onTap(FieldModel field) async {
    if (!initialized)
      initialized = true;

    if ((!gameOver) && (!winner) && (!field.hasFlag)) {
      if (field.hasMine) {
        gameOver = true;
        await uncoverMines(field);
      } else {
        uncoverAdjacentFields(field: field, 
          visited: {[field.posX, field.posY].toString(): false}, 
          clicked: true);
      }
    }
  }

  @action
  void onLongPress(FieldModel field){
    if (!initialized)
      initialized = true;

    if ((!gameOver) || (!winner)) {
      if (field.isCovered)
        field.hasFlag=!field.hasFlag;
    }
  }

  @computed
  int get totalMines{
    Difficulty diff = difficulty;
    switch (diff) {
      case Difficulty.medium : 
        return 10;
      case Difficulty.hard :
        return 20;
      default:
        return 5;
    }
  }

  @computed
  get flaggedMines => totalMines - fields.where((item) => item.hasFlag).length;

  @computed
  bool get winner {
    bool isWinner = true;
    if (flaggedMines == 0) {
      fields.where((item) => item.hasFlag).forEach((item) {
        if (!item.hasMine){
          isWinner = false;
          return;
        }
      });
    } else
      isWinner = false;

    if (fields.where((item) => item.isCovered && !item.hasMine).length > 0)
      isWinner = false;

    return isWinner;
  }

  @computed
  String get time {
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

  void buildFields() async {
    final dimension = _getDimension();
    final dimensionLength = dimension[0] * dimension[1];
    
    int _line = 0;
    int _column = -1;
    
    if (mines.isEmpty)
      generateMines(dimensionLength);

      List<FieldModel> _fields = [];
      for (int index=0; index < dimensionLength; index++) {
        if (_column >= (dimension[0] - 1)){
          _line++;
          _column = 0;
        } else
          _column++;
        
        final field = FieldModel(
          posX: _column, 
          posY: _line, 
          hasMine: mines.contains(index) ?? false
        ); 

        matrix[[_column, _line].toString()] = field;
        // await Future.delayed(Duration(milliseconds: 5));

        _fields.add(field);
      }
      fields.addAll(_fields);

    _adjacentMines();
  }  

  void generateMines(int dimensionLength){
    if (mines.length < totalMines){
      final tryMine = Random();
      int mine = tryMine.nextInt(dimensionLength);

      if (!mines.contains(mine))
        mines.add(mine);
      
      generateMines(dimensionLength);
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


  void _adjacentMines() {
    bool _mineAt(int x, int y){
      FieldModel field = matrix[[x, y].toString()];

      if (field == null)
        return false;
      else
        return field.hasMine;
    }

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

  Future<void> uncoverMines(FieldModel firstField) async {
      var fieldsWithMines = fields.where((item) => item.hasMine);

      firstField.isCovered = false;

      if (Vibration.hasVibrator() != null)
        Vibration.vibrate(duration: 100);
      
      await Future.delayed(Duration(milliseconds: 150));

      for (FieldModel item in fieldsWithMines) {
        item.isCovered = false;

        if (Vibration.hasVibrator() != null)
          Vibration.vibrate(duration: 100);

        await Future.delayed(Duration(milliseconds: 150));
      }
  }

  void uncoverAdjacentFields({@required FieldModel field, Map<String, bool> visited, bool clicked = false}){
    if (field != null) {
      int x = field.posX;
      int y = field.posY;

      if ((x >= 0) && (y >= 0 ) && (x < dimension[0]) && (y < dimension[1])) {
        if (!(visited[[x, y].toString()] ?? false)) { // Not yet visited
          visited[[x,y].toString()] = true;
          
          if ((!field.hasMine) && (!field.hasFlag)) {
            bool uncoverAdjacents = false;

              field.isCovered = false;

            if (clicked)
              uncoverAdjacents = !(field.minesAround > 0);
            else if (field.minesAround == 0)
              uncoverAdjacents = true;

            if (uncoverAdjacents) {
              uncoverAdjacentFields(field: matrix[[x-1, y].toString()], visited: visited);
              uncoverAdjacentFields(field: matrix[[x+1, y].toString()], visited: visited);
              uncoverAdjacentFields(field: matrix[[x, y-1].toString()], visited: visited);
              uncoverAdjacentFields(field: matrix[[x, y+1].toString()], visited: visited);
              uncoverAdjacentFields(field: matrix[[x+1, y+1].toString()], visited: visited);
              uncoverAdjacentFields(field: matrix[[x-1, y+1].toString()], visited: visited);
              uncoverAdjacentFields(field: matrix[[x+1, y-1].toString()], visited: visited);
              uncoverAdjacentFields(field: matrix[[x-1, y-1].toString()], visited: visited);
            }
          }
        }
      }
    }
  }

}