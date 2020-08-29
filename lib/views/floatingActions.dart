import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../controller/minesweeper_controller.dart';

class FloatingActions extends StatelessWidget {
  FloatingActions({Key key, this.controller}) : super(key: key);

  final MinesWeeperController controller;
  final primaryColor = Colors.brown;
  final accentColor = Colors.brown[400];
  
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
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
            Share.text("Meu código", controller.key, "text/plain");
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
                final TextEditingController textController = TextEditingController();
                return AlertDialog(
                  title: Text("Assistir"),
                  content: Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    child: TextField(
                      controller: textController,
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
    );
  }
}