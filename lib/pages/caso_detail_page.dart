import 'dart:io';

import 'package:flutter/material.dart';
import 'package:coco/models/caso.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/widgets/header_bar/header_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CasoDetailPage extends StatelessWidget {

  static final route = 'caso_detail';
  
  BuildContext _context;
  SizeUtils _sizeUtils;
  Caso _caso;

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SafeArea(
        child: Container(
          child: ListView(
            padding: EdgeInsets.only(bottom: _sizeUtils.littleSizedBoxHeigh),
            children: [
              HeaderBar(),
              SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
              _createBodyComponents()
            ],
          ),
      ),
      )
    );
  }

  void _initInitialConfiguration(BuildContext context){
    _context = context;
    _sizeUtils = SizeUtils();
    _caso = ModalRoute.of(context).settings.arguments;
  }

  Widget _createBodyComponents(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _sizeUtils.xasisSobreYasis * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _crearTitulo(),
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          _crearCiudad(),
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          _crearDescricion(),
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          _crearDireccion(),
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          _crearMapa(),
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          _crearMultimediaComponents(),
          SizedBox(height: _sizeUtils.largeSizedBoxHeigh),
          _crearBotonAportar(),
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          _crearBotonRegresar()
        ],
      ),
    );
  }

  Widget _crearTitulo(){
    return Text(
      _caso.titulo,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: _sizeUtils.subtitleSize,
        fontWeight: FontWeight.bold
      ),
    );
  }
  
  Widget _crearCiudad(){
    return Text(
      _caso.direccion,
      style: TextStyle(
        fontSize: _sizeUtils.titleSize,
        color: Colors.black87
      ),
    );
  }

  Widget _crearDescricion(){
    return Text(
      _caso.descripcion,
      style: TextStyle(
        fontSize: _sizeUtils.subtitleSize
      ),
    );
  }

  Widget _crearDireccion(){
    return Text(
      'Av. cll 40 # 13 - 73',
      style: TextStyle(
        fontSize: _sizeUtils.subtitleSize
      ),
    );
  }

  Widget _crearMapa(){
    //TODO: implementar el googlemaps
    return Container(
      //width: _sizeUtils.xasisSobreYasis * 0.6,
      height: _sizeUtils.xasisSobreYasis * 0.6,
      decoration: BoxDecoration(
        color: Colors.blueGrey[700],
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black87,
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(
              1,
              1
            )
          )
        ]
      ),
    );
  }

  Widget _crearMultimediaComponents(){
    final List<File> multimediaFiles = _caso.multimediaItems;
    return _MultimediaComponents(multimedia: multimediaFiles);
  }

  Widget _crearBotonAportar(){
    final double horizontalPadding = _sizeUtils.shortFlatButtonPadding['horizontal'];
    return Center(
      child: MaterialButton(
        child: Text(
          'Aportar',
          style: TextStyle(
            color: Colors.white,
            fontSize: _sizeUtils.flatButtonTextSize
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        shape: StadiumBorder(),
        color: Colors.black87,
        onPressed: (){
          //TODO: implementar navegación o dialog
        },
      ),
    );
  }

  Widget _crearBotonRegresar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: _sizeUtils.xasisSobreYasis * 0.25,
          alignment: Alignment.centerRight,
          child: MaterialButton(
            child: _crearBotonRegresarComponents(),
            onPressed: (){
              //TODO: implementar navegación o dialog
            },
          ),
        ),
      ],
    );
  }

  Widget _crearBotonRegresarComponents(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          FontAwesomeIcons.arrowCircleLeft
        ),
        Text(
          'Regresar',
          style: TextStyle(
            fontSize: _sizeUtils.flatButtonTextSize
          ),
        ),
      ],
    );
  }

}

class _MultimediaComponents extends StatelessWidget {

  final List<File> _multimedia;

  SizeUtils _sizeUtils;

  _MultimediaComponents({
    @required List<File> multimedia
  }):
    this._multimedia = multimedia
    ;

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Container( 
      child: Column(
        children: [
          _crearTitulo(),
          SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
          _crearGridComponentes(),
        ],
      )
    );
  }

  void _initInitialConfiguration(BuildContext context){
    _sizeUtils = SizeUtils();
  }

  Widget _crearTitulo(){
    return Text(
      'Fotos/Videos',
      style: TextStyle(
        fontSize: _sizeUtils.littleTitleSize
      ),
    );
  }

  Widget _crearGridComponentes(){
    List<Widget> items = _crearMultimediaItems();
    return Container(
      height: _sizeUtils.xasisSobreYasis * 0.6,
      child: GridView.count(
        padding: EdgeInsets.symmetric(
          vertical: _sizeUtils.xasisSobreYasis * 0.005,
          horizontal: _sizeUtils.xasisSobreYasis * 0.008
        ),
        crossAxisCount: 3,
        mainAxisSpacing: _sizeUtils.xasisSobreYasis * 0.0275,
        crossAxisSpacing: _sizeUtils.xasisSobreYasis * 0.04,
        childAspectRatio: 1.2,
        children: items
      ),
    );
  }

  List<Widget> _crearMultimediaItems(){
    List<Widget> multimediaItems = [];
    _multimedia.forEach((File current) {
      //TODO: implementar la verdadera instanciación del widget
      Widget item = Container(
        width: _sizeUtils.xasisSobreYasis * 0.1,
        height: _sizeUtils.xasisSobreYasis * 0.1,
        decoration: _createMultimediaItemBoxDecoration(),
      );
      multimediaItems.add(item);
    });
    return multimediaItems;
  }

  BoxDecoration _createMultimediaItemBoxDecoration(){
    return BoxDecoration(
      color: Colors.blueGrey[900],
      borderRadius: BorderRadius.circular(_sizeUtils.xasisSobreYasis * 0.02)
    );
  }
}