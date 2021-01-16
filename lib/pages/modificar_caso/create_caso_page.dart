import 'package:coco/blocs/map/map_bloc.dart';
import 'package:coco/blocs/multimedia_container/multimedia_container_bloc.dart';
import 'package:coco/pages/apertura_exitosa_de_caso_page.dart';
import 'package:coco/pages/modificar_caso/modificar_caso_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateCasoPage extends ModificarCasoPage {
  CreateCasoPage()
  ;

  @override
  void submmit(BuildContext context)async{
    // ignore: close_sinks
    final MapBloc mapBloc = BlocProvider.of<MapBloc>(context);
    // ignore: close_sinks
    final MultimediaContainerBloc multiContainerBloc = BlocProvider.of<MultimediaContainerBloc>(context);
    final LatLng mapPosition = mapBloc.state.currentPosition;
    await super.casosServicesManager.createCaso(titulo: super.tituloController.text, descripcion: super.descripcionController.text, 
                                          direccion: super.direccionController.text, latLng: mapPosition, tipo: super.tipoDeSolicitud, multimedia: multiContainerBloc.state.items, 
                                          conoceDatosDeEntidadDestino: super.selectedConoceDatosEntidadDestinoElements[0]);
    multiContainerBloc.add(ResetMultimedia());
    Navigator.of(context).pushReplacementNamed(AperturaExitosaDeCasoPage.route);
  }
  
}
