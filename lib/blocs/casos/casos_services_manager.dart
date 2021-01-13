import 'dart:io';
import 'package:coco/errors/files_management/file_format_err.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coco/blocs/casos/casos_bloc.dart';
import 'package:coco/blocs/user/user_bloc.dart';
import 'package:coco/errors/services/service_status_err.dart';
import 'package:coco/models/caso.dart';
import 'package:coco/services/casos_service.dart';
import 'package:mime_type/mime_type.dart';


class CasosServicesManager{
  // ******************* Modelo Singleton
  static final CasosServicesManager _csManager = CasosServicesManager._internal();
  CasosServicesManager._internal();

  factory CasosServicesManager({
    @required BuildContext appContext
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

  final List<String> _formatosFotos = ['jpg', 'jpeg', 'png'];
  final List<String> _formatosVideos = ['mp4'];
  BuildContext _appContext;
  CasosBloc _casosBloc;
  UserBloc _userBloc;
  int _currentCreatedCaseId;
  Map<String, dynamic> _currentCreatedCaseMap;
  bool _loadingCasos = false;


  Future<void> createCaso({@required String titulo, @required String descripcion, @required String direccion, 
                           @required LatLng latLng, @required String tipo, @required List<File> multimedia, 
                           @required bool conoceDatosDeEntidadDestino})async
  {
    try{
      _currentCreatedCaseMap = {};
      await _cargarCasoId();
      await _createTituloCaso(titulo);
      await _createTipoCaso(tipo);
      await _createDescripcionCaso(descripcion);
      await _createDireccionCaso(direccion);   
      await _createLagLngCaso(latLng.latitude, latLng.longitude); 
      await _createMultimedia(multimedia);
      //_assertNewCaso(multimedia);
      await loadCasos();
      _currentCreatedCaseMap = null; 
    }on ServiceStatusErr catch(err){
      print(err);
    }catch(err){
      print(err);
    }
  }

  Future<void> _cargarCasoId()async{
    final Map<String, dynamic> requestBody = _generateAccessTokenBody(); 
    final Map<String, dynamic> requestResponse = await casosService.createCaso(requestBody);
    _currentCreatedCaseId = requestResponse['data']['id'];
    _currentCreatedCaseMap['id'] = _currentCreatedCaseId;
    _currentCreatedCaseMap['rutas'] = requestResponse['data']['rutas'];
  }

  Future<void> _createTituloCaso(String titulo)async{
    final Map<String, dynamic> requestBody = _generateCreatePartBodyWithSingleValue('titulo', titulo);
    final Map<String, dynamic> serviceResponse = await casosService.createTitulo(requestBody);
    _currentCreatedCaseMap['titulo'] = serviceResponse['data'];
  }

  Future<void> _createTipoCaso(String tipo)async{
    final Map<String, dynamic> requestBody = _generateCreatePartBodyWithSingleValue('tipo', tipo);
    final Map<String, dynamic> serviceResponse = await casosService.createTipo(requestBody);
    serviceResponse['data']['tipo'] = serviceResponse['data']['tipoCaso'];
    _currentCreatedCaseMap['tipo'] = serviceResponse['data'];
  }

  Future<void> _createDescripcionCaso(String descripcion)async{
    final Map<String, dynamic> requestBody = _generateCreatePartBodyWithSingleValue('descripcion', descripcion);
    final Map<String, dynamic> serviceResponse = await casosService.createDescripcion(requestBody);
    _currentCreatedCaseMap['descripcion'] = serviceResponse['data'];
  }

  Future<void> _createDireccionCaso(String direccion)async{
    final Map<String, dynamic> requestBody = _generateCreatePartBodyWithSingleValue('direccion', direccion);
    final Map<String, dynamic> serviceResponse = await casosService.createDireccion(requestBody);
    _currentCreatedCaseMap['direccion'] = serviceResponse['data'];
  }

  Future<void> _createLagLngCaso(double lat, double long)async{
    final Map<String, dynamic> requestBody = _generateGeneralCreatePartBody();
    requestBody['latitud'] = lat;
    requestBody['longitud'] = long;
    final Map<String, dynamic> serviceResponse = await casosService.createLatLong(requestBody);
    _currentCreatedCaseMap['latLong'] = serviceResponse['data'];
  }

  Future<void> _createMultimedia(List<File> multimediaItems)async{
    final Map<String, String> requestHeaders = {'Content-Type':'application/x-www-form-urlencoded'};
    final Map<String, String> requestFields = _generateGeneralBodyFields();
    List<File> photos = [];
    List<File> videos = [];
    multimediaItems.forEach((File file){
      final String mimeType = mime(file.path);
      final String groupOfFilesThatAcceptFileFormat = _getGroupOfFilesThatAcceptFileFormat(mimeType, file.path.split('\\').last);
      if(groupOfFilesThatAcceptFileFormat == 'photos')
        photos.add(file);
      else
        videos.add(file);
    });
    final Map<String, List<File>> multimedia = {
      'photos': photos,
      'videos': videos
    };
    //Ignoramos la adición del campo multimedia al json de _currentCreated por problemas debido a que el back envía el campo multimedia de forma distinta en getCasos y en CreateMultimedia
    await casosService.createMultimedia(requestHeaders, requestFields, multimedia);
    _currentCreatedCaseMap['multimedia'] = 'No se implementará la multimedia';
  }

  String _getGroupOfFilesThatAcceptFileFormat(String mimeType, String fileName){
    for(String photoFormat in _formatosFotos){
      if(mimeType.contains(photoFormat))
        return 'photos';
    }
    for(String videoFormat in _formatosVideos){
      if(mimeType.contains(videoFormat))
        return 'videos';
    }
    throw FileFormatErr(fileName: fileName);
  }

  Future<void> loadPublicCasos()async{
    try{
      if(_loadingCasos)
        return;
      _loadingCasos = true;
      final Map<String, dynamic> serviceResponse = await casosService.loadPublicCasos();
      final List<Map<String, dynamic>> casosMap = serviceResponse['data'].cast<Map<String, dynamic>>();
      final List<Caso> casos = casosMap.map<Caso>((Map<String, dynamic> casoMap) => Caso.fromJson(json: casoMap)).toList();
      final SetCasos setCasosEvent = SetCasos(casos: casos);
      _casosBloc.add(setCasosEvent);
      _loadingCasos = false;
    }on ServiceStatusErr catch(err){
      print(err);
    }catch(err){
      print(err);
    }
  }

  Future<void> loadCasos()async{
    try{
      if(_loadingCasos)
        return;
      _loadingCasos = true;
      final Map<String, String> serviceHeaders = _generateAccessTokenHeaders();
      final Map<String, dynamic> serviceResponse = await casosService.loadCasos(serviceHeaders);
      final List<Map<String, dynamic>> casosMap = serviceResponse['data'].cast<Map<String, dynamic>>();
      final List<Caso> casos = casosMap.map<Caso>((Map<String, dynamic> casoMap) => Caso.fromJson(json: casoMap)).toList();
      final SetCasos setCasosEvent = SetCasos(casos: casos);
      _casosBloc.add(setCasosEvent);
      _loadingCasos = false;
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

  Map<String, dynamic> _generateCreatePartBodyWithSingleValue(String partName, String partValue){
    Map<String, dynamic> body = _generateGeneralCreatePartBody();
    body[partName] = partValue;
    return body;
  }

   Map<String, dynamic> _generateGeneralCreatePartBody(){
     Map<String, dynamic> body = _generateAccessTokenBody();
     body['caso_id'] = _currentCreatedCaseId;
     body['seleccionado'] = true;
     return body;
   }

   Map<String, String> _generateGeneralBodyFields(){
     Map<String, String> body = _generateAccessTokenBody().cast<String, String>();
     body['caso_id'] = '$_currentCreatedCaseId';
     body['seleccionado'] = 'true';
     return body;
   }

  Map<String, dynamic> _generateAccessTokenBody(){
    final String accessToken = _userBloc.state.accessToken;
    return {
      'token': accessToken
    };
  }
}