import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../model/field_model.dart';
import 'package:desafio_campominado/controller/minefield_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


class MineField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    MineFieldController minefield = MineFieldController(difficulty: Difficulty.easy);
    final primaryColor = Colors.brown;
    final accentColor = Colors.brown[400];

    final minefieldHeight = MediaQuery.of(context).size.height*0.6;
    final minefieldWidth = MediaQuery.of(context).size.width*0.9;

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: SettingsBoard(minefield: minefield),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: minefieldHeight,
                width: minefieldWidth,
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
                            children: minefield.fields.map((item){
                              return SizedBox(
                                height: (minefieldHeight - 50) / 15,
                                width: (minefieldWidth - 40) / 10,
                                child: FieldWidget(item: item, 
                                  onTap: (){ minefield.onTap(item); },
                                  onLongPress: (){ minefield.onLongPress(item); },
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
                              return Text((minefield.playing) ? "Jogando" : "Assistindo",
                                style: TextStyle(
                                  color: Colors.brown[200]
                                ),
                              );
                            }
                          ),
                          Observer(
                            builder: (_) {
                              return Text(minefield.time,
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
              ),
            ),
            Observer(
              builder: (_) {
                return Visibility(
                  visible: minefield.gameOver || minefield.winner || !minefield.playing,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      width: 110,
                      height: 52,
                      child: RaisedButton(
                        color: Colors.brown[300],
                        onPressed: (){
                          if (minefield.playing)
                            minefield.restart();
                          else
                            minefield.setPlaying();
                        },
                        child: Text((minefield.playing) ? "Recomeçar" : "Jogar",
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
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        overlayOpacity: 0.1,
        overlayColor: primaryColor,
        backgroundColor: primaryColor,
        tooltip: "Ações",
        children: [
          SpeedDialChild(
            label: "Compartilhar código",
            backgroundColor: accentColor,
            labelBackgroundColor: accentColor,
            labelStyle: TextStyle(
              color: Colors.white
            ),
            child: Icon(Icons.mobile_screen_share),
            onTap: () {
              Share.text("Meu código", minefield.key, "text/plain");
            }
          ),
          SpeedDialChild(
            label: "Assistir amigo",
            backgroundColor: accentColor,
            labelBackgroundColor: accentColor,
            labelStyle: TextStyle(
              color: Colors.white
            ),
            child: Icon(Icons.ondemand_video),
            onTap: (){
              showDialog(
                context: context,
                builder: (context){
                  final TextEditingController controller = TextEditingController();
                  return AlertDialog(
                    title: Text("Assistir"),
                    content: Container(
                      height: MediaQuery.of(context).size.height*0.4,
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: "Código do amigo"
                        )
                      )
                    ),
                    actions: <Widget>[
                      MaterialButton(
                        child: Text("Cancelar"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      MaterialButton(
                        child: Text("Assistir"),
                        onPressed: () { 
                          minefield.setWatching(controller.text);
                          Navigator.of(context).pop();
                         } 
                      )
                    ],
                  );
                }
              );
              
            }
          ),
          SpeedDialChild(
            label: "Ajuda",
            backgroundColor: accentColor,
            labelBackgroundColor: accentColor,
            labelStyle: TextStyle(
              color: Colors.white
            ),
            child: Icon(Icons.help),
            onTap: (){
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
          ),          
        ]
      )
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

class SettingsBoard extends StatelessWidget {

  const SettingsBoard({Key key, this.minefield}) : super(key: key);

  final MineFieldController minefield;

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
                          value: minefield.difficulty.index,
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
                            minefield.difficulty = Difficulty.values[value];
                            minefield.restart();
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