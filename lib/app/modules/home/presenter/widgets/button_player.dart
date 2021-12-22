import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:radiosalvaterrafm/app/modules/home/presenter/pages/home/home_store.dart';

class BottonPlayerWidget extends StatelessWidget {
  final bool isPlayer;
  BottonPlayerWidget({ Key key,this.isPlayer = false,}) : super(key: key);

  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => isPlayer ? controller.playerAudio(context) : controller.playerAudioPause(context),
      splashColor: Colors.yellow,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 25
        ),
        width: 100,
        decoration: BoxDecoration(
          color: isPlayer ? Colors.blue : Colors.red,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Text(
          isPlayer ? 'Reproduzir' : 'Parar',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white
          )
        ),
      ),
    );
  }
}