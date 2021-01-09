import 'dart:io';
import 'package:meta/meta.dart';

class Caso{
  final int id;
  final String tipoDeSolicitud;
  final bool conoceDatosDeEntidadDestino;
  final String titulo;
  final String descripcion;
  final DateTime fechaPublicacion;
  //mientras implementamos el uso de LatLng
  final String direccion;
  final double latitud;
  final String estado;
  final double longitud;
  //TODO: volver final cuando se haya implementado la obtención de multimedia desde el back
  List<File> multimediaItems;

  Caso({
    @required this.id,
    @required this.tipoDeSolicitud,
    @required this.conoceDatosDeEntidadDestino,
    @required this.titulo,
    @required this.descripcion,
    @required this.fechaPublicacion,
    @required this.direccion,
    @required this.latitud,
    @required this.longitud,
    @required this.estado,
    @required this.multimediaItems 
  });

  Caso.fromJson({
    @required Map<String, dynamic> json
  }):
    this.id = json['id'],
    this.tipoDeSolicitud = json['tipo'],
    this.conoceDatosDeEntidadDestino = json['conoce_datos_de_entidad_destino'],
    this.titulo = json['titulo']['titulo'],
    this.descripcion = json['descripcion']['descripcion'],
    this.fechaPublicacion = json['fecha_publicacion'],
    this.direccion = json['direccion']['direccion'],
    this.latitud = double.parse((json['latLong']['latitud'].toString())),
    this.longitud =  double.parse((json['latLong']['longitud'].toString())),
    this.estado = json['estado'],
    this.multimediaItems = json['multimedia_items']??[]
  {
    //TODO: Quitar cuando esté hecha la parte de obtener multimedia del back
    this.multimediaItems = _testingInitOfMultimediaItems();
  }
  

  Map<String, dynamic> get toJson => {
    'id':this.id,
    'tipo_de_solicitud':this.tipoDeSolicitud,
    'conoce_datos_de_entidad_destino':this.conoceDatosDeEntidadDestino,
    'titulo':this.titulo,
    'descripcion':this.descripcion,
    'fecha_publicacion':this.fechaPublicacion,
    'direccion':this.direccion,
    'latitud':this.latitud,    
    'longitud':this.longitud,
    'estado':this.estado,
    'multimedia_items':this.multimediaItems
  };

  Caso copyWith({
    int id,
    String tipoDeSolicitud,
    String conoceDatosDeEntidadDestino,
    String titulo,
    String descripcion,
    DateTime fechaPublicacion,
    String direccion,
    String latitud,
    String longitud,
    String estado, 
    List<File> multimediaItems
  })=>Caso(
    id: id??this.id,
    tipoDeSolicitud: tipoDeSolicitud??this.tipoDeSolicitud,
    conoceDatosDeEntidadDestino: conoceDatosDeEntidadDestino??this.conoceDatosDeEntidadDestino,
    titulo: titulo??this.titulo,
    descripcion: descripcion??this.descripcion,
    fechaPublicacion: fechaPublicacion??this.fechaPublicacion,
    direccion: direccion??this.direccion,
    latitud: latitud??this.latitud,    
    longitud: longitud??this.longitud,
    estado: estado??this.estado,
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