import 'package:mobx/mobx.dart';

part 'field_controller.g.dart';

class FieldController = _FieldController with _$FieldController;

abstract class _FieldController with Store {
  
  @observable
  bool hasMine = false;

  @observable
  bool hasFlag = false;

  @observable
  bool isCovered = true;

  @observable
  int minesAround = 0;
}