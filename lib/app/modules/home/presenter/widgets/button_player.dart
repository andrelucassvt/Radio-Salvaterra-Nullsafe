import 'package:flutter/material.dart';

class BottonPlayerWidget extends StatelessWidget {
  final Function pauseOrPlayerFunction;
  final bool isButtonPause;
  final bool isProgress;
  BottonPlayerWidget({ 
    Key key,
    this.isButtonPause = true, 
    @required this.pauseOrPlayerFunction,
    this.isProgress = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !isProgress ? this.pauseOrPlayerFunction : null,
      splashColor: Colors.yellow,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 25
        ),
        constraints: BoxConstraints(
          minWidth: 100,
        ),
        decoration: BoxDecoration(
          color: isButtonPause ? Colors.red : Colors.blue,
          borderRadius: BorderRadius.circular(10)
        ),
        child: !isProgress 
          ? Text(
            isButtonPause ? 'Parar' : 'Reproduzir',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white
            )
          )
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40
              ),
              child: CircularProgressIndicator(
                color: Colors.red,
              )
            )
      ),
    );
  }
}