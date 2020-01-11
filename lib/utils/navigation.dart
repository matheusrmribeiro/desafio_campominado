import 'package:flutter/material.dart';

class Navigation {
  static void navigaTo(context, menu, {VoidCallback method}) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => menu,)).then((result){
        if(method != null)
          method();
      }
    );
  }
}