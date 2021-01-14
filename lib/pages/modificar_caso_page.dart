import 'dart:io';
import 'package:coco/blocs/casos/casos_services_manager.dart';
import 'package:coco/blocs/multimedia_container/multimedia_container_bloc.dart';
import 'package:coco/widgets/multimedia/multimedia_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coco/blocs/map/map_bloc.dart';
import 'package:coco/enums/tipo_widget_caso_form.dart';
import 'package:coco/models/caso.dart';
import 'package:coco/pages/apertura_exitosa_de_caso_page.dart';
import 'package:coco/pages/casos_home_page.dart';
import 'package:coco/widgets/google_maps/little_static_map.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/widgets/header_bar/header_bar.dart';
import 'package:coco/utils/static_data/strings_utils.dart' as strings;
import 'package:coco/utils/dialogs.dart' as dialogs;
import 'package:google_maps_flutter/google_maps_flutter.dart';
/**
 * Tiene tres constructores debido a que se deben implementar tres vistas
 * distintas (crear, editar, proponer), pero con los mismos componentes, 
 * solo con algunos pocos cambios entre ellos.
 */
//TODO: Buscar un mejor nombre para la clase
// ignore: must_be_immutable
class ModificarCasoPage extends StatefulWidget {
  static final routeCrear = 'crear_caso';
  static final routeEditar = 'editar_caso';
  static final routeAportar = 'aportar_a_caso';
  /**
   * El tipo de widget que este será(el propósito que cumplirá)
   * -hay tres posibles tipos-
   */
  final TipoWidgetCasoForm _tipoWidgetCasoForm;
  final bool _isAlreadyCreated;

  //solo se instanciará si este widget no es para crear (_isAlreadyCreated)
  @protected
  Caso caso;

  ModificarCasoPage.crear()
  : _tipoWidgetCasoForm = TipoWidgetCasoForm.CREAR,
    _isAlreadyCreated = false
  ;

  ModificarCasoPage.editar()
  : _tipoWidgetCasoForm = TipoWidgetCasoForm.EDITAR,
    _isAlreadyCreated = true
  ;

  ModificarCasoPage.proponer()
  : _tipoWidgetCasoForm = TipoWidgetCasoForm.APORTAR,
    _isAlreadyCreated = true
  ;

  @override
  _ModificarCasoPageState createState() => _ModificarCasoPageState();
}

class _ModificarCasoPageState extends State<ModificarCasoPage> {
  BuildContext _context;
  SizeUtils _sizeUtils;
  CasosServicesManager _casosServicesManager;
  String _submitNavigationRoute;
  String _title;

  String _tipoDeSolicitud = strings.tiposDeSolicitud[0];
  List<bool> _selectedConoceDatosEntidadDestinoElements = [
    false,
    true
  ];
  String _tituloCaso = '';
  String _descripcionCaso = '';
  String _direccion = '';

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SingleChildScrollView(
        child: SafeArea(
          child: _crearComponentes(),
        ),
      )
    );
  }
  
  void _initInitialConfiguration(BuildContext context){
    _context = context;
    _sizeUtils = SizeUtils();
    _casosServicesManager = CasosServicesManager(appContext: context);
    if(widget._isAlreadyCreated){
      _initCaso();
      _initInitialInputValues();
    }
    _initValoresDependientesDeTipoWidget();
  }
  
  /*
    Lo pongo en una función aparte para cuando haga el testing pueda cambiar esta función.
  */
  void _initCaso(){
    widget.caso = ModalRoute.of(context).settings.arguments;
  }

  void _initInitialInputValues(){
    _tipoDeSolicitud = widget.caso.tipoDeSolicitud;
    _initInitialToggleElements();
    _tituloCaso = widget.caso.titulo;
    _descripcionCaso = widget.caso.descripcion;
    _direccion = widget.caso.direccion;
    //TODO: Implementar el resto de elementos
  }

  void _initInitialToggleElements(){
    if(!widget.caso.conoceDatosDeEntidadDestino){
      _selectedConoceDatosEntidadDestinoElements = [
        false,
        true
      ];
    }   
  }

  Widget _crearComponentes(){
    return Container(
      height: _sizeUtils.xasisSobreYasis * 1.25,
      child: ListView(
        padding: EdgeInsets.only(bottom: _sizeUtils.xasisSobreYasis * 0.03),
        children: [
          HeaderBar(),
          _crearBodyComponents()
        ],
      ),
    );
  }

  Widget _crearBodyComponents(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _sizeUtils.xasisSobreYasis * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          _crearTitulo(),
          SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
          _createInputTipoSolicitud(),
          SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
          _createButtonConocerDatosEntidadDestino(),
          SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
          _createComponentNombreCaso(),
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          _createComponentDescripcionCaso(),
          SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
          _createComponentDireccion(),
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          _crearGoogleMapsComponent(),
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          _createBotonAdjuntar(),
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          MultimediaContainer(),
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          _createBotonSubmit()
        ],
      ),
    );
  }

  Widget _crearTitulo(){   
    return Center(
      child: Text(
        _title,
        style: TextStyle(
          fontSize: _sizeUtils.titleSize,
          color: Colors.black54
        ),
      ),
    );
  }

  void _initValoresDependientesDeTipoWidget(){
    switch(widget._tipoWidgetCasoForm){
      case TipoWidgetCasoForm.CREAR:
        _title = 'CREAR UN CASO';
        _submitNavigationRoute = AperturaExitosaDeCasoPage.route;
      break;
      case TipoWidgetCasoForm.EDITAR:
        _title = 'EDITAR CASO';
        _submitNavigationRoute = CasosHomePage.route;
      break;
      case TipoWidgetCasoForm.APORTAR:
        _title = 'APORTAR AL CASO';
        _submitNavigationRoute = CasosHomePage.route;
      break;
    }
  }

  Widget _createInputTipoSolicitud(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _createLabel('Tipo de solicitud'),
        _createDropdown()
      ],
    );
  }

  Widget _createDropdown(){
    List<DropdownMenuItem<String>> items = _crearTipoDeSolicitudItems();
    return DropdownButton<String>(
      value: _tipoDeSolicitud,
      items: items,
      onChanged: (String newValue){
        _tipoDeSolicitud = newValue;
        setState(() {
          
        });
      },
    );
  }

  List<DropdownMenuItem<String>> _crearTipoDeSolicitudItems(){
    List<DropdownMenuItem<String>> items = [];
    strings.tiposDeSolicitud.forEach((String currentTipo) {
      final DropdownMenuItem<String> item = DropdownMenuItem<String>(
        value: currentTipo,
        child: Container(
          child: Text(currentTipo),
        ),
      );
      items.add(item);
    });
    return items;
  }

  Widget _createButtonConocerDatosEntidadDestino(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _createLabel('Conoce los datos de la entidad destino'),
        _crearOpcionesButton()
      ],
    );
  }

  Widget _crearOpcionesButton(){
    return Container(
      width: _sizeUtils.xasisSobreYasis * 0.14,
      height: _sizeUtils.xasisSobreYasis * 0.07,
      decoration: _createOpcionesButtonDecoration(),
      child: Row(
        children: [
          _crearToggleButtonsItem('Sí', 0),
          _crearToggleButtonsItem('No', 1)
        ],
      ),
    );
  }

  BoxDecoration _createOpcionesButtonDecoration(){
    return BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(_sizeUtils.xasisSobreYasis * 0.07)
    );
  }

  Widget _crearToggleButtonsItem(String text, int indexButton){
    return GestureDetector(
      child: Container(
        width: _sizeUtils.xasisSobreYasis * 0.07,
        height: _sizeUtils.xasisSobreYasis * 0.07,
        decoration: _createToggleButtonsItemDecoration(indexButton),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black
            ),
          )
        ),
      ),
      onTap: (){
        _selectedConoceDatosEntidadDestinoElements[(indexButton-1)%2] = false;
        _selectedConoceDatosEntidadDestinoElements[indexButton] = true;
        setState(() {
          
        });
      },
    );
  }

  BoxDecoration _createToggleButtonsItemDecoration(int indexButton){
    final Color itemColor = (_selectedConoceDatosEntidadDestinoElements[indexButton])? Colors.green[600] : Colors.grey[300];
    return BoxDecoration(
      color: itemColor,
      borderRadius: BorderRadius.circular(_sizeUtils.xasisSobreYasis * 0.1)
    );
  }

  Widget _createComponentNombreCaso(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _createLabel('Nombre del caso'),
        _createInputNombreCaso()
      ],
    );
  }

  Widget _createInputNombreCaso(){
    return Container(
      width: _sizeUtils.xasisSobreYasis * 0.25,
      child: TextFormField(
        initialValue: _tituloCaso,
        onChanged: (String newValue){
          _tituloCaso = newValue;
        },
      ),
    );
  }

  Widget _createComponentDescripcionCaso(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _createWithOutWidthLabel('Descripción'),
        _createInputDescripcionCaso()
      ],
    );
  }

  Widget _createInputDescripcionCaso(){
    return Container(
      height: _sizeUtils.xasisSobreYasis * 0.35,
      child: TextFormField(
        initialValue: _descripcionCaso,
        maxLines: 15,
        maxLength: 300,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[250],
          border: _crearDescripcionInputBorder(),
          enabledBorder: _crearDescripcionInputBorder(),
          focusedBorder: _crearDescripcionInputBorder()
        ),
        onChanged: (String newValue){
          _descripcionCaso = newValue;
        },
      ),
    );
  }

  InputBorder _crearDescripcionInputBorder(){
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white
      )
    );
  }

  Widget _createComponentDireccion(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _createLabel('Dirección'),
        _crearInputDireccion()
      ],
    );
  }

  Widget _crearInputDireccion(){
    return Container(
      width: _sizeUtils.xasisSobreYasis * 0.25,
      child: TextFormField(
        initialValue: _direccion,
        onChanged: (String newValue){
          _direccion = newValue;
        },
        onEditingComplete: _onInputDirectionEditingComplete,
      ),
    );
  }

  void _onInputDirectionEditingComplete(){
    if(widget._tipoWidgetCasoForm == TipoWidgetCasoForm.CREAR){
      final MapBloc mapaBloc = BlocProvider.of<MapBloc>(context);
      final UpdatePositionFromStringDirection event = UpdatePositionFromStringDirection(direction: _direccion);
      mapaBloc.add(event);
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  Widget _createLabel(String text){
    return Container(
      width: _sizeUtils.xasisSobreYasis * 0.3,
      child: Text(
        text,
        maxLines: 2,
        style: TextStyle(
          fontSize: _sizeUtils.littleLabelTextSize
        ),
      ),
    );
  }

  Widget _crearGoogleMapsComponent(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _createWithOutWidthLabel('Localización'),
        SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
        _crearGoogleMaps()
      ],
    );
  }

  Widget _createWithOutWidthLabel(String texto){
    return Text(
      texto,
      maxLines: 2,
      style: TextStyle(
        fontSize: _sizeUtils.littleLabelTextSize
      ),
    );
  }

  Widget _crearGoogleMaps(){
    return LittleStaticMap(heightPercentage: 0.45);
  }

  Widget _createBotonAdjuntar(){
    return Container(
      width: _sizeUtils.xasisSobreYasis * 0.38,
      child: MaterialButton(
        elevation: 0,
        padding: _createBotonAdjuntarPadding(),
        color: Colors.grey.withOpacity(0.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _createBotonAdjuntarIcon(),
            _createBotonAdjuntarText()
          ],
        ),
        onPressed: _onPressAdjuntar,
      ),
    );
  }

  void _onPressAdjuntar()async{
    try{
      final MultimediaContainerBloc mCBloc = BlocProvider.of<MultimediaContainerBloc>(_context);
      final Map<String, File> loadedFile = {};
      await dialogs.executeLoadFile(_context, loadedFile);
      final File newFile = loadedFile['file'];
      if(newFile == null)
        return;
      final SetMultimediaItem setMultiMedItemEvent = SetMultimediaItem(item: newFile, onFileFormatErr: _onFileFormatErr);
      mCBloc.add(setMultiMedItemEvent);
    }catch(err){
      print(err);
    }
  }

  void _onFileFormatErr({String fileName}){
    print('El archivo $fileName no cumple con los formatos aceptados por la app');
  }

  EdgeInsets _createBotonAdjuntarPadding(){
    return EdgeInsets.symmetric(
      vertical: _sizeUtils.xasisSobreYasis * 0.005,
      horizontal: _sizeUtils.xasisSobreYasis * 0.005
    );
  }

  Widget _createBotonAdjuntarIcon(){
    return Container(
      padding: EdgeInsets.all(_sizeUtils.xasisSobreYasis * 0.005),
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(_sizeUtils.xasisSobreYasis * 0.1)
      ),
      child: Icon(
        Icons.camera_alt,
        color: Colors.white,
      ),
    );
  }

  Widget _createBotonAdjuntarText(){
    return Text(
      'Agregar imágenes/vídeos',
      style: TextStyle(
        color: Colors.black.withOpacity(0.75),
        fontSize: _sizeUtils.xasisSobreYasis * 0.025
      ),
    );
  }

  Widget _createBotonSubmit(){
    final Map<String, double> padding = _sizeUtils.largeFlatButtonPadding;
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(horizontal: padding['horizontal']),
      shape: StadiumBorder(),
      child: Text(
        'GUARDAR',
        style: TextStyle(
          color: Colors.white,
          fontSize: _sizeUtils.xasisSobreYasis * 0.025
        ),
      ),
      onPressed: _submit,
    );
  }

  Future<void> _submit()async{
    final MapBloc mapBloc = BlocProvider.of<MapBloc>(context);
    final MultimediaContainerBloc multiContainerBloc = BlocProvider.of<MultimediaContainerBloc>(context);
    final LatLng mapPosition = mapBloc.state.currentPosition;
    await _casosServicesManager.createCaso(titulo: _tituloCaso, descripcion: _descripcionCaso, 
                                          direccion: _direccion, latLng: mapPosition, tipo: _tipoDeSolicitud, multimedia: multiContainerBloc.state.items, 
                                          conoceDatosDeEntidadDestino: _selectedConoceDatosEntidadDestinoElements[0]);
    multiContainerBloc.add(ResetMultimedia());
    Navigator.of(context).pushReplacementNamed(_submitNavigationRoute);
  }
}