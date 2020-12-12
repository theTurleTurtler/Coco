import 'package:coco/pages/casos_home_page.dart';
import 'package:coco/pages/register_dashboard_page.dart';
import 'package:coco/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  static final route = 'login';

  BuildContext _context;
  SizeUtils _sizeUtils;

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: _crearComponentes()
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
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _sizeUtils.largeHorizontalScaffoldPadding
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: _sizeUtils.xasisSobreYasis * 0.05),
            HeaderLogo(),  
            SizedBox(height: _sizeUtils.xasisSobreYasis * 0.05),
            _crearFormInput('email'),
            SizedBox(height: _sizeUtils.normalSizedBoxHeigh * 0.75),
            _crearFormInput('password'),
            SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
            _crearBotonLogin(),
            SizedBox(height: _sizeUtils.xasisSobreYasis * 0.022),
            _crearBotonRegister(),
            SizedBox(height: _sizeUtils.xasisSobreYasis * 0.065),
            _crearComponentesIngresoExterno(),
          ],
        ),
      ),
    );
  }

  Widget _crearFormInput(String tipo){
    final Widget input = _generarInputSegunTipo(tipo);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _crearFormInputTitle(tipo),
        SizedBox(height: _sizeUtils.littleSizedBoxHeigh * 0.5),
        input
      ],
    );
  }

  Widget _crearFormInputTitle(String tipoInput){
    final String title = _elegirTituloDeInput(tipoInput);
    return Container(
      padding: EdgeInsets.only(left: _sizeUtils.xasisSobreYasis * 0.03),
      child: Text(
        title,
        style: TextStyle(
          fontSize: _sizeUtils.subtitleSize,
          color: Colors.black54
        ),
      ),
    );
  }

  String _elegirTituloDeInput(String tipoInput){
    if(tipoInput == 'email')
      return "CORREO";
    else
      return 'CONTRASEÑA';
  }

  Widget _generarInputSegunTipo(String tipo){
    Widget input;
    if(tipo == 'email'){
      input = _crearEmailInput();
    }else{
      input = _crearPasswordInput();
    }
    return input;
  }

  Widget _crearEmailInput(){
    return TextField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.black,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isCollapsed: true,
        prefixIcon: Icon(
          Icons.person_outline,
          size: _sizeUtils.normalIconSize,
        ),
        enabledBorder: _crearLoginInputBorder(),
        border: _crearLoginInputBorder(),
      )
    );
  }

  Widget _crearPasswordInput(){
    return TextField(
      keyboardType: TextInputType.text,
      obscureText: true,
      cursorColor: Colors.black,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isCollapsed: true,
        prefixIcon: Icon(
          //FontAwesomeIcons.lock
          Icons.lock_outline,
          size: _sizeUtils.normalIconSize,
        ),
        border: _crearLoginInputBorder(),
        enabledBorder: _crearLoginInputBorder()
      )
    );
  }

  InputBorder _crearLoginInputBorder(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_sizeUtils.xasisSobreYasis * 0.065),
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.75
      )
    );
  }

  Widget _crearBotonLogin(){
    final Map<String, double> fatLargeFlatButtonPadding = _sizeUtils.fatLargeFlatButtonPadding;
    final double horizontalPadding = fatLargeFlatButtonPadding['horizontal'];
    final double verticalPadding = fatLargeFlatButtonPadding['vertical'];
    return MaterialButton(
      child: _crearTextoDeBoton('INGRESO'),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      shape: StadiumBorder(),
      color: Theme.of(_context).primaryColor,
      onPressed: (){
        Navigator.of(_context).pushReplacementNamed(CasosHomePage.route);
      },
    );
  }

  Widget _crearBotonRegister(){
    final Map<String, double> fatLargeFlatButtonPadding = _sizeUtils.fatLargeFlatButtonPadding;
    final double horizontalPadding = fatLargeFlatButtonPadding['horizontal'];
    final double verticalPadding = fatLargeFlatButtonPadding['vertical'];
    return MaterialButton(
      child: _crearTextoDeBoton('REGISTRO'),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      shape: StadiumBorder(),
      color: Theme.of(_context).primaryColor,
      onPressed: (){
        Navigator.of(_context).pushNamed(RegisterDashBoardPage.route);
      },
    );
  }

  Widget _crearTextoDeBoton(String texto){
    return Text(
      texto,
      style: TextStyle(
        color: Colors.white,
        fontSize: _sizeUtils.littleTitleSize
      ),
    );
  }

  Widget _crearComponentesIngresoExterno(){
    return Column(
      children: [
        _crearTextoIngresoExterno(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //TODO: Implementar las verdaderas rutas de navegación
            PreIngresoIconButton.facebook(LoginPage.route),
            PreIngresoIconButton.google(LoginPage.route)
          ],
        )
      ],
    );
  }

  Widget _crearTextoIngresoExterno(){
    return Center(
      child: Text(
        'O INGRESA CON',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: _sizeUtils.subtitleSize,
          color: Colors.black54
        ),
      ),
    );
  }
  
}