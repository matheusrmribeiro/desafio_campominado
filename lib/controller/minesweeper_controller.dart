import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';

import '../model/field_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'minesweeper_controller.g.dart';

class MinesWeeperController = _MinesWeeperController with _$MinesWeeperController;

enum Difficulty { easy, medium, hard }

abstract class _MinesWeeperController with Store {

  _MinesWeeperController({this.difficulty}){
    firebaseLogin();
    initializeGame();
    dimension = _getDimension();
  }

  var dimension;
  List<int> mines = [];

  @observable
  Difficulty difficulty;

  @observable
  bool playing = true;

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

  String _documentId = "";
  List<String> onTapLog = [];
  List<String> onLongPressLog = [];
  String _documentIdListening = "";
  StreamSubscription<QuerySnapshot> subscription;

  Timer _timer;

  Map<String, FieldModel> matrix = {};

  @action
  void initializeGame() {
    buildFields();
  }

  @action
  Future<void> firebaseLogin() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    AuthResult request = await _firebaseAuth.signInAnonymously();
    key = request.user.uid;
  }

  @action
  void restart(){
    gameOver = false;
    initialized = false;
    matrix = {};
    if (fields.isNotEmpty)
      fields.clear();
    if (mines.isNotEmpty)
      mines = [];
    _timer = null;
    minute = 0;
    hour = 0;
    initializeGame();
  }

  @action
  Future<void> onTap(FieldModel field) async {
    if (!initialized){
      initialized = true;
      firebaseInitializeGame();
    }

    if ((gameOver) || (winner) || (field.hasFlag))
      return;

    if (playing){
      onTapLog.add([field.posX, field.posY].toString());
      firebaseOnTap();
    }

    if (field.hasMine){
      gameOver = true;

      firebaseFinalizeGame(gameOver: true);

      await uncoverMines(field);

      return;
    }

    uncoverAdjacentFields(field: field, 
      visited: {[field.posX, field.posY].toString(): false}, 
      clicked: true);
  }

  @action
  void onLongPress(FieldModel field){
    if (!initialized)
      initialized = true;

    if ((gameOver) || (winner))
      return;

    if (field.isCovered){
      field.hasFlag=!field.hasFlag;
      if (playing){
        onLongPressLog.add([field.posX, field.posY].toString());
        firebaseOnLongPress();
      }
    }
  }

  @action
  void setPlaying(){
    playing = true;
    subscription.cancel();
    restart();
  }

  @action
  void setWatching(String userKey){
    playing = false;
    
    List<String> longPressList = [];
    List<String> tapList = [];

    if (subscription != null)
      subscription.cancel();

    subscription = Firestore.instance.collection('minesweeper')
      .where("id", isEqualTo: userKey)
      .orderBy("date", descending: true)
      .limit(1).snapshots().listen((data){
        firebaseOnDataListen(data.documents.last, tapList, longPressList);
      });

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

    if (fields.where((item) => item.isCovered && !item.hasMine).length > 0)
      isWinner = false;

    if (isWinner)
      firebaseFinalizeGame(gameOver: false);

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

  void firebaseInitializeGame(){
    if (!playing)
      return;
      
    _documentId =  Firestore.instance.collection('minesweeper').document().documentID;
    Firestore.instance.collection('minesweeper').document(_documentId).setData(
      {
        'id': key,
        'date': Timestamp.now(),
        'difficulty': difficulty.index,
        'mines': mines,
        'winner': false,
        'gameOver': false
      }
    );
  }

  void firebaseOnDataListen(DocumentSnapshot document, List<String> tapList, List<String> longPressList){
    if (_documentIdListening != document.documentID){
      _documentIdListening = document.documentID;
      difficulty = Difficulty.values[document.data["difficulty"]];
      mines = List.castFrom(document.data["mines"]);
      tapList.clear();
      longPressList.clear();
      gameOver = false;
      initializeGame();
      initialized = true;
    }

    final List<String> onTapLog = List.castFrom(document.data["onTapLog"]??[]);
    final List<String> onLongPressLog = List.castFrom(document.data["onLongPressLog"]??[]);
    if (onTapLog.length > tapList.length){
      for (var item in onTapLog.where((item) => !tapList.contains(item) )){
        onTap(matrix[item]);
      }
    }

    if (onLongPressLog.length > tapList.length){
      for (var item in onLongPressLog.where((item) => !tapList.contains(item) )){
        onLongPress(matrix[item]);
      }
    }  
  }

  void firebaseOnTap(){
    if (!playing)
      return;

    Firestore.instance.collection('minesweeper').document(_documentId).setData(
      {
        'onTapLog': onTapLog
      },
      merge: true
    );
  }

  void firebaseOnLongPress(){
    if (!playing)
      return;

    Firestore.instance.collection('minesweeper').document(_documentId).setData(
      {
        'onLongPressLog': onLongPressLog
      },
      merge: true
    );
  }

  void firebaseFinalizeGame({ bool gameOver = false }){
    if (!playing)
      return;

    final data = (gameOver) ? { 'gameOver': true} : { 'winner': true };
    
    Firestore.instance.collection('minesweeper').document(_documentId).setData(
      data,
      merge: true
    );
  }

  void buildFields() async {
    final dimension = _getDimension();
    final dimensionLength = dimension[0]*dimension[1];
    
    int _line = 0;
    int _column = -1;
    
    if (mines.isEmpty)
      generateMines(dimensionLength);

      for (int index=0; index<dimensionLength; index++){
        if (_column >= dimension[0]-1){
          _line++;
          _column = 0;
        }
        else
          _column++;
        
        final field = FieldModel(posX: _column, posY: _line, hasMine: mines.contains(index)??false); 

        matrix[[_column, _line].toString()] = field;
        await Future.delayed(Duration(milliseconds: 5));
        fields.add(field);
      }

    _adjacentMines();
  }  

  void generateMines(int dimensionLength){
    if (mines.length < totalMines){
      final tryMine = Random();
      int mine = tryMine.nextInt(dimensionLength);

      if (!mines.contains(mine))
        mines.add(tryMine.nextInt(dimensionLength));
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

  bool _mineAt(int x, int y){
    FieldModel field = matrix[[x, y].toString()];

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

  Future<void> uncoverMines(FieldModel firstField) async {
      var fieldsWithMines = fields.where((item) => item.hasMine);

      firstField.isCovered = false;

      if (Vibration.hasVibrator() != null) {
        Vibration.vibrate(duration: 100);
      }
      
      await Future.delayed(Duration(milliseconds: 150));

      for (FieldModel item in fieldsWithMines) {
        item.isCovered = false;
        if (Vibration.hasVibrator() != null) {
          Vibration.vibrate(duration: 100);
        }
        await Future.delayed(Duration(milliseconds: 150));
      }
  }

  void uncoverAdjacentFields({@required FieldModel field, Map<String, bool> visited, bool clicked = false}){
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