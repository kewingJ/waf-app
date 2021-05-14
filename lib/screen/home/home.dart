import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waf_app/component/modelGridHome.dart';
import 'package:waf_app/screen/crypto_detail_card_homeScreen/DetailCryptoValue/cardDetailHome.dart';
import 'package:waf_app/screen/crypto_detail_card_homeScreen/DetailCryptoValue/cardDetailHome2.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:waf_app/component/style.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'package:waf_app/screen/market/TabBarBody/bloqueo_fuerza.dart';
import 'package:waf_app/screen/market/TabBarBody/bloqueo_waf.dart';

String _totalWaf = "0";
String _totalFuerza = "0";
String _memoria = "0%";
String _disco = "0%";
String _cpu = "0%";
String _conexiones  = "0";

String linkServerMaster = "";

//
String id_usuario;
String tipo_usuario;

List<gridHome> listGridHome = new List();

class home extends StatefulWidget {
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  //
  Future<String> getTotales() async {

    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    linkServerMaster = await prefs.getString("linkServerMaster");
    
    tipo_usuario = await prefs.getString("tipo_usuario");
    id_usuario = await prefs.getString("id_usuario");

    var respuesta;
    if(tipo_usuario == '1'){
      respuesta = await http.get(linkServerMaster+"/api/v1/get_total_ataques.php");
    } else {
      var url = linkServerMaster+"/api/v1/get_total_ataques_host.php";
      var data = {'id_usuario': id_usuario};
      respuesta = await http.post(url, body: json.encode(data));
    }
    if (respuesta.statusCode == 200) {
      setState(() {
        var parsedJson = json.decode(respuesta.body);
        _totalWaf = parsedJson["total_waf"];
        _totalFuerza = parsedJson["total_fuerza"];
        //datos de resumen
        _memoria = parsedJson["memoria"];
        _disco = parsedJson["disco"];
        _cpu = parsedJson["cpu"];
        _conexiones = parsedJson["conexiones"];



        listGridHome = [
          gridHome(
              name: "Fuerza Bruta",
              image: "Test",
              chartColor: Colors.greenAccent,
              valueMarket: "Total : " + _totalFuerza,
              valuePercent: "",
              chartColorGradient: [
                Colors.greenAccent.withOpacity(0.2),
                Colors.greenAccent.withOpacity(0.01)
              ],
              data: [
                0.0,
                0.5,
                0.9,
                1.4,
                2.2,
                1.0,
                3.3,
                0.0,
                -0.5,
                -1.0,
                -0.5,
                0.0,
                0.0
              ]),
          gridHome(
              name: "Ip Bloqueadas WAF",
              image: "Test",
              chartColor: Colors.greenAccent,
              valueMarket: "Total : " + _totalWaf,
              valuePercent: "",
              chartColorGradient: [
                Colors.redAccent.withOpacity(0.2),
                Colors.redAccent.withOpacity(0.01)
              ],
              data: [
                0.0,
                -0.3,
                -0.5,
                -0.1,
                0.0,
                0.0,
                -0.5,
                -1.0,
                -0.5,
                0.0,
                0.0,
              ]),
          gridHome(
              name: "Datos Server",
              image: "Test3",
              chartColor: Colors.greenAccent,
              valueMarket: "Memoria : "+_memoria+"\nDisco : "+_disco+"\nCPU : "+_cpu,
              valuePercent: "",
              chartColorGradient: [
                Colors.greenAccent.withOpacity(0.2),
                Colors.greenAccent.withOpacity(0.01)
              ],
              data: [
                0.0,
                0.0,
                0.0
              ]),
          gridHome(
              name: "Today's Threat Status",
              image: "Test3",
              chartColor: Colors.greenAccent,
              valueMarket: "Malware : 8046 items\nAntivirus : 1 items\nConexiones : "+_conexiones,
              valuePercent: "",
              chartColorGradient: [
                Colors.greenAccent.withOpacity(0.2),
                Colors.greenAccent.withOpacity(0.01)
              ],
              data: [
                0.0,
                0.0,
                0.0,
                0.0
              ]),
        ];
      });
    } else {
      throw Exception("Fallo");
    }
  }

  bool loadCard = true;

  @override
  @override
  void initState() {
    getTotales();
    Timer(Duration(seconds: 3), () {
      setState(() {
        loadCard = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ///
            /// Header image slider
            ///
            SizedBox(
                height: 210.0,
                width: double.infinity,
                child: new Carousel(
                  boxFit: BoxFit.cover,
                  dotColor: Colors.white.withOpacity(0.8),
                  dotSize: 5.5,
                  dotSpacing: 16.0,
                  dotBgColor: Colors.transparent,
                  showIndicator: true,
                  overlayShadow: true,
                  overlayShadowColors: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.9),
                  overlayShadowSize: 0.25,
                  images: [
                    // AssetImage("assets/image/banner/banner2.png"),
                    // AssetImage("assets/image/banner/banner3.jpg"),
                    // AssetImage("assets/image/banner/banner2.png"),
                    // AssetImage("assets/image/banner/banner3.jpg"),
                    AssetImage("assets/image/banner/appwaf.jpg"),
                  ],
                )),
            SizedBox(height: 10.0),

            ///
            ///
            /// check the condition if image data from server firebase loaded or no
            /// if image loaded true (image still downloading from server)
            /// Card to set card loading animation
            ///

            loadCard ? _loadingCardAnimation(context) : _cardLoaded(context),

            ///
            /// Tab bar custom
            ///
            Container(
              height: 700.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: DefaultTabController(
                      length: 2,
                      child: new Scaffold(
                        appBar: PreferredSize(
                          preferredSize:
                              Size.fromHeight(53.0), // here the desired height
                          child: new AppBar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            elevation: 0.0,
                            centerTitle: true,
                            flexibleSpace: SafeArea(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 0.0),
                                  child: new TabBar(
                                    indicatorColor: colorStyle.primaryColor,
                                    labelColor: Theme.of(context).primaryColor,
                                    unselectedLabelColor:
                                        Theme.of(context).textSelectionColor,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    tabs: [
                                      new Tab(
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Icon(
                                                  Icons.format_list_bulleted,
                                                  size: 17.0),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "Ataques Fuerza Br..",
                                                style: TextStyle(
                                                    fontFamily: "Sans"),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      new Tab(
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Icon(
                                                  Icons.format_list_bulleted,
                                                  size: 17.0),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text("Ip Bloqueadas WAF"),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            automaticallyImplyLeading: false,
                          ),
                        ),
                        body: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: new TabBarView(
                            children: [
                              bloqueo_fuerza(),
                              bloqueo_waf(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class card extends StatelessWidget {
  gridHome item;
  card(this.item);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: InkWell(
        onTap: () {
          if(item.image == "Test"){
              Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new cardDetailHome(
                    item: item,
                  )));
          } else if (item.image == "Test2"){
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new cardDetailHome2(
                    item: item,
                  )));
          }
        },
        child: Container(
          height: 70.0,
          width: _width / 2.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Theme.of(context).canvasColor,
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF656565).withOpacity(0.15),
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.1, 1.0))
              ]),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.name,
                      style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.valueMarket,
                            style: TextStyle(
                                color: item.chartColor,
                                fontFamily: "Gotik",
                                fontSize: 13.5),
                          ),
                          Text(
                            item.valuePercent,
                            style: TextStyle(color: item.chartColor),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 30.0,
                  child: new Sparkline(
                    data: item.data,
                    lineWidth: 0.3,
                    fillMode: FillMode.below,
                    lineColor: item.chartColor,
                    fillGradient: new LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: item.chartColorGradient,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class cardLoading extends StatelessWidget {
  gridHome item;
  cardLoading(this.item);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: Container(
        height: 70.0,
        width: _width / 2.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Theme.of(context).canvasColor,
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.1, 1.0))
            ]),
        child: Shimmer.fromColors(
          baseColor: Color(0xFF3B4659),
          highlightColor: Color(0xFF606B78),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Theme.of(context).hintColor,
                      height: 20.0,
                      width: 70.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 17.0,
                            width: 70.0,
                          ),
                          Container(
                            color: Theme.of(context).hintColor,
                            height: 17.0,
                            width: 70.0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 30.0,
                  child: new Sparkline(
                    data: item.data,
                    lineWidth: 0.3,
                    fillMode: FillMode.below,
                    lineColor: item.chartColor,
                    fillGradient: new LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: item.chartColorGradient,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
///
/// Calling imageLoading animation for set a grid layout
///
///
Widget _loadingCardAnimation(BuildContext context) {
  return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      childAspectRatio: 1.745,
      crossAxisCount: 2,
      primary: false,
      children: List.generate(
        listGridHome.length,
        (index) => cardLoading(listGridHome[index]),
      ));
}

///
///
/// Calling ImageLoaded animation for set a grid layout
///
///
Widget _cardLoaded(BuildContext context) {
  return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      childAspectRatio: 1.745,
      crossAxisCount: 2,
      primary: false,
      children: List.generate(
        listGridHome.length,
        (index) => card(listGridHome[index]),
      ));
}
