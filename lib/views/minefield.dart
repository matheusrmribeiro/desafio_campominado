import 'package:desafio_campominado/controller/minefield_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../model/minefield.dart';

enum Choose { play, watch }

class MineField extends StatelessWidget {
  MineField(this.choose);
  final Choose choose;
  final MineFieldController minefield = MineFieldController();

  @override
  Widget build(BuildContext context) {
    minefield.initializeGame(difficulty: Difficulty.easy, totalMines: 10);

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            // TODO - Score, time, restart
            Container(

            ),

            // Field 10x15
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 585,
                child: Card(
                  child: Observer(
                    builder: (_) {
                      return GridView.count(
                        padding: EdgeInsets.all(0),
                        crossAxisCount: 10,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        children: minefield.fields.map((item){
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: (item.hasMine) ? Colors.red : (item.isCovered) ? Colors.grey : Colors.white,
                            ),
                            child: Center(
                              child: MaterialButton(
                                padding: EdgeInsets.all(0),
                                child: Text(item.minesAround.toString()),
                                onPressed: (){
                                  minefield.onClickItem(item);
                                },
                              ),
                            ),
                          );
                        }).toList()
                      );
                    }
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}