import 'package:flutter/material.dart';

class gridHome {
  String name, image, valueMarket, valuePercent;
  Color chartColor;
  List<Color> chartColorGradient;
  var data;
  gridHome(
      {this.image,
      this.name,
      this.data,
      this.chartColor,
      this.valueMarket,
      this.valuePercent,
      this.chartColorGradient});
}

//List<gridHome> listGridHome = new List();
