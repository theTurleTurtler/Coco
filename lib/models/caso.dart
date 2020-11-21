import 'package:meta/meta.dart';

class Caso{
  final String titulo;
  final String descripcion;
  final DateTime fechaPublicacion;
  final String estado;
  //mientras implementamos el uso de LatLng
  final String ciudad;

  Caso({
    @required this.titulo,
    @required this.descripcion,
    @required this.fechaPublicacion,
    @required this.estado,
    @required this.ciudad
  });

  Caso.fromJson({
    @required Map<String, dynamic> json
  }):
    this.titulo = json['titulo'],
    this.descripcion = json['descripcion'],
    this.fechaPublicacion = json['fecha_publicacion'],
    this.estado = json['estado'],
    this.ciudad = json['ciudad']
  ;

  Map<String, dynamic> get toJson => {
    'titulo':this.titulo,
    'descripcion':this.descripcion,
    'fecha_publicacion':this.fechaPublicacion,
    'estado':this.estado,
    'ciudad':this.ciudad
  };

  Caso copyWith({
    String titulo,
    String descripcion,
    DateTime fechaPublicacion,
    String estado,
    String ciudad
  })=>Caso(
    titulo: titulo??this.titulo,
    descripcion: descripcion??this.descripcion,
    fechaPublicacion: fechaPublicacion??this.fechaPublicacion,
    estado: estado??this.estado,
    ciudad: ciudad??this.ciudad
  );
  
}