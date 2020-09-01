import 'views/minesweeper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  final ThemeData theme = ThemeData(
    primaryColor: Colors.brown,
    accentColor: Colors.brown[300],
    buttonColor: Colors.orange
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Campo minado",
      home: MinesWeeper(),
      theme: theme,
    );
  }
}