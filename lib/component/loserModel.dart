class losers {
  String pais, ip_bloqueada, fecha_bloqueo;
  losers({this.pais, this.ip_bloqueada, this.fecha_bloqueo});

  factory losers.fromJson(Map<String, dynamic> json) {
    return losers(
      pais: json['pais'],
      ip_bloqueada: json['ip_bloqueo'],
      fecha_bloqueo: json['fecha_bloqueo'],
    );
  }
}

// List<losers> losersList = [
// losers(
//   pair: "ENJ",
//   lastPrice: "0.000003913",
//   chg: "-20.58%"
// ),
// losers(
//   pair: "FET",
//   lastPrice: "0.0005548",
//   chg: "-14.53%"
// ),
// losers(
//   pair: "KNC",
//   lastPrice: "0.000006158",
//   chg: "-13.11%"
// ),
// losers(
//   pair: "RVN",
//   lastPrice: "0.000000605",
//   chg: "-12.32%"
// ),
// losers(
//   pair: "VIBE",
//   lastPrice: "0.0001019",
//   chg: "-12.23%"
// ),
// losers(
//   pair: "KNC",
//   lastPrice: "0.0001419",
//   chg: "-11.54%"
// ),
// losers(
//   pair: "VIBE",
//   lastPrice: "0.0001719",
//   chg: "-9.63%"
// ),
// losers(
//   pair: "GTO",
//   lastPrice: "0.0001919",
//   chg: "-8.23%"
// ),
// losers(
//   pair: "ENG",
//   lastPrice: "0.0002112",
//   chg: "-7.63%"
// ),
// losers(
//   pair: "BAT",
//   lastPrice: "0.0002249",
//   chg: "-6.23%"
// ),
// ];
