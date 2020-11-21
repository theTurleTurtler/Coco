import 'package:coco/models/caso.dart';
import 'package:flutter/material.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/widgets/caso_card.dart';
import 'package:coco/utils/test/casos_lists.dart' as casos;

class CasosConRequerimEnviados extends StatelessWidget {

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
    _sizeUtils = SizeUtils();
  }

   Widget _crearTitulo(){
    return Center(
      child: Text(
        'Requerimientos enviados',
        style: TextStyle(
          fontSize: _sizeUtils.titleSize
        ),
      ),
    );
  }

  Widget _crearCasosCards(){
    final List<Widget> casosWidgets = _definirCasosWidgets();
    return Container(
      height: _sizeUtils.xasisSobreYasis * 0.28,
      width: _sizeUtils.xasisSobreYasis * 0.75,
      child: ListView(
        padding: EdgeInsets.symmetric(
          vertical: _sizeUtils.xasisSobreYasis * 0.02,
          horizontal: _sizeUtils.xasisSobreYasis * 0.01
        ),
        scrollDirection: Axis.horizontal,
        children: casosWidgets,
      )
    );
  }

  List<Widget> _definirCasosWidgets(){
    List<Widget> _casosWidgets = [];
    List<Caso> casosConReqEnviados = casos.casosConRequerimientosEnviados;
    for(int i = 0; i < casosConReqEnviados.length; i++){
      final Caso currentCaso = casosConReqEnviados[i];
      final CasoCard currentCasoCard = CasoCard(caso: currentCaso);
      _casosWidgets.add(currentCasoCard);
      if(i<casosConReqEnviados.length-1){
        _casosWidgets.add(
          SizedBox(width: _sizeUtils.xasisSobreYasis * 0.025)
        );
      }
    }
    return _casosWidgets;
  }
}