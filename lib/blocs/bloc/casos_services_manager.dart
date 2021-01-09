import 'package:coco/blocs/bloc/casos_bloc.dart';
import 'package:coco/blocs/user/user_bloc.dart';
import 'package:coco/errors/services/service_status_err.dart';
import 'package:coco/models/caso.dart';
import 'package:coco/services/casos_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CasosServicesManager{
  // ******************* Modelo Singleton
  static final CasosServicesManager _csManager = CasosServicesManager._internal();
  CasosServicesManager._internal();

  factory CasosServicesManager({
    BuildContext appContext
  }){
    _initInitialElements(appContext);
    return _csManager;
  }
  
  static void _initInitialElements(BuildContext appContext){
    if(_csManager._appContext == null){
      _csManager.._appContext = appContext
      .._userBloc = BlocProvider.of<UserBloc>(appContext)
      .._casosBloc = BlocProvider.of<CasosBloc>(appContext);
    }
  }

  @protected
  factory CasosServicesManager.forTesting({
    @required BuildContext appContext,
    @required UserBloc userBloc, 
    @required CasosBloc casosBloc,
  }){
    _initInitialTestingElements(appContext, userBloc, casosBloc);
    return _csManager;
  }

  static void _initInitialTestingElements(BuildContext appContext, UserBloc userBloc, CasosBloc casosBloc){
    if(_csManager._appContext == null){
      _csManager.._appContext = appContext
      .._userBloc = userBloc
      .._casosBloc = casosBloc;
    }
  }
  // ****************** Fin del modelo Singleton

  BuildContext _appContext;
  CasosBloc _casosBloc;
  UserBloc _userBloc;

  Future<void> loadCasos()async{
    try{
      final Map<String, String> serviceHeaders = _generateAccessTokenHeaders();
      final Map<String, dynamic> serviceResponse = await casosService.loadCasos(serviceHeaders);
      final List<Map<String, dynamic>> casosMap = serviceResponse['data'].cast<Map<String, dynamic>>();
      final List<Caso> casos = casosMap.map<Caso>((Map<String, dynamic> casoMap) => Caso.fromJson(json: casoMap)).toList();
      final SetCasos setCasosEvent = SetCasos(casos: casos);
      _casosBloc.add(setCasosEvent);
    }on ServiceStatusErr catch(err){
      print(err);
    }catch(err){
        print(err);
    }
  }

  Map<String, String> _generateAccessTokenHeaders(){
    final String accessToken = _userBloc.state.accessToken;
    return {
      'Authorization': 'Bearer $accessToken'
    };
  }

  Map<String, dynamic> _generateAccessTokenBody(){
    final String accessToken = _userBloc.state.accessToken;
    return {
      'token': accessToken
    };
  }
}