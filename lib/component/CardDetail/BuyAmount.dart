class buyAmount {
  String pais, ip_bloqueada, fecha_bloqueo;

  buyAmount({this.pais, this.ip_bloqueada, this.fecha_bloqueo});

  factory buyAmount.fromJson(Map<String, dynamic> json) {
    return buyAmount(
      pais: json['pais'],
      ip_bloqueada: json['ip_bloqueo'],
      fecha_bloqueo: json['fecha_bloqueo'],
    );
  }
}

// List<buyAmount> buyAmountList = [
//   buyAmount(
//       pais: "China",
//       ip_bloqueada: "128.199.254.23	",
//       fecha_bloqueo: "2020-05-18")
// ];
