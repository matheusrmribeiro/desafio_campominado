import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'redux/appState.dart';
import 'views/home.dart';

Store<AppState> store;

void main() {
  var state = AppState.initialState();
  store = Store<AppState>(initialState: state);
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
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Campo minado",
        home: Home(),
        theme: theme,
      ),
    );
  }
}