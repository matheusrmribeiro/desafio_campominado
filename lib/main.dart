import 'package:desafio_campominado/src/app/theme/appTheme.dart';

import 'src/app/pages/minesweeper/minesweeper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Campo minado",
      home: MinesWeeper(),
      theme: AppTheme.getTheme(),
    );
  }
}