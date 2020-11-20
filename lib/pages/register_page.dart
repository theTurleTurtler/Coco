import 'package:coco/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatelessWidget {
  static final String route = 'register';
  BuildContext _context;
  SizeUtils _sizeUtils;

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: _crearComponentes(),
      ),
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
          horizontal: _sizeUtils.largeHorizontalScaffoldPadding
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: _sizeUtils.xasisSobreYasis * 0.2),
            _crearTextoRegistroExterno(),
            SizedBox(height: _sizeUtils.xasisSobreYasis * 0.022),
            _crearFacebookButton(),
            SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
            _crearGoogleButton(),
            SizedBox(height: _sizeUtils.xasisSobreYasis * 0.1),
            _crearEmailInput(),
            SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
            _crearPasswordInput(),
            SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
            _crearConfirmPasswordInput(),
            SizedBox(height: _sizeUtils.largeSizedBoxHeigh),
            _crearBotonSubmit()
          ],
        ),
      ),
    );
  }

  Widget _crearTextoRegistroExterno(){
    return Center(
      child: Text(
        'Registrate rápidamente con',
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: _sizeUtils.subtitleSize
        ),
      ),
    );
  }

  Widget _crearFacebookButton(){
    final Map<String, dynamic> padding = _sizeUtils.largeIconButtonPadding;
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: padding['horizontal'], vertical: padding['vertical']),
      shape: StadiumBorder(),
      color: Colors.black87,
      child: Icon(
        FontAwesomeIcons.facebook,
        //color: Color.fromRGBO(66,103,178, 1)
        color: Colors.white,
      ),
      onPressed: (){

      },
    );
  }

  Widget _crearGoogleButton(){
    final Map<String, dynamic> padding = _sizeUtils.largeIconButtonPadding;
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: padding['horizontal'], vertical: padding['vertical']),
      shape: StadiumBorder(),
      color: Colors.black87,
      child: Icon(
        FontAwesomeIcons.google,
        //color: Color.fromRGBO(219,68,55, 1),
        color: Colors.white,
      ),
      onPressed: (){

      },
    );
  }

  Widget _crearEmailInput(){
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Correo electrónico',
      ),
    );
  }

  Widget _crearPasswordInput(){
    return TextField(
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelText: 'Contraseña',
      ),
    );
  }

  Widget _crearConfirmPasswordInput(){
    return TextField(
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelText: 'Confirmar contraseña',
      ),
    );
  }

  Widget _crearBotonSubmit(){
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

      },
    );
  }
}