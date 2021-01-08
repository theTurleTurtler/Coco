import 'package:coco/pages/casos_home_page.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/widgets/header_bar/header_bar.dart';
import 'package:flutter/material.dart';
import 'package:coco/utils/static_data/strings_utils.dart' as strings;

class AperturaExitosaDeCasoPage extends StatelessWidget {

  static final String route = 'apertura_exitosa_de_caso';
  
  BuildContext _context;
  SizeUtils _sizeUtils;

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: _crearComponentes(),
    );
  }

  void _initInitialConfiguration(BuildContext context){
    _context = context;
    final Size size = MediaQuery.of(_context).size;
    _sizeUtils = SizeUtils();
    _sizeUtils.initUtil(size);
  }

  Widget _crearComponentes(){
    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeaderBar(),
            SizedBox(height: _sizeUtils.giantSizedBoxHeight),
            _createMessageComponents(),
            SizedBox(height: _sizeUtils.veryMuchLargeSizedBoxHeigh),
            _crearBotonInicio()
          ],
        ),
      ),
    );
  }

  Widget _createMessageComponents(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _sizeUtils.normalHorizontalScaffoldPadding),
      child: Column(
        children: [
          _crearTextoPrincipal(),
          SizedBox(height: _sizeUtils.largeSizedBoxHeigh),
          _crearTextoSecundario(),
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          _crearTextoTerciario(),
        ],
      ),
    );
  }
  
  Widget _crearTextoPrincipal(){
    return Text(
      strings.aperturaExitosaTextoPrincipal,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: _sizeUtils.superTitleSize,
        color: Colors.black54
      ),
    );
  }

  Widget _crearTextoSecundario(){
    return Text(
      strings.aperturaExitosaTextoSecundario,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: _sizeUtils.subtitleSize,
        color: Colors.black54
      ),
    );
  }

  Widget _crearTextoTerciario(){
    return Text(
      strings.aperturaExitosaTextoTerciario,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: _sizeUtils.normalTextSize,
      ),
    );
  }

  Widget _crearBotonInicio(){
    final double horizontalPadding = _sizeUtils.shortFlatButtonPadding['horizontal'];
    return MaterialButton(
      child: Text(
        'VOLVER AL INICIO',
        style: TextStyle(
          color: Colors.white,
          fontSize: _sizeUtils.flatButtonTextSize
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      shape: StadiumBorder(),
      color: Theme.of(_context).primaryColor,
      onPressed: (){
        //TODO: implementar navegación al verdadero inicio_page
        Navigator.of(_context).pushReplacementNamed(CasosHomePage.route);
      },
    );
  }
}