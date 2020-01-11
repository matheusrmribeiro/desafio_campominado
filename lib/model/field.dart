
class Field{
  Field({
    this.posX, 
    this.posY, 
    this.isCovered = true, 
    this.hasMine = false, 
    this.hasFlag = false, 
    this.minesAround = 0});
  
  final bool hasMine;
  final bool hasFlag;
  final bool isCovered;
  final int posX;
  final int posY;
  int minesAround;
}

