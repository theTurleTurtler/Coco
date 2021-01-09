import 'package:coco/blocs/bloc/casos_bloc.dart';
import 'package:coco/blocs/bloc/casos_services_manager.dart';
import 'package:coco/blocs/user/user_bloc.dart';
import 'package:coco/blocs/user/user_services_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock/blocs.dart';
import 'mock/build_context.dart';

final String _testingGroupDescription = 'Se probarán métodos de user services manager.';
final String _loadCasosDescription = 'Se testeará el método loadCasos';
final String _createCasoDescription = 'Se testeará el método createCaso';

final Map<String, dynamic> _successLoginData = {'email':'email1@gmail.com', 'password':'12345678'};
final BuildContext _context = MockBuildContext();
final UserBloc _userBloc = MockUserBloc();
final CasosBloc _casosBloc = MockCasosBloc();
final UserServicesManager _uSManager = UserServicesManager.forTesting(appContext: _context, userBloc: _userBloc);
final CasosServicesManager _cSManager = CasosServicesManager.forTesting(appContext: _context, userBloc: _userBloc, casosBloc: _casosBloc);

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
      throw err;
    }catch(err){
      fail('No debería haber ocurrido un error: $err');     
    }
  });
}

Future<void> _executeLoadCasosValidations()async{
  await _uSManager.login(_successLoginData['email'], _successLoginData['password']);
  await _cSManager.loadCasos();
  final CasosState _casosState = _casosBloc.state;
  expect(_casosState.estanCargados, true, reason: 'El estado de los casos en el state debería ser cargados');
  expect(_casosState.casos, isNotNull, reason: 'Debe haber casos instanciados en el state');
}