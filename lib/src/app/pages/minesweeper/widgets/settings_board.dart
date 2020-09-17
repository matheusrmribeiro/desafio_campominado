import 'package:desafio_campominado/src/app/controller/minesweeper_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'info_board.dart';

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