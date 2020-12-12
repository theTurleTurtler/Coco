import 'package:coco/models/caso.dart';
import 'package:coco/widgets/casos/caso_card.dart';
import 'package:flutter/material.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/utils/test/casos_lists.dart' as casos;

class CasosAbiertosComponent extends StatelessWidget {

  final double _heightPercentage;

  BuildContext _context;
  SizeUtils _sizeUtils;

  CasosAbiertosComponent({
    @required double heightPercentaje
  }):
    _heightPercentage = heightPercentaje
    ;
  
  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Container(
      child: Column(
        children: [
          _crearTitulo(),
          SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
          _crearCasosCards()
        ],
      ),
    );
  }

  void _initInitialConfiguration(BuildContext appContext){
    _context = appContext;
    _sizeUtils = SizeUtils();
  }

  Widget _crearTitulo(){
    return Center(
      child: Text(
        'CASOS ABIERTOS',
        style: TextStyle(
          fontSize: _sizeUtils.titleSize,
          color: Colors.black54
        ),
      ),
    );
  }

  Widget _crearCasosCards(){
    final List<CasoCard> casosWidgets = _definirCasosWidgets();
    return Container(
      height: _sizeUtils.xasisSobreYasis * _heightPercentage,
      child: ListView(
        children: casosWidgets,
      )
    );
  }

  List<CasoCard> _definirCasosWidgets(){
    List<CasoCard> _casosWidgets = [];
    casos.casosAbiertos.forEach((Caso caso) {
      final CasoCard casoCard = CasoCard(caso: caso);
      _casosWidgets.add(casoCard);
    });
    return _casosWidgets;
  }
  
}