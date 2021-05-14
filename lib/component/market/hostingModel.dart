class hostingList {
  String nombre_hosting;
  int total_bloqueo;
  hostingList(
      {this.nombre_hosting,
      this.total_bloqueo});

  factory hostingList.fromJson(Map<String, dynamic> json) {
    return hostingList(
      nombre_hosting: json['nombre_hosting'],
      total_bloqueo: json['total_bloqueo'],
    );
  }
}