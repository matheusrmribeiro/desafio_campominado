import 'package:desafio_campominado/model/field_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../controller/minesweeper_controller.dart';

class MineField extends StatelessWidget {
  const MineField({Key key, this.controller}) : super(key: key);

  final MinesWeeperController controller;

  @override
  Widget build(BuildContext context) {
    final minesweeperHeight = MediaQuery.of(context).size.height*0.6;
    final minesweeperWidth = MediaQuery.of(context).size.width*0.9;
    
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: minesweeperHeight,
      width: minesweeperWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Observer(
              builder: (_) {
                return Wrap(
                  spacing: 2,
                  runSpacing: 2,
                  direction: Axis.horizontal,
                  children: controller.fields.map((item){
                    return SizedBox(
                      height: (minesweeperHeight - 50) / 15,
                      width: (minesweeperWidth - 40) / 10,
                      child: FieldWidget(item: item, 
                        onTap: (){ 
                          if (controller.playing)
                            controller.onTap(item); 
                        },
                        onLongPress: (){
                          if (controller.playing)
                            controller.onLongPress(item);
                        },
                      ),
                    );
                  }).toList(),
                );
              }
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Observer(
                  builder: (_) {
                    return Text((controller.playing) ? "Jogando" : "Assistindo",
                      style: TextStyle(
                        color: Colors.brown[200]
                      ),
                    );
                  }
                ),
                Observer(
                  builder: (_) {
                    return Text(controller.time,
                      style: TextStyle(
                        color: Colors.brown[200]
                      )
                    );
                  }
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FieldWidget extends StatelessWidget {

  const FieldWidget({Key key, this.item, this.onTap, this.onLongPress}) : super(key: key);

  final FieldModel item;
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