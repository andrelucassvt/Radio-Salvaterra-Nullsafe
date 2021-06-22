import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
class Horarios extends StatefulWidget {
  @override
  _HorariosState createState() => _HorariosState();
}

class _HorariosState extends State<Horarios> {
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3652623512305285/6823768348',
    size: AdSize.banner,
    request: AdRequest(),
    listener: AdListener(),
  );
  AdWidget adWidget;
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      myBanner.load();
      adWidget = AdWidget(ad: myBanner);
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horários'),
        centerTitle: true,
        backgroundColor: Colors.red,
        leading: IconButton(
          iconSize: 32,
          icon: Icon(Icons.keyboard_arrow_down),
          onPressed: ()=>Navigator.of(context).pop()),
      ),

      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: adWidget,
            width: myBanner.size.width.toDouble(),
            height: myBanner.size.height.toDouble(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('Segunda a Sexta',style: TextStyle(fontSize: 20),)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('05:00 às 07:00 - Bom dia Salvaterra(Toninho Carrasco)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('07:00 às 10:00 - Alô Salvaterra(Marcelo Nunes)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('10:00 às 13:00 - Salvaterra News(Jorge Alves)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('13:00 às 15:00 - Frequência Jovem(Jimmy Rafael)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('15:00 às 17:00 - Super Tarde Salvaterra(Efrain do Marajó)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('17:00 às 18:00 - Igreja em saída(João Pena)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('18:00 às 20:00 - Ritmo das aparelhagens(Thiago Nunes e Dj Pedrinho Pressão)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('20:00 às 22:00 - Expresso da saudade(Toninho Carrasco)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('22:00 às 23:00 - Caminhando com Jesus(Silvio Moura)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('Sábado',style: TextStyle(fontSize: 20),)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('06:00 às 08:00 - Clube do Rei(Musical)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('08:00 às 10:00 - Salvaterra rural(Jorge Alves)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('10:00 às 12:00 - Sabadão Show(Dj júnior e Dj Bruno Silva)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('12:00 às 14:00 - Programa do Feroz(Dj Claudinho)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('14:00 às 16:00 - Batidão 87(Dj Macielzinho)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('16:00 às 18:00 - Trio das marcantes(Bruno Mathyas)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('18:00 às 20:00 - No ritmo das aparelhagens(Thiago Nunes e Dj Pedrinho Pressão)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('20:00 às 22:00 - Expresso da saudade(Toninho Carrasco)'),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('Domingo',style: TextStyle(fontSize: 20),)),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('06:00 às 08:00 - Clube do rei(Musical)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('08:00 às 10:00 - A voz da imaculada(João Pena)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('10:00 às 13:00 - Domingo Swing e alegria(Marcelo Nunes)'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('13:00 às 19:00 - Programa musical'),
          ),
        ],
      ),
    );
  }
}