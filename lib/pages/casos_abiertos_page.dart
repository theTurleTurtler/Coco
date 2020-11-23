import 'package:coco/widgets/filtros.dart';
import 'package:flutter/material.dart';
import 'package:coco/widgets/casos_abiertos_component.dart';
import 'package:coco/widgets/header_bar.dart';
import 'package:coco/utils/size_utils.dart';

class CasosAbiertosPage extends StatefulWidget {
  static final String route = 'casos_abiertos';

  @override
  _CasosAbiertosPageState createState() => _CasosAbiertosPageState();
}

class _CasosAbiertosPageState extends State<CasosAbiertosPage> {
  SizeUtils _sizeUtils;

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderBar(),
            SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
            CasosAbiertosComponent(heightPercentaje: 0.8),
            SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
            Filtros()
          ],
        ),
      )
    );
  }

  void _initInitialConfiguration(BuildContext context){
    _sizeUtils = SizeUtils();
  }
}