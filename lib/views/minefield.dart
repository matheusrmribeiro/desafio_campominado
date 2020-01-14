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
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: item.color,
            ),
            child: Center(
              child: Container(
                  padding: EdgeInsets.all(0),
                  child: item.icon,
              ),
            ),
          ),
        );
      }
    );
  }
}