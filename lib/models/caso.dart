import 'dart:io';

import 'package:meta/meta.dart';

class Caso{
  final String titulo;
  final String descripcion;
  final DateTime fechaPublicacion;
  final String estado;
  //mientras implementamos el uso de LatLng
  final String ciudad;
  //TODO: volver final cuando se haya implementado la obtención de multimedia desde el back
  List<File> multimediaItems;

  Caso({
    @required this.titulo,
    @required this.descripcion,
    @required this.fechaPublicacion,
    @required this.estado,
    @required this.ciudad,
    @required this.multimediaItems 
  });

  Caso.fromJson({
    @required Map<String, dynamic> json
  }):
    this.titulo = json['titulo'],
    this.descripcion = json['descripcion'],
    this.fechaPublicacion = json['fecha_publicacion'],
    this.estado = json['estado'],
    this.ciudad = json['ciudad'],
    this.multimediaItems = json['multimedia_items']
  {
    //TODO: Quitar cuando esté hecha la parte de obtener multimedia del back
    this.multimediaItems = _testingInitOfMultimediaItems();
  }
  

  Map<String, dynamic> get toJson => {
    'titulo':this.titulo,
    'descripcion':this.descripcion,
    'fecha_publicacion':this.fechaPublicacion,
    'estado':this.estado,
    'ciudad':this.ciudad,
    'multimedia_items':this.multimediaItems
  };

  Caso copyWith({
    String titulo,
    String descripcion,
    DateTime fechaPublicacion,
    String estado,
    String ciudad,
    List<File> multimediaItems
  })=>Caso(
    titulo: titulo??this.titulo,
    descripcion: descripcion??this.descripcion,
    fechaPublicacion: fechaPublicacion??this.fechaPublicacion,
    estado: estado??this.estado,
    ciudad: ciudad??this.ciudad,
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