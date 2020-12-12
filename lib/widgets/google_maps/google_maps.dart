import 'package:coco/utils/size_utils.dart';
import 'package:flutter/material.dart';
class GoogleMapsComponent extends StatefulWidget {

  final double widthPercentage;
  final double heightPercentage;

  GoogleMapsComponent({
    @required this.widthPercentage,
    @required this.heightPercentage
  });

  @override
  _GoogleMapsComponentState createState() => _GoogleMapsComponentState();
}

class _GoogleMapsComponentState extends State<GoogleMapsComponent> {
  //test: 4.274903159597256, -74.81690691028598
  BuildContext _context;
  SizeUtils _sizeUtils;
  
  @override
  Widget build(BuildContext appContext) {
    _initInitialConfiguration(appContext);
    return Container(
      height: _sizeUtils.xasisSobreYasis * widget.heightPercentage,
      width: _sizeUtils.xasisSobreYasis * widget.widthPercentage,
      decoration: _createMapBoxDecoration(),
      child: Center(
        child: Text('Google Maps'),
      ),
    );
  }

  void _initInitialConfiguration(BuildContext appContext){
    _context = appContext;
    _sizeUtils = SizeUtils();
  }

  BoxDecoration _createMapBoxDecoration(){
    return BoxDecoration(
      color: Theme.of(_context).primaryColor,
      borderRadius: BorderRadius.circular(_sizeUtils.xasisSobreYasis * 0.0075)
    );
  }
}