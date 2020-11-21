import 'package:coco/models/caso.dart';
import 'package:coco/widgets/caso_card.dart';
import 'package:flutter/material.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/utils/test/casos_lists.dart' as casos;

class CasosAbiertosComponent extends StatelessWidget {

  BuildContext _context;
  SizeUtils _sizeUtils;
  
  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Container(
      child: Column(
        children: [
          _crearTitulo(),
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          _crearCasosCards()
        ],
      ),
    );
  }

  void _initInitialConfiguration(BuildContext context){
    _context = context;
    final Size size = MediaQuery.of(_context).size;
    _sizeUtils = SizeUtils();
    //esta línea, solo mientras que este page está en el main como initialRoute
    _sizeUtils.initUtil(size);
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
      height: _sizeUtils.xasisSobreYasis * 0.53,
      child: GridView.count(
        padding: EdgeInsets.symmetric(
          vertical: _sizeUtils.xasisSobreYasis * 0.005,
          horizontal: _sizeUtils.xasisSobreYasis * 0.008
        ),
        crossAxisCount: 2,
        mainAxisSpacing: _sizeUtils.xasisSobreYasis * 0.0275,
        crossAxisSpacing: _sizeUtils.xasisSobreYasis * 0.0275,
        childAspectRatio: 1.125,
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