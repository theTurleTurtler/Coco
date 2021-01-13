import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class Caso{
  int id;
  DateTime _fechaPublicacion;
  String estado;
  _PartWithStringValue _tipoDeSolicitud;
  _PartWithStringValue _titulo;
  _PartWithStringValue _descripcion;
  _PartWithStringValue _direccion;
  _LatLongPart _latLong;
  List<_MultimediaPart> multimediaItems;
  //TODO: Implementar después de que funcione en el back
  _PartWithBoolValue _conoceDatosDeEntidadDestino;

  Map<String, String> rutas;

  Caso.fromJson({
    @required Map<String, dynamic> json
  }){
    this.id = json['id'];
    _initFechaPublicacion(json['create_at']);
    this.estado = json['estado'];
    this._tipoDeSolicitud = _PartWithStringValue(data: json['tipo'], partName: 'tipo');
    this._titulo = _PartWithStringValue(data: json['titulo'], partName: 'titulo');
    //desripcion porque así viene del back
    this._descripcion = _PartWithStringValue(data: json['descripcion'], partName: 'desripcion');
    this._direccion = _PartWithStringValue(data: json['direccion'], partName: 'direccion');    
    this._latLong = _LatLongPart(data: json['latLong']);
    _initMultimediaItems(json['multimedia']);
    this.rutas = (json['rutas']??{} ).cast<String, String>();
  }

  void _initFechaPublicacion(String fecha){
    if(fecha == null)
      return;
    fecha = fecha.split('|')[0];
    fecha = fecha.trim();
    final List<String> partesFechaEnString = fecha.split('-');
    final List<int> partesFecha = partesFechaEnString.map((String partFecha) => int.parse(partFecha)).toList();
    this._fechaPublicacion = DateTime(partesFecha[0], partesFecha[1], partesFecha[2]);
  }

  void _initMultimediaItems(dynamic multimediaItemsMap){
    final bool hasValue = multimediaItemsMap.runtimeType != String;
    if(!hasValue)
      return;
    final List<Map<String, dynamic>> itemsMap = multimediaItemsMap.cast<Map<String, dynamic>>();
    this.multimediaItems = [];
    itemsMap.forEach((Map<String, dynamic> item) {
      final _MultimediaPart multimediaPart = _MultimediaPart(
        servicesRoutes: item['rutas'].cast<String, String>(),
        ruta: item['ruta'],
        tipo: item['tipo'],
        owner: item['owner'].cast<String, String>(),
        rutaCaso: item['rutaCaso']
      );
      this.multimediaItems.add(multimediaPart);
    });
  }

  String get titulo => this._titulo.value;
  String get tipoDeSolicitud => this._tipoDeSolicitud.value;
  String get descripcion => this._descripcion.value;
  String get direccion => this._direccion.value;
  //TODO: Arreglar cuando ya exista en el back
  //bool get conoceDatosDeEntidadDestino => (this._conoceDatosDeEntidadDestino.hasValue)? this._conoceDatosDeEntidadDestino.value : false;
  bool get conoceDatosDeEntidadDestino => true;
  LatLng get latLng => (_latLong.hasValue)? LatLng(_latLong.latitud, _latLong.longitud):null;
  String get fechaPublicacion => '${_getNumberString(_fechaPublicacion.day)}-${_getNumberString(_fechaPublicacion.month)}-${_getNumberString(_fechaPublicacion.year)}';

  String _getNumberString(int number){
    if(number > 9)
      return '$number';
    return '0$number';
  }

}


abstract class _CasoPart{
  Map<String, String> servicesRoutes;
  bool hasValue;
}

abstract class _CasoPartWithSingleValue extends _CasoPart{
  String _value;
  _CasoPartWithSingleValue({
    dynamic data,
    String partName
  }){
    if(data.runtimeType == String){
      this.hasValue = false;
      this._value = data;
      this.servicesRoutes = null;
    }else{
      this.hasValue = true;
      this._value = data[partName];
      this.servicesRoutes = data['rutas'].cast<String, String>();
    }
  }
}

class _PartWithStringValue extends _CasoPartWithSingleValue{
  _PartWithStringValue({
    dynamic data,
    String partName
  }):super(data: data, partName: partName)
    ;

  String get value => this._value;
}

class _PartWithBoolValue extends _CasoPartWithSingleValue{
  _PartWithBoolValue({
    dynamic data,
    String partName
  }):super(data: data, partName: partName)
    ;

  bool get value => (hasValue)? this._value == 'true' : null;
  String get withoutValueMessage => this._value;
}

class _LatLongPart extends _CasoPart{
  String withoutValueMessage;
  double latitud;
  double longitud;

  _LatLongPart({
    dynamic data
  }){
    if(data.runtimeType != String){
      this.hasValue = true;
      this.latitud = double.parse(data['latitud'].toString());
      this.longitud = double.parse(data['longitud'].toString());
    }else{
      this.hasValue = false;
      this.withoutValueMessage = data;
    }
  }
}

class _MultimediaPart extends _CasoPart{
  final String ruta;
  final String tipo;
  final Map<String, String> owner;
  final String rutaCaso;  
  _MultimediaPart({
    Map<String, String> servicesRoutes,
    this.ruta,
    this.tipo,
    this.owner,
    this.rutaCaso,
  }){
    this.servicesRoutes = servicesRoutes;
  }

}