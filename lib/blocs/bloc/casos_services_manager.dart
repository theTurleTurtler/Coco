import 'package:coco/blocs/bloc/casos_bloc.dart';
import 'package:coco/blocs/user/user_bloc.dart';
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
}