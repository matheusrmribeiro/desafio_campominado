import 'package:desafio_campominado/controller/field_controller.dart';
import 'package:desafio_campominado/controller/minefield_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

enum Choose { play, watch }

class MineField extends StatelessWidget {
  MineField(this.choose);
  final Choose choose;

  @override
  Widget build(BuildContext context) {
    MineFieldController minefield = MineFieldController(difficulty: Difficulty.easy, totalMines: 10);

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Scoreboard(minefield: minefield),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 582,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Observer(
                        builder: (_) {
                          return GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(0),
                            crossAxisCount: 10,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            children: minefield.fields.map((item){
                              return FieldWidget(item: item, 
                                onTap: (){ minefield.onTap(item); },
                                onLongPress: (){ minefield.onLongPress(item); },
                              );
                            }).toList()
                          );
                        }
                      ),
                    ),
                    SelectableText("Meu código: M1N3012312",
                      style: TextStyle(
                        color: Colors.brown[200]
                      ),
                    )
                  ],
                ),
              ),
            ),
            Observer(
              builder: (_) {
                return Visibility(
                  visible: minefield.gameOver || minefield.winner,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      width: 110,
                      height: 52,
                      child: RaisedButton(
                        color: Colors.brown[300],
                        onPressed: (){
                          minefield.restart();
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
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 52,
                height: 52,
                margin: EdgeInsets.only(left: 15, bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(120),
                  border: Border.all(color: Colors.brown, width: 1.5)
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(120),
                  splashColor: Colors.brown[200],
                  onTap: (){ Navigator.of(context).pop(); },
                  child: Center(
                    child: Icon(Feather.arrow_left, color: Colors.brown,)
                  ),
                ),
              ),            
            ),
            Align(
              alignment: Alignment.center,
              child: Observer(
                builder: (_) {
                  return Visibility(
                    visible: minefield.winner,
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

class FieldWidget extends StatelessWidget {

  const FieldWidget({Key key, this.item, this.onTap, this.onLongPress}) : super(key: key);

  final FieldController item;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return GestureDetector(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Card(
            margin: EdgeInsets.all(0),
            color: item.color,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: item.borderColor),
                color: item.color,
                  borderRadius: BorderRadius.all(const Radius.circular(5),
                )
              ),
              child: Center(
                child: Container(
                    padding: EdgeInsets.all(0),
                    child: item.icon,
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

class Scoreboard extends StatelessWidget {

  const Scoreboard({Key key, this.minefield}) : super(key: key);

  final MineFieldController minefield;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        height: 200,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(120),
                    border: Border.all(color: Colors.brown, width: 1.5)
                  ),
                  child: Center(
                    child: Observer(
                      builder: (_) {
                        return Text(minefield.time,
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 18,
                          )
                        );
                      }
                    ),
                  ),
                ),                
                InfoBoard(
                  title: "Minas",
                  child: Observer(
                    builder: (_) {
                      return Text(minefield.flaggedMines.toString(),
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 18,
                        )
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