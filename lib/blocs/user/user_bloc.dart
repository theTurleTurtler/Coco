import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coco/enums/account_step.dart';
import 'package:coco/errors/services/service_status_err.dart';
import 'package:coco/models/user.dart';
import 'package:coco/services/user_service.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService = UserService();
  UserState _currentNewState;

  UserBloc() : super(UserState());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    // TODO: implement mapEventToState
    switch(event.runtimeType){
      case AddAccessToken:
        _addAccessToken(event as AddAccessToken);
        yield _currentNewState;
      break;
      case AddUserInformation:
        _addUserInformation(event as AddUserInformation);
        yield _currentNewState;
      break;
      case Register:
        await _register(event as Register);
        yield _currentNewState;
      break;
      case Login:
        await _login(event as Login);
        yield _currentNewState;
      break;
      case GetUserInformation:
        _getUserInformation(event as GetUserInformation);
        yield _currentNewState;
      break;
      case RefreshAccessToken:
        await _refreshAuthorizationToken(event as RefreshAccessToken);
        yield _currentNewState;
      break;
      case Logout:
        await _logout(event as Logout);
        yield _currentNewState;
      break;
    }
  }

  void _addAccessToken(AddAccessToken event){
    _currentNewState = state.copyWith(
      accountStep: AccountStep.WITH_ACCESS_TOKEN,
      accessToken: event.accessToken
    );
  }

  void _addUserInformation(AddUserInformation event){
    _currentNewState = state.copyWith(
      accountStep: AccountStep.LOGGED,
      user: event.user
    );
  }

  Future<void> _register(Register event)async{
    try{
      final Map<String, dynamic> bodyData = _generateRegisterBodyData(event);
      final Map<String, dynamic> response = await _userService.register(bodyData);
      final String accessToken = response['data']['original']['access_token'];
      _convertCurrentNewStateToAcountWithAccessToken(accessToken);
    }on ServiceStatusErr catch(_){
      //TODO: Implementar manejo para este error
      print('on ServiceStatusErr');
    }catch(err){
      //TODO: Implementar manejo para este error
      print('on err');
    }
    return null;
  }

  Map<String, dynamic> _generateRegisterBodyData(Register event){
    final Map<String, dynamic> bodyData = {
      'name':event.name,
      'email':event.email,
      'password':event.password,
      'confirmed_password':event.confirmedPassword
    };
    return bodyData;
  }

  Future<void> _login(Login event)async{
    try{
      final Map<String, dynamic> bodyData = _generateLoginBodyData(event);
      final Map<String, dynamic> response = await _userService.login(bodyData);
      final String accessToken = response['data']['original']['access_token'];
      _convertCurrentNewStateToAcountWithAccessToken(accessToken);
    }on ServiceStatusErr catch(_){
      //TODO: Implementar manejo para este error
      print('on ServiceStatusErr');
    }catch(err){
      //TODO: Implementar manejo para este error
      print('on err');
    }
    return null;
  }

  Map<String, dynamic> _generateLoginBodyData(Login event){
    final Map<String, dynamic> bodyData = {
      'email':event.email,
      'password':event.password
    };
    return bodyData;
  }

  Future<void> _getUserInformation(GetUserInformation event)async{
    try{
      final Map<String, dynamic> bodyData = _generateTokenBodyData(event);
      final Map<String, dynamic> response = await _userService.getUserInformation(bodyData);
      _generateGetUserInformationNewState(response);
    }on ServiceStatusErr catch(_){
      //TODO: Implementar manejo para este error
      print('on ServiceStatusErr');
    }catch(err){
      //TODO: Implementar manejo para este error
      print('on err');
    }
  }

  void _generateGetUserInformationNewState(Map<String, dynamic> serviceResponse){
    final Map<String, dynamic> userInformation = serviceResponse['data']['original'];
    final User user = User.fromJson(userInformation);
    _currentNewState = state.copyWith(
      accountStep: AccountStep.LOGGED,
      user: user
    );
  }

  Future<void> _refreshAuthorizationToken(RefreshAccessToken event)async{
    try{
      final Map<String, dynamic> bodyData = _generateTokenBodyData(event);
      final Map<String, dynamic> response = await _userService.refreshAccessToken(bodyData);
      final String accessToken = response['data']['original']['access_token'];
      _convertCurrentNewStateToAcountWithAccessToken(accessToken);
    }on ServiceStatusErr catch(_){
      //TODO: Implementar manejo para este error
      print('on ServiceStatusErr');
    }catch(err){
      //TODO: Implementar manejo para este error
      print('on err');
    }
    return null;
  }

  void _convertCurrentNewStateToAcountWithAccessToken(String accessToken){
    _currentNewState = state.copyWith(
      accountStep: AccountStep.WITH_ACCESS_TOKEN,
      accessToken: accessToken
    );
  }

  Future<void> _logout(Logout event)async{
    try{
      final Map<String, dynamic> bodyData = _generateTokenBodyData(event);
      final Map<String, dynamic> response = await _userService.logout(bodyData);
      _generateInitialState();
    }on ServiceStatusErr catch(_){
      //TODO: Implementar manejo para este error
      print('on ServiceStatusErr');
    }catch(err){
      //TODO: Implementar manejo para este error
      print('on err');
    }
  }

  void _generateInitialState(){
    _currentNewState = state.copyWith(
      accountStep: AccountStep.UNLOGGED,
      user: null
    );
  }

  Map<String, dynamic> _generateTokenBodyData(UserEventWithOnlyAccessTokenBody event){
    return {
      'access_token':event.accessToken
    };
  }
}
