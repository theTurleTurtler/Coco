import 'package:coco/utils/size_utils.dart';
import 'package:coco/widgets/casos/muestra_casos.dart';
import 'package:coco/widgets/header_bar/header_bar.dart';
import 'package:flutter/material.dart';

class CasosHomePage extends StatelessWidget {
  static final route = 'casos';

  BuildContext _context;
  SizeUtils _sizeUtils;

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Scaffold(
      backgroundColor: Theme.of(_context).backgroundColor,
      body: _crearComponentes(),
    );
  }

  void _initInitialConfiguration(BuildContext context){
    _context = context;
    final Size size = MediaQuery.of(_context).size;
    _sizeUtils = SizeUtils();
    _sizeUtils.initUtil(size);
  }

  Widget _crearComponentes(){
    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeaderBar(),
            _createBodyComponents(),
          ]
        )
      ),
    );
  }

  Widget _createBodyComponents(){
    return Container(
      //TODO: padding
      child: Column(
        children: [
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          MuestraCasos.abiertos(),
          SizedBox(height: _sizeUtils.xasisSobreYasis * 0.03),
          MuestraCasos.requerimientosEnviados()
        ],
      ),
    );
  }
}