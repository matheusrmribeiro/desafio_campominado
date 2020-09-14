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
            Column(
              children: [
                Container(
                  child: SettingsBoard(minesweeper: minesweeper),
                ),
                Align(
                  alignment: Alignment.center,
                  child: MineField(controller: minesweeper)
                ),
              ],
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
      // floatingActionButton: FloatingActions()
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
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text("Como jogar"),
                          content: Container(
                            height: MediaQuery.of(context).size.height*0.4,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("1. Ao tocar em algum campo, o mesmo será revelado."),
                                  SizedBox(height: 20,),
                                  Text("2. Ao manter o dedo pressionado em algum campo, o mesmo será marcado com uma bandeira, que indica que ali pode existir uma mina."),
                                  SizedBox(height: 20,),
                                  Text("3. Para remover uma bandeira, basta manter o dedo pressionado sobre ela."),
                                  SizedBox(height: 20,),
                                  Text("4. Você ganha o jogo quando marcar todas as minas e descobrir todos os campos sem minas."),
                                  SizedBox(height: 20,),
                                  Text("5. Você perde o jogo se clicar em algum campo que possuí alguma mina."),
                                  SizedBox(height: 20,),
                                ],
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              child: Text("Cancelar"),
                              onPressed: () => Navigator.of(context).pop(),
                            )
                          ],
                        );
                      }
                    );
                  },
                  child: Text("Ajuda", 
                  style: TextStyle(
                    color: Colors.white),
                  )
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