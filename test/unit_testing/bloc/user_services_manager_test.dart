import 'package:coco/blocs/casos/casos_bloc.dart';
import 'package:coco/blocs/casos/casos_services_manager.dart';
import 'package:coco/blocs/user/user_bloc.dart';
import 'package:coco/blocs/user/user_services_manager.dart';
import 'package:coco/enums/account_step.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'mock/blocs.dart';
import 'mock/build_context.dart';
import '../../testing_helpers.dart' as helpers;

final String _testingGroupDescription = 'Se probarán métodos de user services manager.';
final String _registerDescription = 'Se testeará el método register';
final String _loginDescription = 'Se testeará el método login';
final String _getUserInformationDescription = 'Se testeará el método getUserInformation';
final String _logoutDescription = 'Se testeará el método logout';
final String _refreshAccessTokenDescription = 'Se testeará el método refreshAccessToken';

final BuildContext _context = MockBuildContext();
final UserBloc _userBloc = MockUserBloc();
final CasosBloc _casosBloc = MockCasosBloc();
final CasosServicesManager _casosServicesManager = CasosServicesManager.forTesting(appContext: _context, userBloc: _userBloc, casosBloc: _casosBloc);
final UserServicesManager _uSManager = UserServicesManager.forTesting(appContext: _context, userBloc: _userBloc, casosServicesManager: _casosServicesManager);
final Map<String, dynamic> _successRegisterData = {
  'name':'John ${helpers.createUniqueString()}',
  'email':'email${helpers.createUniqueString()}@gmail.com', 
  'password':'12345678',
  'confirmed_password':'12345678'
};
final Map<String, dynamic> _successLoginData = {'email':'email1@gmail.com', 'password':'12345678'};
String _currentAccessToken;

void main(){
  group(_testingGroupDescription, (){
    _testRegister();
    _testLogin();
    _testRefreshAccessToken();
    _testGetUserInformation();
    _testLogout();
    _testManageLoginProccess();
  });
}

void _testRegister(){
  test(_registerDescription, ()async{
    try{
      await _executeRegisterValidations();
    }on TestFailure catch(err){
      throw err;
    }catch(err){
      fail('No debería haber ocurrido un error: $err');   
    }
  });
}

Future<void> _executeRegisterValidations()async{
  await _uSManager.manageRegisterProcess(_successRegisterData);
  _executeAccountWithAccessTokenValidations();
}

void _testLogin(){
  test(_loginDescription, ()async{
    try{
      await _executeLoginValidations();
    }on TestFailure catch(err){
      throw err;
    }catch(err){
      fail('No debería haber ocurrido un error: $err');     
    }
  });
}

Future<void> _executeLoginValidations()async{
  _userBloc.add(ResetUserInformation());
  await _uSManager.login(_successLoginData['email'], _successLoginData['password']);
  _executeAccountWithAccessTokenValidations();
}

void _testRefreshAccessToken(){
  test(_refreshAccessTokenDescription, ()async{
    try{
      await _executeRefreshAccessTokenValidations();
    }on TestFailure catch(err){
      throw err;
    }catch(err){
      fail('No debería haber ocurrido un error: $err');      
    }
  });
}

Future<void> _executeRefreshAccessTokenValidations()async{
  _userBloc.add(ResetUserInformation());
  await _uSManager.refreshAccessToken(_currentAccessToken);
  final UserState blocState = _userBloc.state;
  expect(blocState.accountStep, AccountStep.WITH_ACCESS_TOKEN, reason: 'El account step debe ser a');
  expect(blocState.accessToken, isNotNull, reason: 'El access token debe existir en el state');
}

void _executeAccountWithAccessTokenValidations(){
  final UserState blocState = _userBloc.state;
  expect(blocState.accountStep, AccountStep.WITH_ACCESS_TOKEN, reason: 'El account step debería ser with access token');
  expect(blocState.accessToken, isNotNull, reason: 'Debe haber un access token en el state');
  _currentAccessToken = blocState.accessToken;
}

void _testGetUserInformation(){
  test(_getUserInformationDescription, ()async{
    try{
      await _executeGetUserInformationValidations();
    }on TestFailure catch(err){
      throw err;
    }catch(err){
      fail('No debería haber ocurrido un error: $err');      
    }
  });
}

Future<void> _executeGetUserInformationValidations()async{
  await _uSManager.getUserInformation();
  final UserState blocState = _userBloc.state;
  expect(blocState.accountStep, AccountStep.LOGGED, reason: 'El account step del state debería ser logged');
  expect(blocState.user, isNotNull, reason: 'El user del state debería existir');
}

void _testManageLoginProccess(){
  test(_getUserInformationDescription, ()async{
    try{
      await _executeManageLoginProccessValidations();
    }on TestFailure catch(err){
      throw err;
    }catch(err){
      fail('No debería haber ocurrido un error: $err');      
    }
  });
}

Future<void> _executeManageLoginProccessValidations()async{
  await _uSManager.manageLoginProccess(_successLoginData['email'], _successLoginData['password']);
  final UserState userState = _userBloc.state;
  expect(userState.accessToken, isNotNull, reason: 'El accessToken del debería ser logged');
}

void _testLogout(){
  test(_logoutDescription, ()async{
    try{
      await _executeLogoutValidations();
    }on TestFailure catch(err){
      throw err;
    }catch(err){
      fail('No debería haber ocurrido un error: $err');      
    }
  });
}

Future<void> _executeLogoutValidations()async{
  await _uSManager.manageLogoutProccess();
  final UserState blocState = _userBloc.state;
  expect(blocState.accountStep, AccountStep.UNLOGGED, reason: 'Después de un logout el state debe tener un account step unlogged');
  expect(blocState.accessToken, isNull, reason: 'Después de un logout el state debe tener un accessToken null');
  expect(blocState.user, isNull, reason: 'Después de un logout el state debe tener un user null');
}