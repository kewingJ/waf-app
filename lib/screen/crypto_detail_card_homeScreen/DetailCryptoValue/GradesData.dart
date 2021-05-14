class GradesData {
  String pais, codigo_pais;
  int total_bloqueo;
  GradesData(
      {this.pais,
      this.codigo_pais,
      this.total_bloqueo});

  factory GradesData.fromJson(Map<String, dynamic> json) {
    return GradesData(
      pais: json['pais'],
      codigo_pais: json['codigo_pais'],
      total_bloqueo: json['total_bloqueo'],
    );
  }
}