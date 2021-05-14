import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waf_app/component/modelGridHome.dart';
import 'package:flutter/material.dart';
import 'package:waf_app/component/style.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:waf_app/screen/crypto_detail_card_homeScreen/DetailCryptoValue/GradesData.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

String linkServerMaster = "";

List<GradesData> btcMarketList = List();

class T1_graficaPais extends StatefulWidget {
  final gridHome item;

  T1_graficaPais({Key key, this.item}) : super(key: key);

  _T1_graficaPaisState createState() => _T1_graficaPaisState();
}


class _T1_graficaPaisState extends State<T1_graficaPais> {
  gridHome item;
  _T1_graficaPaisState();
  bool isShowingMainData;

  //
  Future recibirDatosGrafica() async {

    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    linkServerMaster = await prefs.getString("linkServerMaster");

    btcMarketList = List();
    final respuesta = await http.get(
        linkServerMaster+"/api/v1/get_ataque_paises_grafica.php");
    if (respuesta.statusCode == 200) {
      setState(() {
        var parsedJson = json.decode(respuesta.body);
        for (final item in parsedJson)
          btcMarketList.add(new GradesData.fromJson(item));
      });
    } else {
      throw Exception("Fallo");
    }
  }

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
    recibirDatosGrafica();
  }

  @override
  Widget build(BuildContext context) {
    var grayText = TextStyle(
        color: Theme.of(context).hintColor,
        fontFamily: "Popins",
        fontSize: 12.5);

    var styleValueChart = TextStyle(
        color: Theme.of(context).hintColor,
        fontFamily: "Popins",
        fontSize: 11.5);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      ///
      /// Appbar
      ///
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Ataques por Paises",
          style: TextStyle(color: Theme.of(context).textSelectionColor),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).hintColor,
        ),
      ),

      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 500,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Expanded(
                                  child: new charts.PieChart(
                                    _getSeriesData(),
                                    animate: true,
                                    defaultRenderer: new charts.ArcRendererConfig(
                                      arcWidth: 70,
                                      arcRendererDecorators: [new charts.ArcLabelDecorator()]
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      ///
                      /// Calling header value
                      ///
                      //_headerValue(),
                      SizedBox(
                        height: 40.0,
                      ),
                      /// Circle Percent Indicator
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: <Widget>[
                      //       Column(
                      //         children: <Widget>[
                      //           Text("Francia"),
                      //           SizedBox(
                      //             height: 15.0,
                      //           ),
                      //           new CircularPercentIndicator(
                      //             radius: 60.0,
                      //             lineWidth: 2.0,
                      //             animation: true,
                      //             percent: 0.13,
                      //             center: new Text(
                      //               "13.0%",
                      //               style: new TextStyle(
                      //                   fontWeight: FontWeight.bold, fontSize: 13.0),
                      //             ),
                      //             circularStrokeCap: CircularStrokeCap.round,
                      //             progressColor: Colors.lightBlueAccent,
                      //           ),
                      //         ],
                      //       ),
                      //       Column(
                      //         children: <Widget>[
                      //           Text("Estados Unidos"),
                      //           SizedBox(
                      //             height: 15.0,
                      //           ),
                      //           new CircularPercentIndicator(
                      //             radius: 60.0,
                      //             lineWidth: 2.0,
                      //             animation: true,
                      //             percent: 0.4,
                      //             center: new Text(
                      //               "44.0%",
                      //               style: new TextStyle(
                      //                   fontWeight: FontWeight.bold, fontSize: 13.0),
                      //             ),
                      //             circularStrokeCap: CircularStrokeCap.round,
                      //             progressColor: Colors.green,
                      //           ),
                      //         ],
                      //       ),
                      //       Column(
                      //         children: <Widget>[
                      //           Text("Vietnam"),
                      //           SizedBox(
                      //             height: 15.0,
                      //           ),
                      //           new CircularPercentIndicator(
                      //             radius: 60.0,
                      //             lineWidth: 2.0,
                      //             animation: true,
                      //             percent: 0.1,
                      //             center: new Text(
                      //               "5.0%",
                      //               style: new TextStyle(
                      //                   fontWeight: FontWeight.bold, fontSize: 13.0),
                      //             ),
                      //             circularStrokeCap: CircularStrokeCap.round,
                      //             progressColor: Colors.purple,
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 30.0,
                // ),
                //Container(
                  //height: 300.0,
                  //child: Stack(
                    //children: <Widget>[
                      ///
                      /// Calling vertical value grafik
                      ///
                     // _verticalValueGrafik(),

                      ///
                      /// Calling sparkLine Grafik
                      ///
                     // _sparkLineGrafic(),
                    //],
                  //),
                //),

                ///
                /// Calling horizontal value grafik
                ///
                //_horizontalValueGrafik(),
                //SizedBox(
                  //height: 20.0,
                //),

                ///
                /// Container for tab bar (open orders) and body value
                ///
              ],
            ),
          ),
          //_buttonBottom()
        ],
      ),
    );
  }

  _getSeriesData() {
    List<charts.Series<GradesData, String>> series = [
      charts.Series(
        id: "Grades",
        data: btcMarketList,
        labelAccessorFn: (GradesData row, _) => '${row.codigo_pais}: ${row.total_bloqueo}%',
        domainFn: (GradesData grades, _) => grades.codigo_pais,
        measureFn: (GradesData grades, _) => grades.total_bloqueo
      )
    ];
    return series;
  }

  Widget _cardBudgetMemoria() {
    double _width = MediaQuery.of(context).size.width - 80;
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Memoria",
              style: TextStyle(color: Colors.white, fontFamily: "Popins"),
            ),

            ///
            /// Create line
            ///
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 3.0),
              child: new LinearPercentIndicator(
                width: _width,
                lineHeight: 21.0,
                percent: 0.5,
                progressColor: Colors.greenAccent,
                center: Text("50%"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardBudgetDisco() {
    double _width = MediaQuery.of(context).size.width - 80;
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Disco",
              style: TextStyle(color: Colors.white, fontFamily: "Popins"),
            ),

            ///
            /// Create line
            ///
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 3.0),
              child: new LinearPercentIndicator(
                width: _width,
                lineHeight: 21.0,
                percent: 0.5,
                progressColor: Colors.greenAccent,
                center: Text("50%"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardBudgetCpu() {
    double _width = MediaQuery.of(context).size.width - 80;
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              "CPU",
              style: TextStyle(color: Colors.white, fontFamily: "Popins"),
            ),

            ///
            /// Create line
            ///
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 3.0),
              child: new LinearPercentIndicator(
                width: _width,
                lineHeight: 21.0,
                percent: 0.5,
                progressColor: Colors.greenAccent,
                center: Text("50%"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _budgetCategories(
    String _title,
    String _value,
    double _percent,
    Color _lineColor,
  ) {
    double _width = MediaQuery.of(context).size.width - 10;
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 15.0,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _title,
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Sans"),
              ),
              Text(
                _value,
                style:
                    TextStyle(color: _lineColor, fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          LinearPercentIndicator(
            width: _width - 50.0,
            lineHeight: 10.0,
            percent: _percent,
            progressColor: _lineColor,
          ),
        ],
      ),
    );
  }

  Widget _buttonBottom() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 50.0,
            width: 140.0,
            child: MaterialButton(
              splashColor: Colors.black12,
              highlightColor: Colors.black12,
              color: Colors.greenAccent.withOpacity(0.8),
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Tap'),
                ));
              },
              child: Center(
                  child: Text(
                "Buy",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Popins",
                    letterSpacing: 1.3,
                    fontSize: 16.0),
              )),
            ),
          ),
          SizedBox(
            width: 0.0,
          ),
          Container(
            height: 50.0,
            width: 140.0,
            child: MaterialButton(
              splashColor: Colors.black12,
              highlightColor: Colors.black12,
              color: Colors.redAccent.withOpacity(0.8),
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Tap'),
                ));
              },
              child: Center(
                  child: Text(
                "Sell",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Popins",
                    letterSpacing: 1.3,
                    fontSize: 16.0),
              )),
            ),
          ),
          Column(children: <Widget>[
            Icon(
              Icons.star,
              color: Theme.of(context).hintColor,
            ),
            Container(
                width: 50.0,
                child: Center(
                    child: Text(
                  "Add to Favorites",
                  style: TextStyle(
                      fontSize: 10.0, color: Theme.of(context).hintColor),
                  textAlign: TextAlign.center,
                )))
          ])
        ],
      ),
    );
  }

  Widget _tabBarCustomButton() {
    return PreferredSize(
      preferredSize: Size.fromHeight(53.0), // here the desired height
      child: new AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        flexibleSpace: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: new TabBar(
                // labelColor: Theme.of(context).primaryColor,
                indicatorColor: colorStyle.primaryColor,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).textSelectionColor,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  new Tab(
                    child: Text(
                      "Lista de ataques de fuerza bruta",
                      style: TextStyle(fontFamily: "Sans"),
                    ),
                  )
                  // new Tab(
                  //   child: Text(
                  //     "Order History",
                  //     style: TextStyle(fontFamily: "Sans"),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
    );
  }

  Widget _headerValue() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              item.valueMarket,
              style: TextStyle(
                  color: item.chartColor,
                  fontSize: 36.0,
                  fontFamily: "Sans",
                  fontWeight: FontWeight.w700),
            ),
            // Column(
            //   children: <Widget>[
            //     Row(
            //       children: <Widget>[
            //         Padding(
            //           padding: const EdgeInsets.only(right: 15.0),
            //           child: Text(
            //             "High",
            //             style: TextStyle(
            //                 color: Theme.of(context).hintColor,
            //                 fontFamily: "Popins",
            //                 fontSize: 11.5),
            //           ),
            //         ),
            //         SizedBox(
            //           height: 7.0,
            //         ),
            //         Text("60.8950")
            //       ],
            //     ),
            //     Row(
            //       children: <Widget>[
            //         Padding(
            //           padding: const EdgeInsets.only(right: 15.0),
            //           child: Text(
            //             "Low",
            //             style: TextStyle(
            //                 color: Theme.of(context).hintColor,
            //                 fontFamily: "Popins",
            //                 fontSize: 11.5),
            //           ),
            //         ),
            //         Text("60.0300")
            //       ],
            //     )
            //   ],
            // )
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Row(
        //       children: <Widget>[
        //         Text(
        //           "\$60.57000",
        //           style: TextStyle(
        //               color: Theme.of(context).hintColor,
        //               fontFamily: "Popins",
        //               fontSize: 11.5),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(left: 10.0),
        //           child: Text(
        //             item.valuePercent,
        //             style: TextStyle(color: item.chartColor),
        //           ),
        //         ),
        //       ],
        //     ),
        //     Row(
        //       children: <Widget>[
        //         Padding(
        //           padding: const EdgeInsets.only(right: 31.0),
        //           child: Text(
        //             "24h Vol",
        //             style: TextStyle(
        //                 color: Theme.of(context).hintColor,
        //                 fontFamily: "Popins",
        //                 fontSize: 11.5),
        //           ),
        //         ),
        //         Text("906.8")
        //       ],
        //     )
        //   ],
        // ),
      ],
    );
  }

  Widget _sparkLineGrafic() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
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
    );
  }

  Widget _horizontalValueGrafik() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "50.0000",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
          Text(
            "40.0000",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
          Text(
            "30.0000",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
          Text(
            "20.0000",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
          Text(
            "10.0000",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
          Text(
            "0.0000",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
        ],
      ),
    );
  }

  Widget _verticalValueGrafik() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                    child: _line()),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "5000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                    child: _line()),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "4000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                    child: _line()),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "3000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                    child: _line()),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "2000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                    child: _line()),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "1000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 30.0),
                    child: _line()),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "0",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _line() {
    return Container(
      height: 0.2,
      width: double.infinity,
      color: Theme.of(context).hintColor,
    );
  }

  Widget _backgroundLine() {
    return Container(
        height: 13.2,
        width: double.infinity,
        color: Theme.of(context).canvasColor);
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5),
      ],
      isCurved: true,
      colors: const [
        Color(0xff27b6fc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
      lineChartBarData3,
    ];
  }

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
              case 5:
                return '6m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 14,
      maxY: 6,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
        isCurved: true,
        colors: const [
          Color(0x99aa4cfc),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x4427b6fc),
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }
}
