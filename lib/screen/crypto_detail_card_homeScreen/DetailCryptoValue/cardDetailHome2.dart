import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:waf_app/component/modelGridHome.dart';
import 'package:flutter/material.dart';
import 'package:waf_app/component/style.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class cardDetailHome2 extends StatefulWidget {
  final gridHome item;

  cardDetailHome2({Key key, this.item}) : super(key: key);

  _cardDetailHome2State createState() => _cardDetailHome2State(item);
}

class _cardDetailHome2State extends State<cardDetailHome2> {
  gridHome item;
  _cardDetailHome2State(this.item);
  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
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
          item.name,
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
                      const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ///
                      /// Calling header value
                      ///
                      //_headerValue(),
                      AspectRatio(
                        aspectRatio: 1.7,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          color: const Color(0xff2c4260),
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: 20,
                              barTouchData: BarTouchData(
                                enabled: false,
                                touchTooltipData: BarTouchTooltipData(
                                  tooltipBgColor: Colors.transparent,
                                  tooltipPadding: const EdgeInsets.all(0),
                                  tooltipBottomMargin: 8,
                                  getTooltipItem: (
                                    BarChartGroupData group,
                                    int groupIndex,
                                    BarChartRodData rod,
                                    int rodIndex,
                                  ) {
                                    return BarTooltipItem(
                                      rod.y.round().toString(),
                                      TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: SideTitles(
                                  showTitles: true,
                                  getTextStyles: (value) => const TextStyle(
                                      color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                                  margin: 20,
                                  getTitles: (double value) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return 'Memoria';
                                      case 1:
                                        return 'Disco';
                                      case 2:
                                        return 'CPU';
                                      default:
                                        return '';
                                    }
                                  },
                                ),
                                leftTitles: SideTitles(showTitles: false),
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              barGroups: [
                                BarChartGroupData(
                                  x: 0,
                                  barRods: [
                                    BarChartRodData(y: 8, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                  ],
                                  showingTooltipIndicators: [0],
                                ),
                                BarChartGroupData(
                                  x: 1,
                                  barRods: [
                                    BarChartRodData(y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                  ],
                                  showingTooltipIndicators: [0],
                                ),
                                BarChartGroupData(
                                  x: 2,
                                  barRods: [
                                    BarChartRodData(y: 14, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                  ],
                                  showingTooltipIndicators: [0],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      AspectRatio(
                        aspectRatio: 1.23,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff2c274c),
                                Color(0xff46426c),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 37,
                                  ),
                                  const Text(
                                    '2020',
                                    style: TextStyle(
                                      color: Color(0xff827daa),
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Text(
                                    'Bloqueos',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 37,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                                      child: LineChart(
                                        isShowingMainData ? sampleData1() : sampleData2(),
                                        swapAnimationDuration: const Duration(milliseconds: 250),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.refresh,
                                  color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isShowingMainData = !isShowingMainData;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      _cardBudgetMemoria(),
                      _cardBudgetDisco(),
                      _cardBudgetCpu(),
                      SizedBox(
                        height: 40.0,
                      ),
                      /// Circle Percent Indicator
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text("Memoria"),
                                SizedBox(
                                  height: 15.0,
                                ),
                                new CircularPercentIndicator(
                                  radius: 60.0,
                                  lineWidth: 2.0,
                                  animation: true,
                                  percent: 0.7,
                                  center: new Text(
                                    "90.0%",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 13.0),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.lightBlueAccent,
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text("Disco"),
                                SizedBox(
                                  height: 15.0,
                                ),
                                new CircularPercentIndicator(
                                  radius: 60.0,
                                  lineWidth: 2.0,
                                  animation: true,
                                  percent: 0.7,
                                  center: new Text(
                                    "70.0%",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 13.0),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.green,
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text("CPU"),
                                SizedBox(
                                  height: 15.0,
                                ),
                                new CircularPercentIndicator(
                                  radius: 60.0,
                                  lineWidth: 2.0,
                                  animation: true,
                                  percent: 0.7,
                                  center: new Text(
                                    "35.0%",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 13.0),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.purple,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
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
