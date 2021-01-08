import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coco/models/caso.dart';
import 'package:meta/meta.dart';

part 'casos_event.dart';
part 'casos_state.dart';

class CasosBloc extends Bloc<CasosEvent, CasosState> {
  CasosState _currentYieldedState;

  CasosBloc() : super(CasosState());

  @override
  Stream<CasosState> mapEventToState(
    CasosEvent event,
  ) async* {
    switch(event.runtimeType){
      case SetCasos:
        _setCasos(event as SetCasos);
        yield _currentYieldedState;
      break;
    }
  }

  void _setCasos(SetCasos event){
    final List<Caso> casos = event.casos;
    _currentYieldedState = state.copyWith(cargados: true, casos: casos);
  }
}
