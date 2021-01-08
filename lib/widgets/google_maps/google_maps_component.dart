import 'package:coco/blocs/map/map_bloc.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GoogleMapsComponent extends StatefulWidget {

  GoogleMapsComponent();

  @override
  _GoogleMapsComponentState createState() => _GoogleMapsComponentState();
}

class _GoogleMapsComponentState extends State<GoogleMapsComponent> {

  BuildContext _context;
  SizeUtils _sizeUtils;
  
  @override
  Widget build(BuildContext appContext) {
    _initInitialConfiguration(appContext);
    return Container(
      decoration: _createMapBoxDecoration(),
      child: BlocBuilder<MapBloc, MapState>(
        builder: (_, MapState state){
          if(state.currentPosition != null)
            return _createGoogleMapsComponent(state);
          else
            return Container();
        },
      ),
    );
  }

  void _initInitialConfiguration(BuildContext appContext){
    _context = appContext;
    _sizeUtils = SizeUtils();
  }

  BoxDecoration _createMapBoxDecoration(){
    return BoxDecoration(
      color: Theme.of(_context).primaryColor,
      borderRadius: BorderRadius.circular(_sizeUtils.xasisSobreYasis * 0.0075)
    );
  }

  Widget _createGoogleMapsComponent(MapState state){
    final LatLng initialPosition = state.currentPosition;
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: 15.0,
      ),
      markers: {
        _createCurrentPositionMarker(initialPosition)
      },
    );
  }

  Marker _createCurrentPositionMarker(LatLng currentPosition){
    return Marker(
      markerId: MarkerId('0'),
      position: currentPosition,
      draggable: true,
      onDragEnd: (LatLng newPosition){
        //TODO: hacer que se actualice la nueva posición en el mapa
        final MapBloc mapBloc = BlocProvider.of<MapBloc>(context);
        final MapEvent updatePositionEvent = UpdatePosition(newPosition: newPosition);
        mapBloc.add(updatePositionEvent);
      }
    );
  }
}