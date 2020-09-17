import 'package:desafio_campominado/src/app/theme/color_consts.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static final ThemeData themeLight = ThemeData(
    primaryColor: ThemeConsts.primaryColorLight,
    accentColor: ThemeConsts.accentColorLight,
  );

  static ThemeData getTheme(){
    return themeLight;
  }

}