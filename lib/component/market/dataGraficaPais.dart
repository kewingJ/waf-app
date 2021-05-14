class dataGraficaPais {
  String pais, codigo_pais, total_bloqueo;
  dataGraficaPais(
      {this.pais,
      this.codigo_pais,
      this.total_bloqueo});

  factory dataGraficaPais.fromJson(Map<String, dynamic> json) {
    return dataGraficaPais(
      pais: json['pais'],
      codigo_pais: json['codigo_pais'],
      total_bloqueo: json['total_bloqueo'],
    );
  }
}
