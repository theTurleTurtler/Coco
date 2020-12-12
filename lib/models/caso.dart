import 'dart:io';

import 'package:meta/meta.dart';

class Caso{
  final String tipoDeSolicitud;
  final bool conoceDatosDeEntidadDestino;
  final String nombre;
  final String descripcion;
  final DateTime fechaPublicacion;
  final String estado;
  //mientras implementamos el uso de LatLng
  final String direccion;
  final double latitud;
  final double longitud;
  //TODO: volver final cuando se haya implementado la obtención de multimedia desde el back
  List<File> multimediaItems;

  Caso({
    @required this.tipoDeSolicitud,
    @required this.conoceDatosDeEntidadDestino,
    @required this.nombre,
    @required this.descripcion,
    @required this.fechaPublicacion,
    @required this.estado,
    @required this.direccion,
    @required this.latitud,
    @required this.longitud,
    @required this.multimediaItems 
  });

  Caso.fromJson({
    @required Map<String, dynamic> json
  }):
    this.tipoDeSolicitud = json['tipo_de_solicitud'],
    this.conoceDatosDeEntidadDestino = json['conoce_datos_de_entidad_destino'],
    this.nombre = json['nombre'],
    this.descripcion = json['descripcion'],
    this.fechaPublicacion = json['fecha_publicacion'],
    this.estado = json['estado'],
    this.direccion = json['direccion'],
    this.latitud = json['latitud'],
    this.longitud = json['longitud'],
    this.multimediaItems = json['multimedia_items']
  {
    //TODO: Quitar cuando esté hecha la parte de obtener multimedia del back
    this.multimediaItems = _testingInitOfMultimediaItems();
  }
  

  Map<String, dynamic> get toJson => {
    'tipo_de_solicitud':this.tipoDeSolicitud,
    'conoce_datos_de_entidad_destino':this.conoceDatosDeEntidadDestino,
    'nombre':this.nombre,
    'descripcion':this.descripcion,
    'fecha_publicacion':this.fechaPublicacion,
    'estado':this.estado,
    'direccion':this.direccion,
    'latitud':this.latitud,    
    'longitud':this.longitud,
    'multimedia_items':this.multimediaItems
  };

  Caso copyWith({
    String tipoDeSolicitud,
    String conoceDatosDeEntidadDestino,
    String nombre,
    String descripcion,
    DateTime fechaPublicacion,
    String estado,
    String direccion,
    String latitud,
    String longitud,    
    List<File> multimediaItems
  })=>Caso(
    tipoDeSolicitud: tipoDeSolicitud??this.tipoDeSolicitud,
    conoceDatosDeEntidadDestino: conoceDatosDeEntidadDestino??this.conoceDatosDeEntidadDestino,
    nombre: nombre??this.nombre,
    descripcion: descripcion??this.descripcion,
    fechaPublicacion: fechaPublicacion??this.fechaPublicacion,
    estado: estado??this.estado,
    direccion: direccion??this.direccion,
    latitud: latitud??this.latitud,    
    longitud: longitud??this.longitud,
    multimediaItems: multimediaItems??this.multimediaItems
  );

  //TODO: borrar una vez se haya implementado la obtención de multimedia del back
  List<File> _testingInitOfMultimediaItems(){
    List<File> multimedia = [];
    for(int i = 0; i < 10; i++){
      final File currentFile = File('assets/logo_coco_1');
      multimedia.add(currentFile);
    }
    return multimedia;
  }
  
}