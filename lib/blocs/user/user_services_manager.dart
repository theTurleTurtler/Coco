import 'package:coco/blocs/casos/casos_services_manager.dart';
import 'package:coco/blocs/user/user_bloc.dart';
import 'package:coco/errors/services/service_status_err.dart';
import 'package:coco/models/user.dart';
import 'package:coco/pages/casos_home_page.dart';
import 'package:coco/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserServicesManager{
  // ******************* Modelo Singleton
  static final UserServicesManager _uSManager = UserServicesManager._internal();

  UserServicesManager._internal();

  factory UserServicesManager({
    @required BuildContext appContext
  }){
    _initInitialElements(appContext);
    return _uSManager;
  }
  
  static void _initInitialElements(BuildContext appContext){
    if(_uSManager._appContext == null){
      _uSManager.._appContext = appContext
      .._userBloc = BlocProvider.of<UserBloc>(appContext)
      .._cSManager = CasosServicesManager(appContext: appContext);
    }
  }

  @protected
  factory UserServicesManager.forTesting({
    @required BuildContext appContext,
    @required UserBloc userBloc,
    @required CasosServicesManager casosServicesManager
  }){
    _initInitialTestingElements(appContext, userBloc, casosServicesManager);
    return _uSManager;
  }

  static void _initInitialTestingElements(BuildContext appContext, UserBloc userBloc, CasosServicesManager casosServicesManager){
    if(_uSManager._appContext == null){
      _uSManager.._appContext = appContext
      .._userBloc = userBloc
      .._cSManager = casosServicesManager;
    }
  }
  // ****************** Fin del modelo Singleton

  BuildContext _appContext;
  UserBloc _userBloc;
  CasosServicesManager _cSManager;

  set appContext(BuildContext appContext){
    this._appContext = appContext;
  }

  Future<void> manageRegisterProcess(Map<String, dynamic> registerData)async{
    try{
      //String name, String email, String password, String confirmedPassword
      final Map<String, dynamic> response = await userService.register(registerData);
      final String accessToken = response['data']['original']['access_token'];
      final SetAccessToken setAccTokenEvent = SetAccessToken(accessToken: accessToken, onAccessTokenYielded: _onAccessTokenYielded);
      _userBloc.add(setAccTokenEvent);
    }on ServiceStatusErr catch(err){
      print(err);
    }catch(err){
      print(err);
    }
  }

  Future<void> manageLoginProccess(String email, String password)async{
    try{
      await login(email, password);
    }on ServiceStatusErr catch(err){
      print(err);      
    }catch(err){
      print(err);
    }
  }

  Future<void> login(String email, password)async{
    final Map<String, dynamic> serviceBody = _generateLoginServiceBody(email, password);
    final Map<String, dynamic> loginResponse = await userService.login(serviceBody);
    final String accessToken = loginResponse['data']['original']['access_token'];
    final SetAccessToken setAccTokenEvent = SetAccessToken(accessToken: accessToken, onAccessTokenYielded: _onAccessTokenYielded);
    _userBloc.add(setAccTokenEvent);
  }

  Future<void> _onAccessTokenYielded()async{
    print('Access token: ${_userBloc.state.accessToken}');
    await getUserInformation();
  }

  Map<String, dynamic> _generateLoginServiceBody(String email, String password){
    return {
      'email':email,
      'password':password
    };
  }

  Future<void> getUserInformation()async{
    try{
      final Map<String, dynamic> body = _generateAccessTokenBody();
      final Map<String, dynamic> serviceResponse = await userService.getUserInformation(body);
      final Map<String, dynamic> userMap = serviceResponse['data']['original'];
      final User user = User.fromJson(userMap);
      final SetUserInformation setUserInformationEvent = SetUserInformation(user: user, onUserInformationLoaded: _onUserInformationLoaded);
      _userBloc.add(setUserInformationEvent);
    }on ServiceStatusErr catch(err){
      print(err);      
    }catch(err){
      print(err);
    }
  }

  Future<void> _onUserInformationLoaded()async{
    await _cSManager.loadCasos();
    Navigator.of(_appContext).pushReplacementNamed(CasosHomePage.route);
  }

  Future<void> manageLogoutProccess()async{
    try{
      final Map<String, dynamic> body = _generateAccessTokenBody();
      final Map<String, dynamic> response = await userService.logout(body);
      _userBloc.add(ResetUserInformation());
    }on ServiceStatusErr catch(err){
      print(err);      
    }catch(err){
      print(err);
    }
  }

  Future<void> refreshAccessToken(String lastAccessToken)async{
    try{
      final Map<String, dynamic> body = {
        'token':lastAccessToken
      };
      final Map<String, dynamic> response = await userService.refreshAccessToken(body);
      final String newAccessToken = response['data']['original']['access_token'];
      final SetAccessToken setAccessTokenEvent = SetAccessToken(accessToken: newAccessToken, onAccessTokenYielded: _onAccessTokenYielded);
      _userBloc.add(setAccessTokenEvent);
    }on ServiceStatusErr catch(err){
      print(err);      
    }catch(err){
      print(err);
    }
  }

  Map<String, dynamic> _generateAccessTokenBody(){
    final String accessToken = _userBloc.state.accessToken;
    return {
      'token':accessToken
    };
  }

}