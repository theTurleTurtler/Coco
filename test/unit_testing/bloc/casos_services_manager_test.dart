import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:coco/blocs/casos/casos_bloc.dart';
import 'package:coco/blocs/casos/casos_services_manager.dart';
import 'package:coco/blocs/user/user_bloc.dart';
import 'package:coco/blocs/user/user_services_manager.dart';
import 'mock/build_context.dart';
import 'mock/blocs.dart';
import '../models/caso_data_prueba.dart' as casoDataPrueba;

final String _testingGroupDescription = 'Se probarán métodos de user services manager.';
final String _loadPublicCasosDescription = 'Se testeará el método loadPublicCasos';
final String _loadCasosDescription = 'Se testeará el método loadCasos';
final String _createCasoDescription = 'Se testeará el método createCaso';

final Map<String, dynamic> _successLoginData = {'email':'email1@gmail.com', 'password':'12345678'};
final BuildContext _context = MockBuildContext();
final UserBloc _userBloc = MockUserBloc();
final CasosBloc _casosBloc = MockCasosBloc();
final CasosServicesManager _cSManager = CasosServicesManager.forTesting(appContext: _context, userBloc: _userBloc, casosBloc: _casosBloc);
final UserServicesManager _uSManager = UserServicesManager.forTesting(appContext: _context, userBloc: _userBloc, casosServicesManager: _cSManager);

final String _multimediaPhotosBasePath = 'assets\\test\\multimedia_data\\photos\\';
final List<String> _multimediaPhotosNames = [
  'coco_1.jpg'
];
final String _multimediaVideosBasePath = 'assets\\test\\multimedia_data\\videos\\';
final List<String> _multimediaVideosNames = [
  'coco_1.mp4'
];


void main(){
  group(_testingGroupDescription, (){
    _testLoadPublicCasos();
    _testLoadCasos();
    _testCreateCaso();
  });
}

void _testLoadPublicCasos(){
  test(_loadPublicCasosDescription, ()async{
    try{
      await _executeLoadPublicCasosValidations();
    }on TestFailure catch(err){
      throw err;
    }catch(err){
      fail('No debería haber ocurrido un error: $err');     
    }
  });
}

Future<void> _executeLoadPublicCasosValidations()async{
  await _cSManager.loadPublicCasos();
  final CasosState _casosState = _casosBloc.state;
  expect(_casosState.estanCargados, true, reason: 'El estado de los casos en el state debería ser cargados');
  expect(_casosState.casos, isNotNull, reason: 'Debe haber casos instanciados en el state');
}

void _testLoadCasos(){
  test(_loadCasosDescription, ()async{
    try{
      await _executeLoadCasosValidations();
    }on TestFailure catch(err){
      throw err;
    }catch(err){
      fail('No debería haber ocurrido un error: $err');     
    }
  });
}

Future<void> _executeLoadCasosValidations()async{
  await _uSManager.manageLoginProccess(_successLoginData['email'], _successLoginData['password']);
  await _cSManager.loadCasos();
  final CasosState _casosState = _casosBloc.state;
  expect(_casosState.estanCargados, true, reason: 'El estado de los casos en el state debería ser cargados');
  expect(_casosState.casos, isNotNull, reason: 'Debe haber casos instanciados en el state');
}

void _testCreateCaso(){
  test(_createCasoDescription, ()async{
    try{
      await _executeCreateCasoValidations();
    }on TestFailure catch(err){
      throw err;
    }catch(err){
      fail('No debería haber ocurrido un error: $err');     
    }
  });
}

Future<void> _executeCreateCasoValidations()async{
  await _uSManager.manageLoginProccess(_successLoginData['email'], _successLoginData['password']);
  final Map<String, dynamic> caso = casoDataPrueba.casoToCreate;
  final double latitud = double.parse(caso['latLong']['latitud']);
  final double longitud = double.parse(caso['latLong']['longitud']);
  final LatLng latLng = LatLng(latitud, longitud);
  List<File> multimediaItems = _createPhotos();
  multimediaItems.addAll(_createVideos());
  await _cSManager.createCaso(
    titulo: caso['titulo']['titulo'],
    descripcion: caso['descripcion']['desripcion'], 
    tipo: caso['tipo']['tipoCaso'],
    conoceDatosDeEntidadDestino: true, 
    direccion: caso['direccion']['direccion'], 
    latLng: latLng, 
    multimedia: multimediaItems,     
  );
}

List<File> _createPhotos(){
  List<File> photos = [];
  File currentPhoto;
  _multimediaPhotosNames.forEach((String photoName) {
    String photoPath = _multimediaPhotosBasePath + photoName;
    currentPhoto = File(photoPath);
    currentPhoto = currentPhoto.absolute;
    photos.add(currentPhoto);
  });
  return photos;
}

List<File> _createVideos(){
  List<File> videos = [];
  File currentVideo;
  _multimediaVideosNames.forEach((String videoName) {
    String videoPath = _multimediaVideosBasePath + videoName;
    currentVideo = File(videoPath);
    currentVideo = currentVideo.absolute;
    videos.add(currentVideo);
  });
  return videos;
}