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
final String _createEstadoDescription = 'Se testeará método del servicio de crear estado.';
final String _createMultimediaDescription = 'Se testeará método del servicio de crear multimedia.';




final Map<String, dynamic> _loginData = {
  'email':'email1@gmail.com',
  'password':'12345678'
};
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
  });
}

///////////////////////////////////////////////////////////////////////////////////// 
// ---------------->             Carga               <------------------------
///////////////////////////////////////////////////////////////////////////////////// 

void _testLoadCasos(){
  test(_loadCasosDescription, ()async{
    try{
      await _executeLoadCasosValidations();
    }on TestFailure catch(_){

    }on ServiceStatusErr catch(err){
      fail('succesfulRegister: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('succesfulRegister: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeLoadCasosValidations()async{
  await _login();
  final Map<String, String> headers = _createAuthorizationTokenHeaders();
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
    }on TestFailure catch(_){

    }on ServiceStatusErr catch(err){
      fail('succesfulRegister: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('succesfulRegister: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeCreateCasoValidations()async{
  final Map<String, dynamic> body = _generateAuthorizationTokenBody();
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
    }on TestFailure catch(_){

    }on ServiceStatusErr catch(err){
      fail('succesfulRegister: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('succesfulRegister: Ocurrió un error inesperado: ${err.toString()}');
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
    }on TestFailure catch(_){

    }on ServiceStatusErr catch(err){
      fail('succesfulRegister: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('succesfulRegister: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeCreateDescriptionValidations()async{
  final Map<String, dynamic> body = _generateGeneralCreatePartBody('descripcion');
  final Map<String, dynamic> serviceResponse = await casosService.createDescripcion(body);
  _executeGeneralServiceResponseValidations(serviceResponse);
  final Map<String, dynamic> responseData = serviceResponse['data'];
  expect(responseData['descripcion'], isNotNull, reason: 'la descripción del responseData no debe ser null');
  expect(responseData['rutas'], isNotNull, reason: 'Las rutas del responseData no deben ser null');
}

void _testCreateDireccion(){
  test(_createDireccionDescription, ()async{
    try{
      await _executeCreateDireccionValidations();
    }on TestFailure catch(_){

    }on ServiceStatusErr catch(err){
      fail('succesfulRegister: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('succesfulRegister: Ocurrió un error inesperado: ${err.toString()}');
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
    }on TestFailure catch(_){

    }on ServiceStatusErr catch(err){
      fail('succesfulRegister: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('succesfulRegister: Ocurrió un error inesperado: ${err.toString()}');
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
  final Map<String, dynamic> body = _generateAuthorizationTokenBody();
  body['caso_id'] = _currentCreatedCasoId;
  body['latitud'] = helpers.createUniqueNumber();
  body['longitud'] = helpers.createUniqueNumber();
  body['seleccionado'] = true;
  return body;
}

//TODO: Confirmar que esté funcionando en el back
void _testCreateEstado(){
  test(_createDireccionDescription, ()async{
    try{
      await _executeCreateEstadoValidations();
    }on TestFailure catch(_){

    }on ServiceStatusErr catch(err){
      fail('succesfulRegister: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('succesfulRegister: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeCreateEstadoValidations()async{
  final Map<String, dynamic> serviceResponse = await casosService.createDireccion({});
}

//TODO: Confirmar que esté funcionando en el back
void _testCreateMultimedia(){
  test(_createDireccionDescription, ()async{
    try{
      await _executeCreateMultimediaValidations();
    }on TestFailure catch(_){

    }on ServiceStatusErr catch(err){
      fail('succesfulRegister: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('succesfulRegister: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeCreateMultimediaValidations()async{
  final Map<String, dynamic> serviceResponse = await casosService.createDireccion({});
}

///////////////////////////////////////////////////////////////////////////////////// 
// --------------->     Código general duplicado       <------------------------
///////////////////////////////////////////////////////////////////////////////////// 
///
Future<void> _login()async{
  final Map<String, dynamic> serviceResponse = await userService.login(_loginData);
  _authorizationToken = serviceResponse['data']['original']['access_token'];
}

Map<String, String> _createAuthorizationTokenHeaders(){
  final Map<String, String> headers = {
    'Authorization':'Bearer $_authorizationToken'
  };
  return headers;
}

Map<String, dynamic> _generateGeneralCreatePartBody(String partName){
  Map<String, dynamic> body = _generateAuthorizationTokenBody();
  body['caso_id'] = _currentCreatedCasoId;
  body['seleccionado'] = true;
  body[partName] = '$partName ${helpers.createUniqueString()}';
  return body;
}

Map<String, dynamic> _generateAuthorizationTokenBody(){
  return {'token':_authorizationToken};
}

void _executeGeneralServiceResponseValidations(Map<String, dynamic> response){
  expect(response, isNotNull, reason: 'el response nunca debe ser null');
  expect(response['error'], isNull, reason:'No debe existir error en el response.');
  expect(response['code'], isNull, reason:'No debe existir un code en el response.');
  expect(response['data'], isNotNull, reason:'Debe venir un campo data en el response');
}