import 'package:flutter/material.dart';

import 'package:coco/pages/login_page.dart';
import 'package:coco/pages/register_page.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/utils/strings_utils.dart' as strings;

class HomePage extends StatelessWidget {
  static final route = 'home';

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
            _crearTextoInformativoPrincipal(),
            SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
            _crearTextoInformativoSecundario(),
            SizedBox(height: _sizeUtils.xasisSobreYasis * 0.175),
            _crearBotonLogin(),
            SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
            _crearBotonRegister()
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
  
  Widget _crearTextoInformativoPrincipal(){
    return Text(
      strings.homeTextoPrincipal,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: _sizeUtils.subtitleSize
      ),
    );
  }

  Widget _crearTextoInformativoSecundario(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _sizeUtils.xasisSobreYasis * 0.02),
      child: Text(
        strings.homeTextoSecundario,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: _sizeUtils.normalTextSize
        ),
      ),
    );
  }

  Widget _crearBotonLogin(){
    final double largeFlatButtonPadding = _sizeUtils.largeFlatButtonPadding['horizontal'];
    return MaterialButton(
      child: Text(
        'Ingresa',
        style: TextStyle(
          color: Colors.white,
          fontSize: _sizeUtils.flatButtonTextSize
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: largeFlatButtonPadding),
      shape: StadiumBorder(),
      color: Colors.black87,
      onPressed: (){
        Navigator.of(_context).pushNamed(LoginPage.route);
      },
    );
  }

  Widget _crearBotonRegister(){
    final double largeFlatButtonPadding = _sizeUtils.largeFlatButtonPadding['horizontal'];
    return MaterialButton(
      child: Text(
        'Registrate',
        style: TextStyle(
          color: Colors.white,
          fontSize: _sizeUtils.flatButtonTextSize
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: largeFlatButtonPadding),
      shape: StadiumBorder(),
      color: Colors.black87,
      onPressed: (){
        Navigator.of(_context).pushNamed(RegisterPage.route);
      },
    );
  }
}