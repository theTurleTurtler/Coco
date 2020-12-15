import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:coco/utils/google_services/google_services.dart' as googleServices;

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    switch(event.runtimeType){
      case UpdatePosition:
        //TODO: implementar el método correspondiente
        yield state.copyWith();
      break;
      case UpdatePositionFromStringDirection:
        final LatLng newPosition = await _generateNewPositionFromStringDirection(event as UpdatePositionFromStringDirection);
        yield state.copyWith(currentPosition: newPosition);
      break;
    }
  }

  Future<LatLng> _generateNewPositionFromStringDirection(UpdatePositionFromStringDirection event)async{
    final String stringDirection = event.direction;
    final LatLng newPosition = await googleServices.getUbicacionFromDireccionString(stringDirection);
    return newPosition;
  }
}
