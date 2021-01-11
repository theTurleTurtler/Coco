import 'package:coco/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:coco/blocs/user/user_services_manager.dart';
import 'package:coco/utils/static_data/navigation_utils.dart' as navigation;
//Navegación
// ignore: must_be_immutable
class NavigationMenu extends StatelessWidget {
  UserServicesManager _userServicesManager;
  BuildContext _context;
  SizeUtils _sizeUtils;
  //TODO: Implementar uso del _currentMenuValue
  @override
  Widget build(BuildContext context) {
    _userServicesManager = UserServicesManager(appContext: context);
    _initInitialConfiguration(context);
    return GestureDetector(
      child: Container(
        padding: _crearButtonPadding(),
        child: Icon(
          Icons.menu,
          color: Colors.white,
          size: _sizeUtils.normalIconSize * 0.9,
        ),
        decoration: _crearButtonDecoration(),
      ),
      onTap: (){
        _ejecutarMenu();
      },
    );
  }

  EdgeInsets _crearButtonPadding(){
    return EdgeInsets.symmetric(
      vertical: _sizeUtils.xasisSobreYasis * 0.01,
      horizontal: _sizeUtils.xasisSobreYasis * 0.01
    );
  }

  BoxDecoration _crearButtonDecoration(){
    return BoxDecoration(
      borderRadius: BorderRadius.circular(_sizeUtils.xasisSobreYasis * 0.1),
      color: Theme.of(_context).primaryColorDark
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
    await showMenu<String>(
      shape: _definePopUpItemShape(),
      context: _context, 
      position: _generateMenuPosition(),
      items: menuItems,
      //color: Color.fromRGBO(30, 30, 30, 1)
      color: Colors.grey[100]
    );
  }

  ShapeBorder _definePopUpItemShape(){
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(_sizeUtils.xasisSobreYasis * 0.025),
        bottomRight: Radius.circular(_sizeUtils.xasisSobreYasis * 0.025)
      )
    );
  }

  List<PopupMenuItem<String>> _generarMenuItems(){
    final List<PopupMenuItem<String>> items = [];
    final List<Map<String, dynamic>> _navigationMenuInformationItems = navigation.navigationMenuItems;
    _navigationMenuInformationItems.forEach((Map<String, dynamic> currentItem) {
      items.add(
        PopupMenuItem<String>(
          value: currentItem['name'],
          height: _sizeUtils.normalMainMenuPopUpMenuItemHeigh,
          child: _createPupUpMenuItemChild(currentItem)
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

  Widget _createPupUpMenuItemChild(Map<String, dynamic> currentItem){
    return GestureDetector(
      child: Container(
        height: _sizeUtils.normalMainMenuPopUpMenuItemHeigh,
        width: double.infinity,
        decoration: _createPopUpMenuItemChildDecoration(currentItem['route']),
        child: Center(
          child: Text(
            currentItem['name'],
            style: TextStyle(
              color: Colors.black87,
              fontSize: _sizeUtils.normalTextSize * 1.05
            ),
          ),
        ),
      ),
      onTap: (){
        Navigator.of(_context).pushNamed(currentItem['route']);
      },
    );
  }
}

BoxDecoration _createPopUpMenuItemChildDecoration(String route){
  Border border;
  if(route == 'crear_caso'){
    border = Border(
      top: BorderSide(
        color: Colors.white
      )
    );
  }else{
    border = Border(
      top: BorderSide(
        color: Colors.black87
      )
    );
  }
  return BoxDecoration(
    border: border
  );
}

