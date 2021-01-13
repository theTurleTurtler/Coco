import 'package:coco/blocs/user/user_services_manager.dart';
import 'package:flutter/material.dart';
import 'package:coco/widgets/common_widgets.dart';
import 'package:coco/utils/size_utils.dart';

class RegisterPage extends StatelessWidget {
  static final String route = 'register';
  BuildContext _context;
  SizeUtils _sizeUtils;
  UserServicesManager _userServicesManager;

  String _userName;
  String _email;
  String _password;
  String _confirmedPassword;

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
    _userServicesManager = UserServicesManager(appContext: context);
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
            _crearTitulo(),
            SizedBox(height: _sizeUtils.xasisSobreYasis * 0.055),
            _crearFormInput('username'),
            SizedBox(height: _sizeUtils.xasisSobreYasis * 0.022),
            _crearFormInput('email'),
            SizedBox(height: _sizeUtils.xasisSobreYasis * 0.022),
            _crearFormInput('password'),
            SizedBox(height: _sizeUtils.xasisSobreYasis * 0.022),
            _crearFormInput('confirm_password'),
            SizedBox(height: _sizeUtils.largeSizedBoxHeigh * 0.9),
            _crearRegisterButton(),
            SizedBox(height: _sizeUtils.largeSizedBoxHeigh)
          ],
        ),
      ),
    );
  }

  Widget _crearTitulo(){
    return Center(
      child: Text(
        'REGISTRATE',
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: _sizeUtils.titleSize,
          color: Colors.black54
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
          fontSize: _sizeUtils.subtitleSize * 0.95,
          color: Colors.black54
        ),
      ),
    );
  }

  String _elegirTituloDeInput(String tipoInput){
    switch(tipoInput){
      case 'username':
        return 'NOMBRE DE USUARIO';
      case 'email':
        return 'CORREO';
      case 'password': 
        return 'CONTRASEÑA';
      case 'confirm_password': 
        return 'CONFIRMAR CONTRASEÑA';
      default:
        return 'INPUT DESCONOCIDO';
    }
  }

  Widget _generarInputSegunTipo(String tipo){
    Widget input;
    switch(tipo){
      case 'username':
        input = _crearUserNameInput();
      break;
      case 'email':
        input = _crearEmailInput();
      break;
      case 'password':
        input = _crearPasswordInput();
      break;
      case 'confirm_password':
        input = _crearConfirmPasswordInput();
      break;
    }
    return input;
  }

  Widget _crearUserNameInput(){
    return TextField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isCollapsed: true,
        prefixIcon: Icon(
          //FontAwesomeIcons.lock
          Icons.person_outline,
          size: _sizeUtils.normalIconSize,
        ),
        border: _crearInputBorder(),
        enabledBorder: _crearInputBorder(),
      ),
      onChanged: (String newValue){
        _userName = newValue;
      },
    );
  }

  Widget _crearEmailInput(){
    return TextField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.black,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isCollapsed: true,
        prefixIcon: Icon(
          Icons.alternate_email,
          size: _sizeUtils.normalIconSize,
        ),
        enabledBorder: _crearInputBorder(),
        border: _crearInputBorder(),
      ),
      onChanged: (String newValue){
        _email = newValue;
      },
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
        border: _crearInputBorder(),
        enabledBorder: _crearInputBorder(),
      ),
      onChanged: (String newValue){
        _password = newValue;
      },
    );
  }

  Widget _crearConfirmPasswordInput(){
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
        border: _crearInputBorder(),
        enabledBorder: _crearInputBorder(),
      ),
      onChanged: (String newValue){
        _confirmedPassword = newValue;
      },
    );
  }

  InputBorder _crearInputBorder(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_sizeUtils.xasisSobreYasis * 0.065),
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.75
      )
    );
  }

  Widget _crearRegisterButton(){
    final Map<String, double> fatLargeFlatButtonPadding = _sizeUtils.fatLargeFlatButtonPadding;
    final double horizontalPadding = fatLargeFlatButtonPadding['horizontal'];
    final double verticalPadding = fatLargeFlatButtonPadding['vertical'];
    return MaterialButton(
      child: _crearTextoDeBoton(),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      shape: StadiumBorder(),
      color: Theme.of(_context).primaryColor,
      onPressed: _register,
    );
  }

  Widget _crearTextoDeBoton(){
    return Text(
      'REGISTRARSE',
      style: TextStyle(
        color: Colors.white,
        fontSize: _sizeUtils.littleTitleSize * 0.875
      ),
    );
  }

  void _register(){
    final Map<String, dynamic> registerData = {
      'name':_userName,
      'email':_email,
      'password':_password,
      'confirmed_password':_confirmedPassword
    };
    _userServicesManager.manageRegisterProcess(registerData);
  }
}