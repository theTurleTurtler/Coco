import 'package:coco/models/caso.dart';
import 'package:flutter_test/flutter_test.dart';
import 'caso_data_prueba.dart' as data;

final String _casoTestDescription = 'Se intentará instanciar un objeto Caso por medio de un json';

main(){
  test(_casoTestDescription, (){
    try{
      _executeCasoTestValidations();
    }on TestFailure catch(err){
      throw err;
    }catch(err){
      fail('caso: Ha ocurrido un error: $err');
    }
  });
}

void _executeCasoTestValidations(){
  final Map<String, dynamic> casoMap = data.existingCaso;
  final Caso caso = Caso.fromJson(json: casoMap);
  expect(caso.id, casoMap['id'], reason: 'El campo id del caso debe ser el mismo que el del json');
  expect(caso.estado, casoMap['estado'], reason: 'El campo estado debe ser el mismo que estaba en el objeto original');
  expect(caso.fechaPublicacion, isNotNull, reason: 'La fecha de publicación del caso no debe ser null');
  expect(caso.titulo, casoMap['titulo']['titulo'], reason: 'El campo titulo del caso debe ser el mismo que el del json'); 
  expect(caso.descripcion, casoMap['descripcion']['desripcion'], reason: 'El campo descripcion del caso debe ser el mismo que el del json'); 
  expect(caso.direccion, casoMap['direccion']['direccion'], reason: 'El campo direccion del caso debe ser el mismo que el del json'); 
  expect(caso.tipoDeSolicitud, casoMap['tipo']['tipo'], reason: 'El campo tipoDeSolicitud del caso debe ser el mismo que el del json');
  final Map<String, dynamic> latLongMap = casoMap['latLong'];
  expect(caso.latLng.latitude.toString(), latLongMap['latitud'], reason: 'El campo latLng.latitude del caso debe ser el mismo que el del json');
  expect(caso.latLng.longitude.toString(), latLongMap['longitud'], reason: 'El campo latLng.longitude del caso debe ser el mismo que el del json');
  expect(caso.multimediaItems, isNotNull, reason: 'El campo multimedia items debe existir');
  expect(caso.multimediaItems.length, casoMap['multimedia'].length , reason: 'El campo multimedia items del caso debe tener 5 elementos');
  expect(caso.rutas, casoMap['rutas'], reason: 'El campo rutas debe existir con sus respectivos elementos');
}

