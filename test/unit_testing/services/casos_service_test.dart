import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:coco/errors/services/service_status_err.dart';
import 'package:coco/services/casos_service.dart';
import 'package:coco/services/user_service.dart';
import '../../testing_helpers.dart' as helpers;

final String _testingGroupDescription = 'Se ejecutarán métodos de servicios de casos.';
final String _loadCasosDescription = 'Se testeará método del servicio de cargar casos.';
final String _createCasoDescription = 'Se testeará método del servicio de crear caso.';
final String _createTituloDescription = 'Se testeará método del servicio de crear titulo.';
final String _createDescriptionDescription = 'Se testeará método del servicio de crear descripcion.';
final String _createDireccionDescription = 'Se testeará método del servicio de crear dirección.';
final String _createLatLongDescription = 'Se testeará método del servicio de crear latLong.';
final String _createTipoDescription = 'Se testeará método del servicio de crear estado.';
final String _createMultimediaDescription = 'Se testeará método del servicio de crear multimedia.';

final Map<String, dynamic> _loginData = {
  'email':'email1@gmail.com',
  'password':'12345678'
};
final String _multimediaPhotosBasePath = 'assets\\test\\multimedia_data\\photos\\';
final List<String> _multimediaPhotosNames = [
  'coco_1.jpg',
  'coco_2.png',
  'coco_3.jpg'
];
final String _multimediaVideosBasePath = 'assets\\test\\multimedia_data\\videos\\';
final List<String> _multimediaVideosNames = [
  'coco_1.mp4',
  'coco_2.mp4',
];

String _authorizationToken;
int _currentCreatedCasoId;

void main(){
  group(_testingGroupDescription, (){
    _testLoadCasos();
    _testCreateCaso();
    _testCreateTitulo();
    _testCreateDescription();
    _testCreateDireccion();
    _testCreateLatLong();
    _testCreateTipo();
    _testCreateMultimedia();
  });
}

///////////////////////////////////////////////////////////////////////////////////// 
// ---------------->             Carga               <------------------------
///////////////////////////////////////////////////////////////////////////////////// 

void _testLoadCasos(){
  test(_loadCasosDescription, ()async{
    try{
      await _executeLoadCasosValidations();
    }on TestFailure catch(err){
      throw err;
    }on ServiceStatusErr catch(err){
      fail('loadCasos: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('loadCasos: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeLoadCasosValidations()async{
  await _login();
  final Map<String, String> headers = _generateAccessTokenHeaders();
  final Map<String, dynamic> serviceResponse = await casosService.loadCasos(headers);
  _executeGeneralServiceResponseValidations(serviceResponse);
  final List<Map<String, dynamic>> casos = serviceResponse['data'].cast<Map<String, dynamic>>();
  _executeCasosValidations(casos);
}

void _executeCasosValidations(List<Map<String, dynamic>> casos){
  casos.forEach((Map<String, dynamic> caso){
    expect(caso['id'], isNotNull, reason: 'El caso actual debería tener un id');
  });
}

///////////////////////////////////////////////////////////////////////////////////// 
// ------------->             Creación                <------------------------
///////////////////////////////////////////////////////////////////////////////////// 

void _testCreateCaso(){
  test(_createCasoDescription, ()async{
    try{
      await _executeCreateCasoValidations();
    }on TestFailure catch(err){
      throw err;
    }on ServiceStatusErr catch(err){
      fail('createCaso: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('createCaso: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeCreateCasoValidations()async{
  final Map<String, dynamic> body = _generateAccessTokenBody();
  final Map<String, dynamic> serviceResponse = await casosService.createCaso(body);
  _executeGeneralServiceResponseValidations(serviceResponse);
  final Map<String, dynamic> responseData = serviceResponse['data'];
  expect(responseData['id'], isNotNull, reason: 'El id del nuevo caso no debe ser null');
  _currentCreatedCasoId = responseData['id'];
  final Map<String, dynamic> owner = responseData['owner'];
  expect(owner, isNotNull, reason: 'La información del owner no debe ser null');
  expect(owner['nick'], isNotNull, reason: 'El nick del owner no debe ser null');
  expect(owner['avatar'], isNotNull, reason: 'El avatar del owner no debe ser null');
}

void _testCreateTitulo(){
  test(_createTituloDescription, ()async{
    try{
      await _executeCreateTituloValidations();
    }on TestFailure catch(err){
      throw err;
    }on ServiceStatusErr catch(err){
      fail('createTitulo: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('createTitulo: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeCreateTituloValidations()async{
  final Map<String, dynamic> body = _generateGeneralCreatePartBody('titulo');
  final Map<String, dynamic> serviceResponse = await casosService.createTitulo(body);
  _executeGeneralServiceResponseValidations(serviceResponse);
  final Map<String, dynamic> responseData = serviceResponse['data'];
  expect(responseData['titulo'], isNotNull, reason: 'El titulo del responseData no debe ser null');
  expect(responseData['rutas'], isNotNull, reason: 'Las rutas del responseData no deben ser null');
}

void _testCreateDescription(){
  test(_createDescriptionDescription, ()async{
    try{
      await _executeCreateDescriptionValidations();
    }on TestFailure catch(err){
      throw err;
    }on ServiceStatusErr catch(err){
      fail('createDescription: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('createDescription: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeCreateDescriptionValidations()async{
  final Map<String, dynamic> body = _generateGeneralCreatePartBody('descripcion');
  final Map<String, dynamic> serviceResponse = await casosService.createDescripcion(body);
  _executeGeneralServiceResponseValidations(serviceResponse);
  final Map<String, dynamic> responseData = serviceResponse['data'];
  expect(responseData['descripcion']??responseData['desripcion'], isNotNull, reason: 'la descripción del responseData no debe ser null');
  expect(responseData['rutas'], isNotNull, reason: 'Las rutas del responseData no deben ser null');
}

void _testCreateDireccion(){
  test(_createDireccionDescription, ()async{
    try{
      await _executeCreateDireccionValidations();
    }on TestFailure catch(err){
      throw err;
    }on ServiceStatusErr catch(err){
      fail('createDireccion: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('createDireccion: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeCreateDireccionValidations()async{
  final Map<String, dynamic> body = _generateGeneralCreatePartBody('direccion');
  final Map<String, dynamic> serviceResponse = await casosService.createDireccion(body);
  _executeGeneralServiceResponseValidations(serviceResponse);
  final Map<String, dynamic> responseData = serviceResponse['data'];
  expect(responseData['direccion'], isNotNull, reason: 'la direccion del responseData no debe ser null');
  expect(responseData['rutas'], isNotNull, reason: 'Las rutas del responseData no deben ser null');
}

void _testCreateLatLong(){
  test(_createLatLongDescription, ()async{
    try{
      await _executeCreateLatLongValidations();
    }on TestFailure catch(err){
      throw err;
    }on ServiceStatusErr catch(err){
      fail('createLatLong: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('createLatLong: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeCreateLatLongValidations()async{
  final Map<String, dynamic> body = _generateCreateLatLongBody();
  final Map<String, dynamic> serviceResponse = await casosService.createLatLong(body);
  _executeGeneralServiceResponseValidations(serviceResponse);
  final Map<String, dynamic> responseData = serviceResponse['data'];
  expect(responseData['latitud'], isNotNull, reason: 'la latitud del responseData no debe ser null');
  expect(responseData['longitud'], isNotNull, reason: 'la longitud del responseData no debe ser null');
  expect(responseData['rutas'], isNotNull, reason: 'Las rutas del responseData no deben ser null');
}

Map<String, dynamic> _generateCreateLatLongBody(){
  final Map<String, dynamic> body = _generateAccessTokenBody();
  body['caso_id'] = _currentCreatedCasoId;
  body['latitud'] = helpers.createUniqueNumber();
  body['longitud'] = helpers.createUniqueNumber();
  body['seleccionado'] = true;
  return body;
}

void _testCreateTipo(){
  test(_createTipoDescription, ()async{
    try{
      await _executeCreateTipo();
    }on TestFailure catch(err){
      throw err;
    }on ServiceStatusErr catch(err){
      fail('createTipo: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('createTipo: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeCreateTipo()async{
  final Map<String, dynamic> body = _generateGeneralCreatePartBody('tipo');
  final Map<String, dynamic> response = await casosService.createTipo(body);
  _executeGeneralServiceResponseValidations(response);
  final Map<String, dynamic> responseData = response['data'];
  expect(responseData['tipoCaso'], isNotNull, reason: 'El tipo del response no debe ser null');
}

void _testCreateMultimedia(){
  test(_createMultimediaDescription, ()async{
    try{
      await _executeCreateMultimedia();
    }on TestFailure catch(err){
      throw err;
    }on ServiceStatusErr catch(err){
      fail('createMultimedia: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('createMultimedia: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeCreateMultimedia()async{
  final Map<String, String> headers = {'Content-Type':'application/x-www-form-urlencoded'};
  final Map<String, String> fields = _generateAccessTokenBody().cast<String, String>();
  fields['caso_id'] = _currentCreatedCasoId.toString();
  fields['seleccionado'] = 'true';
  final List<File> photos = _createPhotos();
  final List<File> videos = _createVideos();
  Map<String, List<File>> multimedia = {
    'photos':photos,
    'videos':videos
  };
  final Map<String, dynamic> serviceResponse = await casosService.createMultimedia(headers, fields, multimedia);
  _executeGeneralServiceResponseValidations(serviceResponse);
  final Map<String, dynamic> responseData = serviceResponse['data'];
  final List<Map<String, dynamic>> responseVideos = responseData['videos'].cast<Map<String, dynamic>>();
  expect(responseVideos, isNotNull, reason: 'El campo vídeos debería existir en el response');
  _executeResponseFileValidations(responseVideos);
  final List<Map<String, dynamic>> responsePhotos = responseData['fotos'].cast<Map<String, dynamic>>();
  expect(responsePhotos, isNotNull, reason: 'El campo fotos debería existir en el response');
  _executeResponseFileValidations(responsePhotos);
}

void _executeResponseFileValidations(List<Map<String, dynamic>> responseFiles){
  responseFiles.forEach((Map<String, dynamic> file) {
    expect(file['ruta'], isNotNull, reason: 'La ruta del archivo actual no debería ser null');
    expect(file['owner'], isNotNull, reason: 'El owner del archivo actual no debería ser null');
    expect(file['rutaCaso'], isNotNull, reason: 'La ruta del caso del archivo actual no debería ser null');
    expect(file['rutas'], isNotNull, reason: 'El campo rutas del archivo actual no debería ser null');
  });
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

///////////////////////////////////////////////////////////////////////////////////// 
// --------------->     Código general duplicado       <------------------------
///////////////////////////////////////////////////////////////////////////////////// 
///
Future<void> _login()async{
  final Map<String, dynamic> serviceResponse = await userService.login(_loginData);
  _authorizationToken = serviceResponse['data']['original']['access_token'];
}

Map<String, String> _generateAccessTokenHeaders(){
  final Map<String, String> headers = {
    'Authorization':'Bearer $_authorizationToken'
  };
  return headers;
}

Map<String, dynamic> _generateGeneralCreatePartBody(String partName){
  Map<String, dynamic> body = _generateAccessTokenBody();
  body['caso_id'] = _currentCreatedCasoId;
  body['seleccionado'] = true;
  body[partName] = '$partName ${helpers.createUniqueString()}';
  return body;
}

Map<String, dynamic> _generateAccessTokenBody(){
  return {'token':_authorizationToken};
}

void _executeGeneralServiceResponseValidations(Map<String, dynamic> response){
  expect(response, isNotNull, reason: 'el response nunca debe ser null');
  expect(response['error'], isNull, reason:'No debe existir error en el response.');
  expect(response['code'], isNull, reason:'No debe existir un code en el response.');
  expect(response['data'], isNotNull, reason:'Debe venir un campo data en el response');
}