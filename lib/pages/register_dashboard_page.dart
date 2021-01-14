import 'package:coco/pages/register_page.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
class RegisterDashBoardPage extends StatelessWidget {

  static final route = 'register_dashboard';

  BuildContext _context;
  SizeUtils _sizeUtils;
  
  @override
  Widget build(BuildContext context) {
  _initInitialConfiguration(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
            HeaderLogo(),
            SizedBox(height: _sizeUtils.xasisSobreYasis * 0.175),
            _crearTitulo(),
            SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
            _crearRegisterTypesButtons()
          ],
        ),
      ),
    );
  }

  void _initInitialConfiguration(BuildContext context){
    _context = context;
    final Size size = MediaQuery.of(_context).size;
    _sizeUtils = SizeUtils();
    _sizeUtils.initUtil(size);
  }

  Widget _crearLogo(){
    final Map<String, dynamic> mainLogoSize = _sizeUtils.littleMainLogoSize;
    return Center(
      child: Image.asset(
        'assets/logo_coco_2.png',
        height: mainLogoSize['vertical'],
        width: mainLogoSize['horizontal'],
      ),
    );
  }

  Widget _crearTitulo(){
    return Text(
      'REGISTRATE CON',
      style: TextStyle(
        fontSize: _sizeUtils.titleSize,
        color: Colors.black54
      ),
    );
  }

  Widget _crearRegisterTypesButtons(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PreIngresoIconButton.email(RegisterPage.route),
        PreIngresoIconButton.facebook(RegisterPage.route),
        PreIngresoIconButton.google(RegisterPage.route)
      ],
    );
  }
}