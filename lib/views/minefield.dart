import 'package:flutter/material.dart';

enum Choose { play, watch }

class MineField extends StatelessWidget {
  MineField(this.choose);
  final Choose choose;

  @override
  Widget build(BuildContext context) {
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
                    children: List.generate(150, (index){
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)
                        ),
                        child: Center(
                          child: MaterialButton(
                            padding: EdgeInsets.all(0),
                            child: Text(index.toString()),
                            onPressed: (){},
                          ),
                        ),
                      );
                    })
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