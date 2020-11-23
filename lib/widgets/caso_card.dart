import 'package:coco/models/caso.dart';
import 'package:coco/pages/caso_detail_page.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:flutter/material.dart';

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
        height: _sizeUtils.xasisSobreYasis * 0.275,
        padding: _createCardPadding(),
        decoration: _crearCardDecoration(),
        child: _createCardComponents()
      ),
      onTap: (){
        Navigator.of(context).pushReplacementNamed(CasoDetailPage.route, arguments: _caso);
      },
    );
  }

  void _initInitialConfiguration(BuildContext context){
    _context = context;
    _sizeUtils = SizeUtils();
  }

  EdgeInsets _createCardPadding(){
    return EdgeInsets.symmetric(
      horizontal: _sizeUtils.xasisSobreYasis * 0.01,
      vertical: _sizeUtils.xasisSobreYasis * 0.01
    );
  }

  BoxDecoration _crearCardDecoration(){
    return BoxDecoration(
      color: Colors.blueGrey[400],
      borderRadius: BorderRadius.circular(_sizeUtils.xasisSobreYasis * 0.0125),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black87,
          blurRadius: 4,
          spreadRadius: 0.4,
          offset: Offset(1, 1)
        )
      ]
    );
  }

  Widget _createCardComponents(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _crearTextoInformacion(),
        _crearFecha()
      ],
    );
  }

  Widget _crearTextoInformacion(){
    final String texto = '    ${_caso.ciudad} - ${_caso.titulo}';
    return Text(
      texto,
      maxLines: 5,
      style: TextStyle(
        fontSize: _sizeUtils.normalTextSize,
      )
    );
  }
  Widget _crearFecha(){
    final String _stringDate = _defineDateString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          _stringDate,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: _sizeUtils.subtitleSize
          ),
        ),
      ],
    );
  }

  String _defineDateString(){
    final String _stringTotalDate = _caso.fechaPublicacion.toString();
    final List<String> _stringDateAndTimeSeparation = _stringTotalDate.split(' ');
    final String _stringDate = _stringDateAndTimeSeparation[0];
    return _stringDate;
  }
}