class gainers {
  String pais, codigo_pais, url_bandera, server, ip_bloqueada, fecha_bloqueo;
  gainers(
      {this.pais,
      this.codigo_pais,
      this.url_bandera,
      this.server,
      this.ip_bloqueada,
      this.fecha_bloqueo});

  factory gainers.fromJson(Map<String, dynamic> json) {
    return gainers(
      pais: json['pais'],
      url_bandera: json['url_bandera'],
      server: json['server'],
      codigo_pais: json['codigo_pais'],
      ip_bloqueada: json['ip_bloqueo'],
      fecha_bloqueo: json['fecha_bloqueo'],
    );
  }
}

// List<gainers> gainersList = [
//   gainers(pais: "GRS", ip_bloqueada: "0.000013278", fecha_bloqueo: "+114.26%"),
//   gainers(pais: "VIA", ip_bloqueada: "0.00001319", fecha_bloqueo: "+38.12%"),
//   gainers(pais: "STORJ", ip_bloqueada: "0.000007024", fecha_bloqueo: "+19.29%"),
//   gainers(pais: "CMT", ip_bloqueada: "0.00000946", fecha_bloqueo: "+17.22%"),
//   gainers(pais: "GXS", ip_bloqueada: "0.0002294", fecha_bloqueo: "+9.92%"),
//   gainers(pais: "GNT", ip_bloqueada: "0.0002042", fecha_bloqueo: "+8.32%"),
//   gainers(pais: "EOS", ip_bloqueada: "0.0003313", fecha_bloqueo: "+5.92%"),
//   gainers(pais: "SNT", ip_bloqueada: "0.0016850", fecha_bloqueo: "+4.00%"),
//   gainers(pais: "BEE", ip_bloqueada: "0.0002294", fecha_bloqueo: "+2.92%"),
//   gainers(pais: "BTT", ip_bloqueada: "0.0001252", fecha_bloqueo: "+1.92%"),
// ];
