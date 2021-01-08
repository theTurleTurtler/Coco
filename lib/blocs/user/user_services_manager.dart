import 'package:coco/blocs/user/user_bloc.dart';
import 'package:coco/errors/services/service_status_err.dart';
import 'package:coco/models/user.dart';
import 'package:coco/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:coco/blocs/bloc/casos_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserServicesManager{
  // ******************* Modelo Singleton
  static final UserServicesManager _csManager = UserServicesManager._internal();
  UserServicesManager._internal();

  factory UserServicesManager({
    BuildContext appContext
  }){
    _initInitialElements(appContext);
    return _csManager;
  }
  
  static void _initInitialElements(BuildContext appContext){
    if(_csManager._appContext == null){
      _csManager.._appContext = appContext
      .._userBloc = BlocProvider.of<UserBloc>(appContext);
    }
  }

  @protected
  factory UserServicesManager.forTesting({
    @required BuildContext appContext,
    @required UserBloc userBloc,
  }){
    _initInitialTestingElements(appContext, userBloc);
    return _csManager;
  }

  static void _initInitialTestingElements(BuildContext appContext, UserBloc userBloc){
    if(_csManager._appContext == null){
      _csManager.._appContext = appContext
      .._userBloc = userBloc;
    }
  }
  // ****************** Fin del modelo Singleton

  BuildContext _appContext;
  UserBloc _userBloc;

  Future<void> register(String name, String email, String password, String confirmedPassword)async{
    try{
      final Map<String, dynamic> serviceBody = _generateRegisterServiceBody(name, email, password, confirmedPassword);
      final Map<String, dynamic> response = await userService.register(serviceBody);
      final String accessToken = response['data']['original']['access_token'];
      final SetAccessToken setAccTokenEvent = SetAccessToken(accessToken: accessToken);
      _userBloc.add(setAccTokenEvent);
    }on ServiceStatusErr catch(err){
      print(err);
    }catch(err){
      print(err);
    }
  }

  Map<String, dynamic> _generateRegisterServiceBody(String name, String email, String password, String confirmedPassword){
    return {
      'name':name,
      'email':email,
      'password':password,
      'confirmed_password':confirmedPassword
    };
  }

  Future<void> login(String email, String password)async{
    try{
      final Map<String, dynamic> serviceBody = _generateLoginServiceBody(email, password);
      final Map<String, dynamic> response = await userService.login(serviceBody);
      final String accessToken = response['data']['original']['access_token'];
      final SetAccessToken setAccTokenEvent = SetAccessToken(accessToken: accessToken);
      _userBloc.add(setAccTokenEvent);
    }on ServiceStatusErr catch(err){

    }catch(err){

    }
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
      final SetUserInformation setUserInformationEvent = SetUserInformation(user: user);
      _userBloc.add(setUserInformationEvent);
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