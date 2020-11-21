import 'package:flutter/material.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/utils/strings_utils.dart' as strings;

class HeaderBar extends StatelessWidget {
  
  BuildContext _context;
  SizeUtils _sizeUtils;

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    final double sizeWidth = MediaQuery.of(context).size.width;
    return Container(
      width: sizeWidth,
      height: _sizeUtils.xasisSobreYasis * 0.075,
      padding: _createBarPadding(),
      decoration: _createBarDecoration(),
      child: _createBarComponents(),
    );
  }

  void _initInitialConfiguration(BuildContext context){
    _context = context;
    final Size size = MediaQuery.of(_context).size;
    _sizeUtils = SizeUtils();
    _sizeUtils.initUtil(size);
  }

  EdgeInsets _createBarPadding(){
    return EdgeInsets.symmetric(
      horizontal: _sizeUtils.xasisSobreYasis * 0.025,
      vertical: _sizeUtils.xasisSobreYasis * 0.01
    );
  }

  BoxDecoration _createBarDecoration(){
    return BoxDecoration(
      color: Colors.black87,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.grey,
          blurRadius: 2,
          spreadRadius: 2,
          offset: Offset(2, 2)
        )
      ]
    );
  }

  Widget _createBarComponents(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _NavigationMenu()
      ],
    );
  }
  
}

class _NavigationMenu extends StatelessWidget {

  BuildContext _context;
  SizeUtils _sizeUtils;
  //TODO: Implementar uso del _currentMenuValue
  String _currentMenuValue;

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return IconButton(
      icon: Icon(
        Icons.menu
      ),
      color: Colors.white,
      onPressed: (){
        _ejecutarMenu();
      },
    );
  }

  void _initInitialConfiguration(BuildContext context){
    _context = context;
    final Size size = MediaQuery.of(_context).size;
    _sizeUtils = SizeUtils();
    _sizeUtils.initUtil(size);
  }

  Future<void> _ejecutarMenu()async{
    final List<PopupMenuEntry<String>> menuItems = _generarMenuItems();
    _currentMenuValue = await showMenu<String>(
      shape: _definePopUpItemShape(),
      context: _context, 
      position: _generateMenuPosition(),
      items: menuItems,
      color: Color.fromRGBO(30, 30, 30, 1)
    );
  }

  ShapeBorder _definePopUpItemShape(){
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(_sizeUtils.xasisSobreYasis * 0.035),
        bottomRight: Radius.circular(_sizeUtils.xasisSobreYasis * 0.035)
      )
    );
  }

  List<PopupMenuItem<String>> _generarMenuItems(){
    final List<PopupMenuItem<String>> items = [];
    final List<String> _navigationStringMenuItemsNames = strings.navigationMenuItems;
    _navigationStringMenuItemsNames.forEach((String name) {
      items.add(
        PopupMenuItem<String>(
          value: name,
          height: _sizeUtils.normalMainMenuPopUpMenuItemHeigh,
          child: _createPupUpMenuItemChild(name)
        )
      );
    });
    return items;
  }

  RelativeRect _generateMenuPosition(){
    return RelativeRect.fromLTRB(
      _sizeUtils.xasisSobreYasis * 0.005, 
      _sizeUtils.xasisSobreYasis * 0.2,
      _sizeUtils.xasisSobreYasis * 0.6 - 1, 
      _sizeUtils.xasisSobreYasis * 1.2
    );
  }

  Widget _createPupUpMenuItemChild(String name){
    return Container(
      child: Text(
        name,
        style: TextStyle(
          color: Colors.white.withOpacity(0.65),
          fontSize: _sizeUtils.normalTextSize * 1.05
        ),
      ),
    );
  }
}