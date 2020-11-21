import 'package:coco/utils/size_utils.dart';
import 'package:coco/widgets/casos_abiertos_component.dart';
import 'package:coco/widgets/casos_con_requerim_enviados.dart';
import 'package:coco/widgets/header_bar.dart';
import 'package:flutter/material.dart';

class CasosPage extends StatelessWidget {

  static final route = 'casos';

  BuildContext _context;
  SizeUtils _sizeUtils;

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
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
            SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
            HeaderBar(),
            _createBodyComponents(),
          ]
        )
      ),
    );
  }

  Widget _createBodyComponents(){
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _sizeUtils.littleHorizontalScaffoldPadding
      ),
      child: Column(
        children: [
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          CasosAbiertosComponent(),
          SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
          CasosConRequerimEnviados()
        ],
      ),
    );
  }
}