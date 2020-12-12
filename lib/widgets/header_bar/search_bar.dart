import 'package:coco/utils/size_utils.dart';
import 'package:flutter/material.dart';
// Barra de búsqueda
// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  BuildContext _context;
  SizeUtils _sizeUtils;

  @override
  Widget build(BuildContext appContext) {
    _initInitialElements(appContext);
    return Container(
      width: _sizeUtils.xasisSobreYasis * 0.375,
      decoration: _crearSearchDecoration(),
      padding: _crearBarPadding(),
      child: Row(
        children: [
          _crearSearchIcon()
        ],
      ),
    );
  }

  EdgeInsets _crearBarPadding(){
    return EdgeInsets.symmetric(
      horizontal: _sizeUtils.xasisSobreYasis * 0.015,
      vertical: _sizeUtils.xasisSobreYasis * 0.005
    );
  }

  void _initInitialElements(BuildContext appContext){
    _context = appContext;
    _sizeUtils = SizeUtils();
  }
  
  BoxDecoration _crearSearchDecoration(){
    return BoxDecoration(
      color: Theme.of(_context).primaryColorDark,
      borderRadius: BorderRadius.circular(_sizeUtils.xasisSobreYasis * 0.03)
    );
  }

  Icon _crearSearchIcon(){
    return Icon(
      Icons.search,
      size: _sizeUtils.littleIconSize,
      color: Colors.white,
    );
  }
}
