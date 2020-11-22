import 'package:flutter/material.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/widgets/header_bar.dart';
import 'package:coco/utils/strings_utils.dart' as strings;

class CrearCasoPage extends StatefulWidget {

  static final route = 'crear_caso';

  @override
  _CrearCasoPageState createState() => _CrearCasoPageState();
}

class _CrearCasoPageState extends State<CrearCasoPage> {

  BuildContext _context;
  SizeUtils _sizeUtils;

  String _tipoDeSolicitud = strings.tiposDeSolicitud[0];
  List<bool> _selectedToggleElements = [
    true,
    false
  ];
  String _nombreCaso = '';
  String _descripcionCaso = '';
  String _direccion = '';

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: _crearComponentes(),
        ),
      )
    );
  }
  
  void _initInitialConfiguration(BuildContext context){
    _context = context;
    final Size size = MediaQuery.of(_context).size;
    _sizeUtils = SizeUtils();
    _sizeUtils.initUtil(size);
  }

  Widget _crearComponentes(){
    return Container(
      height: _sizeUtils.xasisSobreYasis * 1.25,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: _sizeUtils.xasisSobreYasis * 0.03),
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
          _crearBotonAdjuntar(),
          SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
          _crearBotonSubmit()
        ],
      ),
    );
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
    return ToggleButtons(
      isSelected: _selectedToggleElements,
      fillColor: Colors.blueGrey[800],
      borderRadius: BorderRadius.circular(20),
      borderColor: Colors.blueGrey[800],
      children: [
        _crearToggleButtonsItem('Sí', 0),
        _crearToggleButtonsItem('No', 1)
      ],
      onPressed: (int pressed){
        _selectedToggleElements[(pressed-1)%2] = false;
        _selectedToggleElements[pressed] = true;
        setState(() {
          
        });
      },
    );
  }

  Widget _crearToggleButtonsItem(String text, int indexButton){
    final Color textColor = (_selectedToggleElements[indexButton])? Colors.white : Colors.black87;
    return Container(
      width: _sizeUtils.xasisSobreYasis * 0.1,
      height: _sizeUtils.xasisSobreYasis * 0.04,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor
          ),
        )
      ),
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
        initialValue: _nombreCaso,
        onChanged: (String newValue){
          _nombreCaso = newValue;
        },
      ),
    );
  }

  Widget _createComponentDescripcionCaso(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _createWithOutWidthLabel(),
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
          border: OutlineInputBorder()
        ),
      ),
    );
  }

  Widget _createComponentDireccion(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }

  Widget _createLabel(String text){
    return Container(
      width: _sizeUtils.xasisSobreYasis * 0.3,
      child: Text(
        text,
        maxLines: 2,
        style: TextStyle(
          fontSize: _sizeUtils.normalLabelTextSize
        ),
      ),
    );
  }

  Widget _crearGoogleMapsComponent(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _createWithOutWidthLabel(),
        _crearGoogleMaps()
      ],
    );
  }

  Widget _createWithOutWidthLabel(){
    return Text(
      'Descripción del caso',
      maxLines: 2,
      style: TextStyle(
        fontSize: _sizeUtils.normalLabelTextSize
      ),
    );
  }

  Widget _crearGoogleMaps(){
    return Container(
      height: _sizeUtils.xasisSobreYasis * 0.4,
      width: _sizeUtils.xasisSobreYasis * 0.7,
      decoration: BoxDecoration(
        color: Colors.blueGrey[200]
      ),
      child: Center(
        child: Text('Mapa'),
      ),
    );
  }

  Widget _crearBotonAdjuntar(){
    return MaterialButton(
      color: Colors.black87,
      shape: StadiumBorder(),
      child: Text(
        'Agregar imágenes/vídeos',
        style: TextStyle(
          color: Colors.white,
          fontSize: _sizeUtils.xasisSobreYasis * 0.025
        ),
      ),
      onPressed: (){

      },
    );
  }

  Widget _crearBotonSubmit(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          color: Colors.black87,
          shape: StadiumBorder(),
          child: Text(
            'Guardar',
            style: TextStyle(
              color: Colors.white,
              fontSize: _sizeUtils.xasisSobreYasis * 0.025
            ),
          ),
          onPressed: (){

          },
        ),
      ],
    );
  }

  bool _getConocerDatosDeEntidad(){
    if(_selectedToggleElements[0])
      return true;
    return false;
  }
  
}