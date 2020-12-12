import 'package:coco/models/caso.dart';
import 'package:flutter/material.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/widgets/casos/caso_card.dart';
import 'package:coco/utils/test/casos_lists.dart' as casos;

class CasosConRequerimEnviadosComponent extends StatelessWidget {

  final double _heightPercentage;

  BuildContext _context;
  SizeUtils _sizeUtils;

  CasosConRequerimEnviadosComponent({
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
          _crearCasosCards(),
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
        'REQUERIMIENTOS ENVIADOS',
        style: TextStyle(
          fontSize: _sizeUtils.titleSize,
          color: Colors.black54
        ),
      ),
    );
  }

  Widget _crearCasosCards(){
    final List<Widget> casosWidgets = _definirCasosWidgets();
    return Container(
      height: _sizeUtils.xasisSobreYasis * _heightPercentage,
      width: _sizeUtils.xasisSobreYasis * 0.75,
      child: ListView(
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