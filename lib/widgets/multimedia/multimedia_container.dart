import 'dart:io';
import 'package:coco/widgets/multimedia/visualizable_image.dart';
import 'package:coco/widgets/multimedia/visualizable_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coco/blocs/multimedia_container/multimedia_container_bloc.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/widgets/multimedia/static_video_player.dart';
import 'package:coco/utils/dialogs.dart' as dialogs;
class MultimediaContainer extends StatelessWidget {
  BuildContext _context;
  SizeUtils _sizeUtils;

  @override
  Widget build(BuildContext appContext) {
    _initInitialConfig(appContext);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _sizeUtils.xasisSobreYasis * 0.015),
      padding: EdgeInsets.symmetric(vertical: 0),
      //0.18 es el porcentaje de width de pantalla que tiene cada card (?).
      height: _sizeUtils.xasisSobreYasis * 0.45,
      width: MediaQuery.of(appContext).size.width * 0.98,     
      decoration: BoxDecoration(
        color: Colors.white70,
      ),
      /**
       * En 2 casos lo necesito scrollable, en 1 no
       */
      child: BlocBuilder<MultimediaContainerBloc, MultimediaContainerState>(
        builder: (_, MultimediaContainerState state){
          if(state.hasAnyFile){
            return _createMultimediaGrid(state);
          }else{
            return _createEmptyGrid();
          }
        },
      ),
    );
  }

  void _initInitialConfig(BuildContext appContext){
    _context = appContext;
    _sizeUtils = SizeUtils();
  }
  

  Widget _createMultimediaGrid(MultimediaContainerState state){
    return GridView.count(
      padding: EdgeInsets.symmetric(
        vertical: _sizeUtils.xasisSobreYasis * 0.02,
        horizontal: _sizeUtils.xasisSobreYasis * 0.02
      ),
      crossAxisCount: 3,
      mainAxisSpacing: _sizeUtils.xasisSobreYasis * 0.0175,
      crossAxisSpacing: _sizeUtils.xasisSobreYasis * 0.022,
      childAspectRatio: 1,
      children: _createMultimediaItemContainers(state),
    );
  }

  List<Widget> _createMultimediaItemContainers(MultimediaContainerState state){
    final List<Widget> itemsContainers = [];
    final List<File> photos = state.photos;
    final List<File> videos = state.videos;
    photos.forEach((File photo) {
      itemsContainers.add(_createPhotoContainer(photo));
    });
    videos.forEach((File video) {
      itemsContainers.add(_createVideoContainer(video));
    });
    return itemsContainers;
  }

  Widget _createPhotoContainer(File photo){
    return GestureDetector(
      child: Container(
        child: Image.file(
          photo,
          height: _sizeUtils.xasisSobreYasis * 0.03,
          width: _sizeUtils.xasisSobreYasis * 0.03,
          fit: BoxFit.contain
        ),
      ),
      onTap: (){
        dialogs.showVisualizableFileDialog(_context, VisualizableImage(file: photo));
      },
    );
  }

  Widget _createVideoContainer(File video){
    return GestureDetector(
      child: CustomVideoPlayer(
        key: Key(video.path),
        file: video
      ),
      onTap: (){
        dialogs.showVisualizableFileDialog(_context, VisualizableVideoPlayer(file: video));
      },
    );
  }
  
  Widget _createEmptyGrid(){
    return Container(
      height: _sizeUtils.xasisSobreYasis * 0.02,
      width: MediaQuery.of(_context).size.width,
      color: Colors.blueGrey[100],
    );
  }
}