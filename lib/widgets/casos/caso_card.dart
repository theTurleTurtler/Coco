import 'package:coco/blocs/user/user_bloc.dart';
import 'package:coco/enums/account_step.dart';
import 'package:coco/models/caso.dart';
import 'package:coco/pages/login_page.dart';
import 'package:coco/pages/modificar_caso_page.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CasoCard extends StatelessWidget {

  final Caso _caso;
  BuildContext _context;
  SizeUtils _sizeUtils;
  
  CasoCard({
    @required Caso caso
  }): _caso = caso
    ;

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return GestureDetector(
      child: Container( 
        width: _sizeUtils.xasisSobreYasis * 0.275,
        height: _sizeUtils.xasisSobreYasis * 0.18,
        margin: _createCardMargin(),
        padding: _createCardPadding(),
        decoration: _crearCardDecoration(),
        child: _createCardComponents()
      ),
      onTap: (){
        final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
        if(userBloc.state.accountStep == AccountStep.LOGGED)
          Navigator.of(context).pushNamed(ModificarCasoPage.routeAportar, arguments: _caso);
        else
          Navigator.of(context).pushNamed(LoginPage.route);
      },
    );
  }

  void _initInitialConfiguration(BuildContext context){
    _context = context;
    _sizeUtils = SizeUtils();
  }

  EdgeInsets _createCardMargin(){
    return EdgeInsets.only(bottom: _sizeUtils.xasisSobreYasis * 0.01);
  }

  EdgeInsets _createCardPadding(){
    return EdgeInsets.only(
      top: _sizeUtils.xasisSobreYasis * 0.015,
    );
  }

  BoxDecoration _crearCardDecoration(){
    return BoxDecoration(
      color: Colors.grey[300],
    );
  }

  Widget _createCardComponents(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _createTopFragment(),
        _createBottomFragment()
      ],
    );
  }

  Widget _createTopFragment(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _sizeUtils.xasisSobreYasis * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _createLeftTopFragment(),
          _createRightTopFragment()
        ],
      ),
    );
  }

  Widget _createLeftTopFragment(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[   
        _createFecha()
      ]
    );
  }

  Widget _createRightTopFragment(){
    return Row(
      children:[
        SizedBox(width: _sizeUtils.xasisSobreYasis * 0.02),
        _createCirculoDeEstado()
      ]
    );
  }

  Widget _createDireccion(){
    return Text(
      _caso.direccion,
      style: TextStyle(
        fontSize: _sizeUtils.normalTextSize
      ),
    );
  }

  Widget _createFecha(){
    final String stringDate = _defineDateString();
    return Text(
      stringDate,
      style: TextStyle(
        fontSize: _sizeUtils.normalTextSize
      ),
    );
  }

  Widget _createMainMultimedia(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(_sizeUtils.xasisSobreYasis * 0.1)
      ),
      child: Icon(
        Icons.camera_alt,
        color: Colors.grey,
        size: _sizeUtils.normalIconSize,
      ),
    );
  }

  Widget _createCirculoDeEstado(){
    return Container(
      height: _sizeUtils.xasisSobreYasis * 0.03,
      width: _sizeUtils.xasisSobreYasis * 0.03,
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: BorderRadius.circular(_sizeUtils.xasisSobreYasis * 0.1)
      ),
    );

  }

  Widget _createBottomFragment(){
    return Container(
      width: double.infinity,
      color: Colors.grey[350],
      padding: _createBottomFragmentPadding(),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: double.infinity),
        child: Text(
          _caso.titulo,
          style: TextStyle(
            fontSize: _sizeUtils.normalTextSize,
            fontWeight: FontWeight.normal,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  EdgeInsets _createBottomFragmentPadding(){
    return EdgeInsets.symmetric(
      vertical: _sizeUtils.xasisSobreYasis * 0.005,
      horizontal: _sizeUtils.xasisSobreYasis * 0.015
    );
  }

  String _defineDateString(){
    final String _stringTotalDate = _caso.fechaPublicacion.toString();
    final List<String> _stringDateAndTimeSeparation = _stringTotalDate.split(' ');
    final String _stringDate = _stringDateAndTimeSeparation[0];
    return _stringDate;
  }
}