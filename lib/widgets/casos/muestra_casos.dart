import 'package:coco/models/caso.dart';
import 'package:coco/pages/lista_de_casos_page.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/widgets/casos/caso_card.dart';
import 'package:coco/widgets/casos/casos_types.dart';
import 'package:flutter/material.dart';
import 'package:coco/utils/test/casos_lists.dart' as casos;
// ignore: must_be_immutable
class MuestraCasos extends StatelessWidget {

  final CasosTypes _casoType;
  final String _titulo;
  final List<Caso> _casos;
  final String _rutaDeNavegacionEnBotonMas;

  BuildContext _context;
  SizeUtils _sizeUtils;

  MuestraCasos.abiertos():
  _casoType = CasosTypes.Abierto,
  _titulo = "CASOS ABIERTOS",
  _casos = casos.casosAbiertos,
  _rutaDeNavegacionEnBotonMas = ListaDeCasosPage.routeCasosAbiertos
  ;

  MuestraCasos.requerimientosEnviados():
  _casoType = CasosTypes.RequerimientosEnviados,
  _titulo = "REQUERIMIENTOS ENVIADOS",
  _casos = casos.casosConRequerimientosEnviados,
  _rutaDeNavegacionEnBotonMas = ListaDeCasosPage.routeCasosConRequerimientosAbiertos
  ;

  @override
  Widget build(BuildContext appContext) {
    _initInitialElements(appContext);
    return Container(
      child: Column(
        children: [
          _crearTitulo(),
          SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
          _crearCasosCards(),
          _crearBotonVerMas()
        ],
      ),
    );
  }

  void _initInitialElements(BuildContext appContext){
    _context = appContext;
    _sizeUtils = SizeUtils();
  }

  Widget _crearTitulo(){
    return Center(
      child: Text(
        _titulo,
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
      height: _sizeUtils.xasisSobreYasis * 0.38,
      width: double.infinity,
      child: ListView(
        children: casosWidgets,
      )
    );
  }

  List<CasoCard> _definirCasosWidgets(){
    List<CasoCard> _casosWidgets = [];
    for(int i = 0; i < 2; i++){
      final Caso caso = _casos[i];
      final CasoCard casoCard = CasoCard(caso: caso);
      _casosWidgets.add(casoCard);
    }
    return _casosWidgets;
  }

  Widget _crearBotonVerMas(){
    return FlatButton(
      child: Text(
        'Más...',
        style: TextStyle(
          fontSize: _sizeUtils.subtitleSize
        ),
      ),
      onPressed: (){
        Navigator.of(_context).pushNamed(_rutaDeNavegacionEnBotonMas);
      },
    );
  }
}