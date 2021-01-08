import 'package:coco/blocs/bloc/casos_bloc.dart';
import 'package:coco/blocs/user/user_bloc.dart';
import 'package:coco/enums/account_step.dart';
import 'package:mockito/mockito.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MockUserBloc extends Mock implements UserBloc{
  UserState _mockState;
  MockUserBloc() 
  : super(){
    _mockState = UserState();
  }
  @override
  void add(UserEvent event) {
    // TODO: implement add
    switch(event.runtimeType){
      case SetAccessToken:
        _setAccessToken(event as SetAccessToken);
      break;
      case SetUserInformation:
        _setUserInformation(event as SetUserInformation);
      break;
      case ResetUserInformation:
        _resetUserInformation();
      break;
    }
  }

  @override
  void _setAccessToken(SetAccessToken event){
    this._mockState = this._mockState.copyWith(accountStep: AccountStep.WITH_ACCESS_TOKEN, accessToken: event.accessToken);
  }

  @override
  void _setUserInformation(SetUserInformation event){
    this._mockState = this._mockState.copyWith(accountStep: AccountStep.LOGGED, user: event.user);
  }

  @override
  void _resetUserInformation(){
    this._mockState = this._mockState.reset();
  }

  @override
  UserState get state => this._mockState;
}

class MocCasosBloc extends Mock implements CasosBloc{
  CasosState _mockState;
  MocCasosBloc() 
  : super(){
    _mockState = CasosState();
  }
  @override
  void add(CasosEvent event) {
    // TODO: implement add
    switch(event.runtimeType){
      case SetCasos:
        _setAuthorizationToken(event as SetCasos);
      break;
    }
  }

  @override
  void _setAuthorizationToken(SetCasos event){
    this._mockState = this._mockState.copyWith(cargados: true, casos: event.casos);
  }

  @override
  CasosState get state => this._mockState;
}

