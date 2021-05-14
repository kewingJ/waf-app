import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:waf_app/component/CardDetail/AmountSell.dart';
import 'package:waf_app/component/CardDetail/BuyAmount.dart';
import 'package:flutter/material.dart';

//
import 'package:http/http.dart' as http;

String linkServerMaster = "";

List<buyAmount> buyAmountList = List();

class openOrders extends StatefulWidget {
  final Widget child;

  openOrders({Key key, this.child}) : super(key: key);

  _openOrdersState createState() => _openOrdersState();
}

class _openOrdersState extends State<openOrders> {
  //
  Future recibirListaWaf() async {

    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    linkServerMaster = await prefs.getString("linkServerMaster");
    
    final respuesta = await http.get(
        linkServerMaster+"/api/v1/get_lista_bloqueo_waf.php");
    if (respuesta.statusCode == 200) {
      setState(() {
        var parsedJson = json.decode(respuesta.body);
        for (final item in parsedJson)
          buyAmountList.add(new buyAmount.fromJson(item));
      });
    } else {
      throw Exception("Fallo");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    recibirListaWaf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 0.0, right: 5.0, top: 7.0, bottom: 7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Pais Origen Ataque",
                    style: TextStyle(fontFamily: "Popins"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    "Ip Bloqueada",
                    style: TextStyle(fontFamily: "Popins"),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 400.0,
              width: mediaQuery,
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: buyAmountList.length,
                itemBuilder: (BuildContext ctx, int i) {
                  return _buyAmount(mediaQuery, buyAmountList[i]);
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buyAmount(double _width, buyAmount item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 19.0),
      child: Container(
        width: _width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                item.pais,
                style: TextStyle(fontFamily: "Gotik", fontSize: 15.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                item.ip_bloqueada,
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontFamily: "Gotik",
                    fontSize: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _amountSell(double _width, amountSell item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 19.0),
      child: Container(
        width: _width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item.price,
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Gotik",
                  fontSize: 15.0),
            ),
            Text(
              item.value,
              style: TextStyle(fontFamily: "Gotik", fontSize: 15.0),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                item.number,
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontFamily: "Gotik",
                    fontSize: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
