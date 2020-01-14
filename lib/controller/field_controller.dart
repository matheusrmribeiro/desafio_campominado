import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobx/mobx.dart';

part 'field_controller.g.dart';

class FieldController = _FieldController with _$FieldController;

abstract class _FieldController with Store {
  
  _FieldController({
  this.posX, 
  this.posY, 
  this.isCovered = true, 
  this.hasMine = false, 
  this.hasFlag = false, 
  this.minesAround = 0});

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
  String get minesAroundDescription {
    if ((isCovered) || (minesAround == 0)) 
      return "";
    
    return minesAround.toString();
  } 

  @computed
  get color{
    if (isCovered) 
      return Colors.grey;

    if (hasMine)
      return Colors.red;
    else
      return Colors.white;
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
  get borderColor{
    if (!isCovered)
      return hintColor;
    
    if (hasFlag)
      return Colors.red;

    return Colors.grey;
  }

  @computed
  Widget get icon{
    if ((hasMine) && (!isCovered))
      return Icon(Feather.cpu, color: Colors.black);
    if (hasFlag)
      return Icon(Ionicons.md_flag, color: Colors.red);

    return Text(minesAroundDescription,
      style: TextStyle(
        color: hintColor
      ),
    );
  }
}