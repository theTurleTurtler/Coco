import 'package:coco/blocs/user/user_bloc.dart';
import 'package:coco/blocs/user/user_services_manager.dart';
import 'package:coco/enums/account_step.dart';
import 'package:coco/errors/services/service_status_err.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'mock/blocs.dart';
import 'mock/build_context.dart';
import '../../testing_helpers.dart' as helpers;

final String _testingGroupDescription = 'Se probarán métodos de user services manager.';
final String _registerDescription = 'Se testeará el método register';
final String _loginDescription = 'Se testeará el método login';
final String _getUserInformationDescription = 'Se testeará el método login';
final String _logoutDescription = 'Se testeará el método login';
final String _refreshAccessTokenDescription = 'Se testeará el método login';

final BuildContext _context = MockBuildContext();
final UserBloc _userBloc = MockUserBloc();
final UserServicesManager _uSManager = UserServicesManager.forTesting(appContext: _context, userBloc: _userBloc);
final Map<String, dynamic> _successRegisterData = {
  'name':'John ${helpers.createUniqueString()}',
  'email':'email${helpers.createUniqueString()}@gmail.com', 
  'password':'12345678',
  'confirmed_password':'12345678'
};
final Map<String, dynamic> _successLoginData = {'email':'email1@gmail.com', 'password':'12345678'};

void main(){
  group(_testingGroupDescription, (){
    _testRegister();
    _testLogin();
    _testGetUserInformation();
    _testGetUserInformation();
  });
}

void _testRegister(){
  test(_registerDescription, ()async{
    try{
      await _executeRegisterValidations();
    }catch(err){
      fail('No debería haber ocurrido un error: $err');     
    }
  });
}

Future<void> _executeRegisterValidations()async{
  await _uSManager.register(_successRegisterData['name'], _successRegisterData['email'], _successRegisterData['password'], _successRegisterData['confirmed_password']);
  _executeAccountWithAccessTokenValidations();
}

void _testLogin(){
  test(_loginDescription, ()async{
    try{
      await _executeLoginValidations();
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

void _executeAccountWithAccessTokenValidations(){
  final UserState blocState = _userBloc.state;
  expect(blocState.accountStep, AccountStep.WITH_ACCESS_TOKEN, reason: 'El account step debería ser with access token');
  expect(blocState.accessToken, isNotNull, reason: 'Debe haber un access token en el state');
}

void _testGetUserInformation(){
  test(_getUserInformationDescription, ()async{
    try{
      await _executeGetUserInformationValidations();
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

void _testLogout(){
  test(_logoutDescription, ()async{
    try{
      await _executeLogoutValidations();
    }catch(err){
      fail('No debería haber ocurrido un error: $err');      
    }
  });
}

Future<void> _executeLogoutValidations()async{

}

void _testRefreshAccessToken(){
  test(_refreshAccessTokenDescription, ()async{
    try{
      await _executeRefreshAccessTokenValidations();
    }catch(err){
      fail('No debería haber ocurrido un error: $err');      
    }
  });
}

Future<void> _executeRefreshAccessTokenValidations()async{
  
}