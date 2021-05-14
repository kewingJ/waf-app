import 'package:flutter/material.dart';
import 'package:waf_app/screen/crypto_detail_card_homeScreen/DetailCryptoValue/T2_graficaDominios.dart';
import 'package:waf_app/screen/crypto_detail_card_homeScreen/T1_graficaPais.dart';
import 'package:waf_app/screen/crypto_detail_card_homeScreen/T2_graficaTipoAtaque.dart';

class seeAllGraficas extends StatefulWidget {
  final Widget child;

  seeAllGraficas({Key key, this.child}) : super(key: key);

  _seeAllGraficasState createState() => _seeAllGraficasState();
}

class _seeAllGraficasState extends State<seeAllGraficas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        elevation: 0.2,
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Lista de Graficas",
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Popins",
              fontSize: 17.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new T1_graficaPais()));
                },
                child: card([Color(0xFF15EDED), Color(0xFF029CF5)],
                    Color(0xFF15EDED), "Ataque por Pais")),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new T2_graficaTipoAtaque()));
                },
                child: card([Color(0xFF15EDED), Color(0xFF029CF5)],
                    Color(0xFF15EDED), "Tipos de Ataques")),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => T2_graficaDominios()));
                },
                child: card([Color(0xFF15EDED), Color(0xFF029CF5)],
                    Color(0xFF15EDED), "Ataque a Dominios")),
            SizedBox(
              height: 30.0,
            )
          ],
        ),
      ),
    );
  }

  Widget card(List<Color> _colorGradient, Color _colorShadow, String _title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 15.0),
      child: Container(
        height: 120.0,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _colorGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                  color: _colorShadow.withOpacity(0.2),
                  blurRadius: 20.0,
                  spreadRadius: 0.1,
                  offset: Offset(3, 10))
            ]),
        child: Center(
          child: Text(
            _title,
            style: TextStyle(
                fontFamily: "Berlin", fontSize: 22.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
