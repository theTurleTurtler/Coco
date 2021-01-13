import 'dart:io';

import 'package:coco/utils/size_utils.dart';
import 'package:flutter/material.dart';
class VisualizableImage extends StatelessWidget {
  final File file;
  SizeUtils _sizeUtils;
  VisualizableImage({Key key, this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration();
    return Container(
      child: Image.file(
        file,
        width: _sizeUtils.xasisSobreYasis * 0.6,
        fit: BoxFit.fitWidth
      ),
    );
  }

  void _initInitialConfiguration(){
    _sizeUtils = SizeUtils();
  }
}