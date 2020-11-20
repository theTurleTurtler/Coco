import 'package:coco/pages/home_page.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:coco/utils/strings_utils.dart' as strings;

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
        padding: EdgeInsets.symmetric(
          horizontal: _sizeUtils.littleHorizontalScaffoldPadding
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
            _crearLogo(),
            SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
            _crearTextoPrincipal(),
            SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
            _crearTextoSecundario(),
            SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
            _crearTextoTerciario(),
            SizedBox(height: _sizeUtils.veryMuchLargeSizedBoxHeigh),
            _crearBotonInicio()
          ],
        ),
      ),
    );
  }

  Widget _crearLogo(){
    final Map<String, dynamic> mainLogoSize = _sizeUtils.mainLogoSize;
    return Center(
      child: Image.asset(
        'assets/logo_coco_2.png',
        height: mainLogoSize['vertical'],
        width: mainLogoSize['horizontal'],
      ),
    );
  }
  
  Widget _crearTextoPrincipal(){
    return Text(
      strings.aperturaExitosaTextoPrincipal,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: _sizeUtils.titleSize * 1.2
      ),
    );
  }

  Widget _crearTextoSecundario(){
    return Text(
      strings.aperturaExitosaTextoSecundario,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: _sizeUtils.subtitleSize*1.2
      ),
    );
  }

  Widget _crearTextoTerciario(){
    return Text(
      strings.aperturaExitosaTextoTerciario,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: _sizeUtils.subtitleSize*1.15
      ),
    );
  }

  Widget _crearBotonInicio(){
    final double largeFlatButtonPadding = _sizeUtils.largeFlatButtonPadding['horizontal'];
    return MaterialButton(
      child: Text(
        'Volver al inicio',
        style: TextStyle(
          color: Colors.white,
          fontSize: _sizeUtils.flatButtonTextSize
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: largeFlatButtonPadding),
      shape: StadiumBorder(),
      color: Colors.black87,
      onPressed: (){
        //TODO: implementar navegación al verdadero inicio_page
        Navigator.of(_context).pushReplacementNamed(HomePage.route);
      },
    );
  }
}