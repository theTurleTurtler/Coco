import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'modificar_caso_event.dart';
part 'modificar_caso_state.dart';

class ModificarCasoBloc extends Bloc<ModificarCasoEvent, ModificarCasoState> {
  ModificarCasoBloc() : super(ModificarCasoState());

  @override
  Stream<ModificarCasoState> mapEventToState(
    ModificarCasoEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
