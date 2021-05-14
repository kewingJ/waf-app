class ipDesbloqueadasModel {
  String codigo_pais, url_bandera, ip_desbloqueo, fecha_desbloqueo;
  ipDesbloqueadasModel(
      {
      this.codigo_pais,
      this.url_bandera,
      this.ip_desbloqueo,
      this.fecha_desbloqueo});

  factory ipDesbloqueadasModel.fromJson(Map<String, dynamic> json) {
    return ipDesbloqueadasModel(
      url_bandera: json['url_bandera'],
      codigo_pais: json['codigo_pais'],
      ip_desbloqueo: json['ip_desbloqueo'],
      fecha_desbloqueo: json['fecha_desbloqueo'],
    );
  }
}