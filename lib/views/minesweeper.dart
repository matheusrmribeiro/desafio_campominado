import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../views/minefield.dart';
import '../controller/minesweeper_controller.dart';
import '../views/floatingActions.dart';


class MinesWeeper extends StatelessWidget {
  final MinesWeeperController minesweeper = MinesWeeperController(difficulty: Difficulty.easy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: SettingsBoard(minesweeper: minesweeper),
            ),
            Align(
              alignment: Alignment.center,
              child: MineField(controller: minesweeper)
            ),
            Observer(
              builder: (_) {
                return Visibility(
                  visible: minesweeper.gameOver || minesweeper.winner || !minesweeper.playing,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      width: 110,
                      height: 52,
                      child: RaisedButton(
                        color: Colors.brown[300],
                        onPressed: (){
                          if (minesweeper.playing)
                            minesweeper.restart();
                          else
                            minesweeper.setPlaying();
                        },
                        child: Text((minesweeper.playing) ? "Recomeçar" : "Jogar",
                          style: TextStyle(
                            color: Colors.white
                          ),                  
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
            Align(
              alignment: Alignment.center,
              child: Observer(
                builder: (_) {
                  return Visibility(
                    visible: minesweeper.winner,
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(120),
                        border: Border.all(color: Colors.brown, width: 1.5),
                        color: Colors.brown
                      ),
                      child: Center(
                        child: Text("Você venceu!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActions()
    );
  }
}

class SettingsBoard extends StatelessWidget {

  const SettingsBoard({Key key, this.minesweeper}) : super(key: key);

  final MinesWeeperController minesweeper;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        height: 100,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InfoBoard(
                  title: "Dificuldade",
                  child: Observer(
                    builder: (_) {
                      var difficulties = ["Fácil", "Médio", "Difícil"];
                      return DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: minesweeper.difficulty.index,
                          items: difficulties.map((String item){
                            return DropdownMenuItem(
                              child: Text(item,
                                style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 15,
                                )
                              ),
                              value: difficulties.indexOf(item),
                            );
                          }).toList(),
                          onChanged: (int value){
                            minesweeper.difficulty = Difficulty.values[value];
                            minesweeper.restart();
                          },
                        ),
                      );
                    }
                  ),
                ),                
                InfoBoard(
                  title: "Minas",
                  child: Observer(
                    builder: (_) {
                      return SizedBox(
                        height: 45,
                        child: Center(
                          child: Text(minesweeper.flaggedMines.toString(),
                            style: TextStyle(
                              color: Colors.brown,
                              fontSize: 18,
                            )
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class InfoBoard extends StatelessWidget {

  const InfoBoard({Key key, this.child, this.title}) : super(key: key);

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Card(
        shape: Border.all(color: Colors.brown),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(5),
              color: Colors.brown[300],
              child: Text(title,
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}