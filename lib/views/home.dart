import 'package:flutter/material.dart';
import '../utils/navigation.dart';
import 'minefield.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 100,
                  padding: EdgeInsets.only(top: 50),
                  child: Text("Campo minado",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width*0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 120,
                        child: RaisedButton(
                          child: Text("Jogar"),
                          onPressed: (){
                            Navigation.navigaTo(context, MineField());
                          },
                        ),
                      ),
                      Container(
                        width: 120,
                        child: RaisedButton(
                          child: Text("Assistir"),
                          onPressed: (){
                            Navigation.navigaTo(context, MineField());
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}