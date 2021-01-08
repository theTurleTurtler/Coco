import 'package:flutter_test/flutter_test.dart';
import 'package:coco/errors/services/service_status_err.dart';
import 'package:coco/services/casos_service.dart';
import 'package:coco/services/user_service.dart';

final String _testingGroupDescription = 'Se ejecutarán métodos de servicios de casos.';
final String _loadCasosDescription = 'Se testeará método del servicio de cargar caso.';

final Map<String, dynamic> _loginData = {
  'email':'email1@gmail.com',
  'password':'12345678'
};
String _authorizationToken;

void main(){
  group(_testingGroupDescription, (){
    _testLoadCasos();
  });
}

void _testLoadCasos(){
  test(_loadCasosDescription, ()async{
    try{
      await _executeLoadCasosValidations();
    }on TestFailure catch(err){

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
  _executeGeneralServiceValidations(serviceResponse);
  final List<Map<String, dynamic>> casos = serviceResponse['data'].cast<Map<String, dynamic>>();
  _executeCasosValidations(casos);
}

void _executeCasosValidations(List<Map<String, dynamic>> casos){
  casos.forEach((Map<String, dynamic> caso){
    expect(caso['id'], isNotNull, reason: 'El caso actual debería tener un id');
  });
}

void _testCreateCaso(){
  test(_loadCasosDescription, ()async{
    try{
      await _executeLoadCasosValidations();
    }on TestFailure catch(err){

    }on ServiceStatusErr catch(err){
      fail('succesfulRegister: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('succesfulRegister: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeCreateCasoValidations()async{
  final Map<String, dynamic> serviceResponse = await casosService.createCaso();
}

void _testCreateTitulo(){
  test(_loadCasosDescription, ()async{
    try{
      await _executeLoadCasosValidations();
    }on TestFailure catch(err){

    }on ServiceStatusErr catch(err){
      fail('succesfulRegister: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('succesfulRegister: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeCreateTituloValidations()async{
  final Map<String, dynamic> serviceResponse = await casosService.createTitulo();
}

void _testCreateDescripcion(){
  test(_loadCasosDescription, ()async{
    try{
      await _executeLoadCasosValidations();
    }on TestFailure catch(err){

    }on ServiceStatusErr catch(err){
      fail('succesfulRegister: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('succesfulRegister: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeCreateDescripcionValidations()async{
  final Map<String, dynamic> serviceResponse = await casosService.createDescripcion();
}

void _testCreateDireccion(){
  test(_loadCasosDescription, ()async{
    try{
      await _executeLoadCasosValidations();
    }on TestFailure catch(err){

    }on ServiceStatusErr catch(err){
      fail('succesfulRegister: No debería ocurrir un ServiceStatusErr: ${err.status} || ${err.extraInformation}');
    }catch(err){
      fail('succesfulRegister: Ocurrió un error inesperado: ${err.toString()}');
    }
  });
}

Future<void> _executeCreateDireccionValidations()async{
  final Map<String, dynamic> serviceResponse = await casosService.createDireccion();
}

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

void _executeGeneralServiceValidations(Map<String, dynamic> response){
  expect(response, isNotNull, reason: 'el response nunca debe ser null');
  expect(response['error'], isNull, reason:'No debe existir error en el response.');
  expect(response['code'], isNull, reason:'No debe existir un code en el response.');
  expect(response['data'], isNotNull, reason:'Debe venir un campo data en el response');
}