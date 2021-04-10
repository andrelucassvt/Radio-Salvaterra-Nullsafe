import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AtualizarApp extends StatefulWidget {
  @override
  _AtualizarAppState createState() => _AtualizarAppState();
}

class _AtualizarAppState extends State<AtualizarApp> {

  double size = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualização'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_down_outlined),
          onPressed: (){
            Navigator.of(context).pop();
          }),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Text(
                'Há uma nova atualização disponível',
                style: TextStyle(
                  fontSize: size,
                  fontWeight: FontWeight.bold
                ),
              ),

              Text(
                'Abra a Google Play e atualize',
                style: TextStyle(
                  fontSize: size,
                  fontWeight: FontWeight.bold
                ),
              ),

          ],
        ),
      ),
    );
  }
  abrirUrl() async {
    const url = 'https://play.google.com/store/apps/details?id=com.andre.radiosalvaterrafm';
    if (await canLaunch(url)) {
      await launch(url);
      Navigator.of(context).pop();
    } else {
      throw 'Could not launch $url';
    }
  }
}