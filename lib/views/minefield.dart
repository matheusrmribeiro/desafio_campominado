import 'package:desafio_campominado/controller/field_controller.dart';
import 'package:desafio_campominado/controller/minefield_controller.dart';
import 'package:flutter/material.dart';
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
            // TODO - Score, time, restart
            Container(
              child: Scoreboard(minefield: minefield),
            ),

            // Field 10x15
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 585,
                child: Card(
                  child: GridView.count(
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
                  )
                ),
              ),
            ),
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
        padding: EdgeInsets.only(left: 10, right: 10),
        height: 200,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Minas marcadas",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 18,
                      ),
                    ),
                    Observer(
                      builder: (_) {
                        return Text(minefield.flaggedMines.toString(),
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 18,
                          )
                        );
                      }
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Total minas",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 18,
                      ),
                    ),
                    Observer(
                      builder: (_) {
                        return Text(minefield.totalMines.toString(),
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 18,
                          )
                        );
                      }
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}