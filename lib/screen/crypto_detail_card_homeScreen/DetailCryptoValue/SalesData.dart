import 'dart:ui';

class SalesData {
  String tipo_ataque;
  int total_bloqueos;
  double porcentaje;
  Color color;
  SalesData(
  {
      this.tipo_ataque,
      this.total_bloqueos,
      this.porcentaje,
      this.color
  });

  factory SalesData.fromJson(Map<String, dynamic> json) {
    return SalesData(
      tipo_ataque: json['tipo_ataque'],
      total_bloqueos: json['total_bloqueos'],
      porcentaje: double.parse(json['porcentaje']),
    );
  }
}