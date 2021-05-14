import 'dart:ui';

class SalesDataDominio {
  String nombre_hosting;
  int total_bloqueo;
  double porcentaje;
  Color color;
  SalesDataDominio(
  {
      this.nombre_hosting,
      this.total_bloqueo,
      this.porcentaje,
      this.color
  });

  factory SalesDataDominio.fromJson(Map<String, dynamic> json) {
    return SalesDataDominio(
      nombre_hosting: json['nombre_hosting'],
      total_bloqueo: json['total_bloqueo'],
      porcentaje: double.parse(json['porcentaje']),
    );
  }
}