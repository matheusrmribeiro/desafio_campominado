import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobx/mobx.dart';

part 'field_model.g.dart';

class FieldModel = _FieldModel with _$FieldModel;

abstract class _FieldModel with Store {
  
  _FieldModel({
    this.posX, 
    this.posY, 
    this.isCovered = true, 
    this.hasMine = false, 
    this.hasFlag = false, 
    this.minesAround = 0
  });

  final int posX;
  final int posY;

  @observable
  bool hasMine = false;

  @observable
  bool hasFlag = false;

  @observable
  bool isCovered = true;

  @observable
  int minesAround = 0;

  @computed
  String get minesAroundDescription => ((isCovered) || (minesAround == 0)) 
    ? "" 
    : minesAround.toString();

  @computed
  get color {
    MaterialColor currentColor = Colors.white;

    if (isCovered) 
      currentColor = Colors.brown[200];
    else if (hasMine)
      currentColor = Colors.red;
    
    return currentColor;
  }

  @computed
  get hintColor{
    switch (minesAround) {
      case 0 : return Colors.transparent;
      case 1 : return Colors.blue;
      case 2 : return Colors.green;
      case 3 : return Colors.orange;
      default: return Colors.red;
    }
  }

  @computed
  get borderColor {
    MaterialColor currentColor = Colors.grey;

    if (!isCovered)
      currentColor = hintColor;
    else if (hasFlag)
      currentColor = Colors.red;

    return currentColor;
  }

  @computed
  Widget get icon {
    Widget currentWidget = Text(minesAroundDescription,
      style: TextStyle(
        color: hintColor
      ),
    );

    if ((hasMine) && (!isCovered))
      currentWidget = Icon(Feather.cpu, color: Colors.black);
    else if (hasFlag)
      currentWidget = Icon(Ionicons.md_flag, color: Colors.red);

    return currentWidget;
  }

}