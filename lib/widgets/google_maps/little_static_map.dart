import 'package:coco/utils/size_utils.dart';
import 'package:coco/widgets/google_maps/google_maps_component.dart';
import 'package:flutter/material.dart';

class LittleStaticMap extends StatelessWidget {
  final double heightPercentage;

  BuildContext _context;
  SizeUtils _sizeUtils;

  LittleStaticMap({
    this.heightPercentage
  });

  @override
  Widget build(BuildContext appContext) {
    _initInitialConfiguration(appContext);
    return Container(
      height: _sizeUtils.xasisSobreYasis * heightPercentage,
      width: double.infinity,
      child: Stack(
        children: [
          GoogleMapsComponent(),
          _createContainerBlocker()
        ],
      ),
    );
  }

  void _initInitialConfiguration(BuildContext appContext){
    _context = appContext;
    _sizeUtils = SizeUtils();
  }

  Widget _createContainerBlocker(){
    return GestureDetector(
      child: Container(
        height: _sizeUtils.xasisSobreYasis * heightPercentage, 
        width: double.infinity,
        color: Colors.transparent,
      ),
      onTap: _showMapDialog,
    );
  }

  void _showMapDialog(){
    showDialog(
      context: _context,
      child: Dialog(
        child: Container(
          height: _sizeUtils.xasisSobreYasis * 0.75,
          width: double.infinity,
          child: GoogleMapsComponent(),
        )
      )
    );
  }
}