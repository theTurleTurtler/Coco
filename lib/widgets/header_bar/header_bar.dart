import 'package:coco/widgets/header_bar/navigation_menu.dart';
import 'package:coco/widgets/header_bar/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:coco/utils/size_utils.dart';
//Clase principal
// ignore: must_be_immutable
class HeaderBar extends StatelessWidget {
  
  BuildContext _context;
  SizeUtils _sizeUtils;

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Column(
      children: [
        SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
        _createBar()
      ],
    );
  }

  void _initInitialConfiguration(BuildContext context){
    _context = context;
    final Size size = MediaQuery.of(_context).size;
    _sizeUtils = SizeUtils();
    _sizeUtils.initUtil(size);
  }

  Widget _createBar(){
    final double sizeWidth = MediaQuery.of(_context).size.width;
    return Container(
      width: sizeWidth,
      padding: _createBarPadding(),
      child: Row(
        children: [
          _crearLeftBarComponent(),
          _crearRightBarComponent()
        ],
      ),
    );
  }

  EdgeInsets _createBarPadding(){
    return EdgeInsets.symmetric(
      horizontal: 0,
      vertical: 0
    );
  }

  Widget _crearLeftBarComponent(){
    return Container(
      decoration: _crearLeftBarComponentDecoration(),
      padding: _crearLeftBarComponentPadding(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NavigationMenu(),
          SizedBox(width: _sizeUtils.xasisSobreYasis * 0.025),
          SearchBar()
        ],
      ),
    );
  }

  EdgeInsets _crearLeftBarComponentPadding(){
    final Map<String, double> padding = _sizeUtils.headerLeftComponentPadding;
    return EdgeInsets.only(
      top: padding['top'],
      bottom: padding['bottom'],
      left: padding['left'],
      right: padding['right']
    );
  }

  BoxDecoration _crearLeftBarComponentDecoration(){
    return BoxDecoration(
      color: Theme.of(_context).primaryColor
    );
  }

  Widget _crearRightBarComponent(){
    final Map<String, dynamic> mainLogoSize = _sizeUtils.diminuteLogoSize;
    return Expanded(
      child: Image.asset(
        'assets/logo_coco_2.png',
        height: mainLogoSize['vertical'],
        width: mainLogoSize['horizontal'],
      ),
    );
  }
}

