import 'package:flutter/material.dart';
import 'views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  final ThemeData theme = ThemeData(
    primaryColor: Colors.orange,
    accentColor: Colors.teal,
    buttonColor: Colors.orange
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Campo minado",
      home: Home(),
      theme: theme,
    );
  }
}