import 'package:flutter/material.dart';

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