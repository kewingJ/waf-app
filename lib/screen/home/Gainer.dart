import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waf_app/component/gainersModel.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

//
import 'package:http/http.dart' as http;

List<gainers> gainersList = List();

String linkServerMaster = "";

class gainer extends StatefulWidget {
  final Widget child;

  gainer({Key key, this.child}) : super(key: key);

  _gainerState createState() => _gainerState();
}

class _gainerState extends State<gainer> {
  //
  Future recibirListaIpBloqueo() async {

    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    linkServerMaster = await prefs.getString("linkServerMaster");
    
    gainersList = List();
    final respuesta = await http.get(
        linkServerMaster+"/api/v1/get_lista_bloqueo_ip.php");
    if (respuesta.statusCode == 200) {
      setState(() {
        var parsedJson = json.decode(respuesta.body);
        for (final item in parsedJson)
          gainersList.add(new gainers.fromJson(item));
      });
    } else {
      throw Exception("Fallo");
    }
  }

  ///
  /// check the condition is right or wrong for image loaded or no
  ///
  bool loadImage = true;

  @override

  /// To set duration initState auto start if FlashSale Layout open
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        loadImage = false;
      });
    });
    recibirListaIpBloqueo();
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
                    "Codigo Pais",
                    style: TextStyle(fontFamily: "Popins"),
                  )),
                ),
                Container(
                    child: Text(
                  "Dominio",
                  style: TextStyle(fontFamily: "Popins"),
                )),
                Container(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      "Fecha",
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

Widget listPriceGainers(gainers item, BuildContext ctx) {
  return Padding(
    padding:
        const EdgeInsets.only(left: 12.0, top: 20.0, right: 12.0, bottom: 1.0),
    child: InkWell(
      // onTap: () {
      //   Navigator.of(ctx).push(PageRouteBuilder(
      //       pageBuilder: (_, __, ___) => new gainersDetail(
      //             item: item,
      //           )));
      // },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.codigo_pais,
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

Widget loadingListPriceGainers(gainers item, BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, top: 17.0),
    child: Shimmer.fromColors(
      baseColor: Color(0xFF3B4659),
      highlightColor: Color(0xFF606B78),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
      itemCount: gainersList.length,
      itemBuilder: (ctx, i) {
        return loadingListPriceGainers(gainersList[i], ctx);
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
      itemCount: gainersList.length,
      itemBuilder: (ctx, i) {
        return listPriceGainers(gainersList[i], ctx);
      },
    ),
  );
}
