import 'package:coco/models/caso.dart';
import 'package:coco/widgets/caso_card.dart';
import 'package:flutter/material.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/utils/test/casos_lists.dart' as casos;

class CasosAbiertosComponent extends StatelessWidget {

  final double _heightPercentage;

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
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          _crearCasosCards(),
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
        ],
      ),
    );
  }

  void _initInitialConfiguration(BuildContext context){
    _sizeUtils = SizeUtils();
  }

  Widget _crearTitulo(){
    return Center(
      child: Text(
        'Casos abiertos',
        style: TextStyle(
          fontSize: _sizeUtils.titleSize
        ),
      ),
    );
  }

  Widget _crearCasosCards(){
    final List<CasoCard> casosWidgets = _definirCasosWidgets();
    return Container(
      height: _sizeUtils.xasisSobreYasis * _heightPercentage,
      child: GridView.count(
        padding: EdgeInsets.symmetric(
          vertical: _sizeUtils.xasisSobreYasis * 0.005,
          horizontal: _sizeUtils.xasisSobreYasis * 0.008
        ),
        crossAxisCount: 2,
        mainAxisSpacing: _sizeUtils.xasisSobreYasis * 0.0275,
        crossAxisSpacing: _sizeUtils.xasisSobreYasis * 0.04,
        childAspectRatio: 1.2,
        children: casosWidgets
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