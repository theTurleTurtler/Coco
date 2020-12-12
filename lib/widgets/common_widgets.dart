import 'package:flutter/material.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


// ignore: must_be_immutable
class HeaderLogo extends StatelessWidget {
  SizeUtils _sizeUtils;
  @override
  Widget build(BuildContext context) {
    _sizeUtils = SizeUtils();
    final Map<String, dynamic> logoSize = _sizeUtils.littleMainLogoSize;
    return Center(
      child: Image.asset(
        'assets/logo_coco_2.png',
        height: logoSize['vertical'],
        width: logoSize['horizontal'],
        fit: BoxFit.cover,
      ),
    );
  }
}

enum PreIngresoIconButtonTypes{
  Email,
  Facebook,
  Google
}

//TODO: Cambiar este apestoso nombre por uno mejor
// ignore: must_be_immutable
class PreIngresoIconButton extends StatelessWidget {

  final PreIngresoIconButtonTypes _iconType;
  final String _buttonNavigationRoute;

  BuildContext _context;
  SizeUtils _sizeUtils;
  Widget _iconButton;
  
  PreIngresoIconButton.email(String buttonNavigationRoute)
  :_buttonNavigationRoute = buttonNavigationRoute,
    _iconType = PreIngresoIconButtonTypes.Email
    ;

  PreIngresoIconButton.facebook(String buttonNavigationRoute)
  :_buttonNavigationRoute = buttonNavigationRoute,
    _iconType = PreIngresoIconButtonTypes.Facebook
    ;

  PreIngresoIconButton.google(String buttonNavigationRoute)
  :_buttonNavigationRoute = buttonNavigationRoute,
    _iconType = PreIngresoIconButtonTypes.Google
    ;

  @override
  Widget build(BuildContext appContext) {
    _initInitialValues(appContext);
    return _iconButton;
  }

  void _initInitialValues(BuildContext appContext){
    _context = appContext;
    _sizeUtils = SizeUtils();
    _initIconButton();
  }

  void _initIconButton(){
    switch(_iconType){
      case PreIngresoIconButtonTypes.Email:
        _initEmailIconButton();
      break;
      case PreIngresoIconButtonTypes.Facebook:
        _initFacebookIconButton();
      break;
      case PreIngresoIconButtonTypes.Google:
        _initGoogleIconButton();
      break;
    }
  }

  void _initEmailIconButton(){
    final Map<String, double> paddings = _sizeUtils.circleButtonPadding;
    final double horizontalPadding = paddings['horizontal'];
    final double verticalPadding = paddings['vertical'];
    _iconButton = MaterialButton(
      color: Colors.grey[600],
      shape: CircleBorder(),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      child: Icon(
        Icons.email,
        size: _sizeUtils.normalIconSize,
        color: Colors.white,
      ),
      onPressed: (){
        Navigator.of(_context).pushNamed(_buttonNavigationRoute);
      },
    );
  }

  void _initFacebookIconButton(){
    _iconButton = IconButton(
      color: Color.fromRGBO(59, 89, 152, 1),
      iconSize: _sizeUtils.extraLargeIconSize,
      icon: Icon(
        FontAwesomeIcons.facebook,
      ),
      onPressed: (){
        Navigator.of(_context).pushNamed(_buttonNavigationRoute);
      },
    );
  }

  void _initGoogleIconButton(){
    _iconButton = IconButton(
      color: Color.fromRGBO(219, 68, 55, 1),
      iconSize: _sizeUtils.extraLargeIconSize,
      icon: Icon(
        FontAwesomeIcons.googlePlus,
      ),
      onPressed: (){
        Navigator.of(_context).pushNamed(_buttonNavigationRoute);
      },
    );
  }
}

