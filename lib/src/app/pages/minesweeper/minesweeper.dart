import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'widgets/minefield.dart';
import '../../controller/minesweeper_controller.dart';
import 'widgets/settings_board.dart';

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
              height: 150,
              child: SettingsBoard(minesweeper: minesweeper),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: MineField(controller: minesweeper)
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Observer(
                builder: (_) {
                  return Visibility(
                    visible: minesweeper.gameOver || minesweeper.winner,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 15),
                        width: 110,
                        height: 52,
                        child: RaisedButton(
                          color: Colors.brown[300],
                          onPressed: (){
                            minesweeper.restart();
                          },
                          child: Text("Recomeçar",
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
    );
  }
}