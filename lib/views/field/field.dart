import 'package:flutter_mobx/flutter_mobx.dart';

import '../../model/field_model.dart';
import 'package:flutter/material.dart';

class FieldWidget extends StatefulWidget {
  const FieldWidget({
    Key key,
    this.height,
    this.width,
    this.item,
    this.onTap,
    this.onLongPress}
  ) : super(key: key);

  final double height;
  final double width;
  final FieldModel item;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  _FieldWidgetState createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
  
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    showField();
  }

  void showField(){
    Future.delayed(Duration(milliseconds: 375)).then((_){ 
      setState(() { _opacity = 1; });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1000),
      opacity: _opacity,
      child: Observer(builder: (_) {
        return GestureDetector(
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: Card(
              margin: EdgeInsets.all(0),
              color: widget.item.color,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: widget.item.borderColor),
                    color: widget.item.color,
                    borderRadius: BorderRadius.all(
                      const Radius.circular(5),
                    )),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(0),
                    child: widget.item.icon,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
