
class Field{
  Field({
    this.posX, 
    this.posY, 
    this.isCovered = true, 
    this.hasMine = false, 
    this.hasFlag = false, 
    this.minesAround = 0});
  
  final int posX;
  final int posY;
  bool hasMine;
  bool hasFlag;
  bool isCovered;
  int minesAround;
}

