import 'package:mobx/mobx.dart';
import '../model/field.dart';
import '../model/minefield.dart';

part 'minefield_controller.g.dart';

class MineFieldController = _MineFieldController with _$MineFieldController;

abstract class _MineFieldController with Store {

  MineField minefield;

  @observable
  ObservableList<Field> fields;

  @observable
  bool gameOver = false;

  Map<List<int>, Field> matrix;

  @action
  void initializeGame({Difficulty difficulty, int totalMines}){
    minefield = MineField(difficulty: difficulty, totalMines: totalMines);
    fields = minefield.buildFields().asObservable();
  }

  @action
  void onClickItem(Field field){
    if (field.hasMine){
      gameOver = true;
      return;
    }

    minefield.uncoverAdjacentFields(field: field, visited: {[field.posX, field.posY].toString(): false});
    fields = List<Field>.from(fields).asObservable();
  }

}