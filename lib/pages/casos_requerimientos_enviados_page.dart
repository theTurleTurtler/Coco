import 'package:coco/utils/size_utils.dart';
import 'package:coco/widgets/casos_con_requerim_enviados.dart';
import 'package:coco/widgets/filtros.dart';
import 'package:coco/widgets/header_bar.dart';
import 'package:flutter/material.dart';
class CasosRequerimientosEnviadosPage extends StatefulWidget {

  static final String route = 'casos_requerimientos_enviados';

  @override
  _CasosRequerimientosEnviadosPageState createState() => _CasosRequerimientosEnviadosPageState();
}

class _CasosRequerimientosEnviadosPageState extends State<CasosRequerimientosEnviadosPage> {
  SizeUtils _sizeUtils;

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
       body:  SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderBar(),
            _crearBodyComponents()
          ],
        ),
      )
    );
  }

  Widget _crearBodyComponents(){
    return Container(
      //TODO: padding
      child: Column(
        children: [
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          CasosConRequerimEnviados(),
          SizedBox(height: _sizeUtils.xasisSobreYasis * 0.55),
          Filtros()
        ],
      ),
    );
  }
  
  void _initInitialConfiguration(BuildContext context){
    _sizeUtils = SizeUtils();
  }

}