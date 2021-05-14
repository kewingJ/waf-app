import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waf_app/component/loserModel.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

//
import 'package:http/http.dart' as http;

List<losers> losersList = List();

String linkServerMaster = "";


class loser extends StatefulWidget {
  final Widget child;

  loser({Key key, this.child}) : super(key: key);

  _loserState createState() => _loserState();
}

class _loserState extends State<loser> {
  //
  Future recibirListaWaf() async {

    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    linkServerMaster = await prefs.getString("linkServerMaster");
    
    losersList = List();
    final respuesta = await http.get(
        linkServerMaster+"/api/v1/get_lista_bloqueo_waf.php");
    if (respuesta.statusCode == 200) {
      setState(() {
        var parsedJson = json.decode(respuesta.body);
        for (final item in parsedJson)
          losersList.add(new losers.fromJson(item));
      });
    } else {
      throw Exception("Fallo");
    }
  }

  bool loadImage = true;

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        loadImage = false;
      });
    });
    recibirListaWaf();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 0.0, right: 0.0, top: 7.0, bottom: 7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Container(
                      child: Text(
                    "Pais Origen Ataque",
                    style: TextStyle(fontFamily: "Popins"),
                  )),
                ),
                Container(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      "Ip Bloqueada",
                      style: TextStyle(fontFamily: "Popins"),
                    )),
              ],
            ),
          ),
        ),

        ///
        ///
        /// check the condition if image data from server firebase loaded or no
        /// if image loaded true (image still downloading from server)
        /// Card to set card loading animation
        ///

        loadImage ? _loadingImageAnimation(context) : _imageLoaded(context),
      ],
    );
  }
}

Widget listPriceloser(losers item, BuildContext ctx) {
  return Padding(
    padding:
        const EdgeInsets.only(left: 12.0, top: 20.0, right: 12.0, bottom: 1.0),
    child: InkWell(
      // onTap: () {
      //   Navigator.of(ctx).push(PageRouteBuilder(
      //       pageBuilder: (_, __, ___) => new loserDetail(
      //             item: item,
      //           )));
      // },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.pais,
                  style: TextStyle(fontFamily: "Popins", fontSize: 14.5),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  item.ip_bloqueada,
                  style: TextStyle(
                      color: Colors.greenAccent,
                      fontFamily: "Popins",
                      fontSize: 14.5),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget loadingListPriceloser(losers item, BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, top: 17.0),
    child: Shimmer.fromColors(
      baseColor: Color(0xFF3B4659),
      highlightColor: Color(0xFF606B78),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 110.0,
            height: 20.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Theme.of(ctx).hintColor,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Theme.of(ctx).hintColor,
              ),
              height: 20.0,
              width: 110.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Theme.of(ctx).hintColor,
              ),
              height: 20.0,
              width: 115.0,
            ),
          ),
        ],
      ),
    ),
  );
}

///
///
/// Calling imageLoading animation for set a grid layout
///
///
Widget _loadingImageAnimation(BuildContext context) {
  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: losersList.length,
      itemBuilder: (ctx, i) {
        return loadingListPriceloser(losersList[i], ctx);
      },
    ),
  );
}

///
///
/// Calling ImageLoaded animation for set a grid layout
///
///
Widget _imageLoaded(BuildContext context) {
  return Container(
    height: 400.0,
    child: ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: losersList.length,
      itemBuilder: (ctx, i) {
        return listPriceloser(losersList[i], ctx);
      },
    ),
  );
}
