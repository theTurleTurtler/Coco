import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mime_type/mime_type.dart';

part 'multimedia_container_event.dart';
part 'multimedia_container_state.dart';

class MultimediaContainerBloc extends Bloc<MultimediaContainerEvent, MultimediaContainerState> {
  final List<String> _formatosFotos = ['jpg', 'jpeg', 'png'];
  final List<String> _formatosVideos = ['mp4'];
  MultimediaContainerState _currentYieldedState;
  MultimediaContainerBloc() : super(MultimediaContainerState());

  @override
  Stream<MultimediaContainerState> mapEventToState(
    MultimediaContainerEvent event,
  ) async* {
    if(event is SetMultimediaItem){
      _setMultimediaToState(event);
    }else if(event is DeleteMultimediaItem){
      _deleteMultimediaItem(event); 
    }
    yield _currentYieldedState;
  }

  void _setMultimediaToState(SetMultimediaItem event){
    _currentYieldedState = state;
    List<File> photos = state.photos;
    List<File> videos = state.videos;
    final File item = event.item;
    final String fileName = item.path.split('\\').last;
    final mimeType = mime(item.path);
    for(String photoFormat in _formatosFotos){
      if(mimeType.contains(photoFormat)){
        photos.add(item);
        _currentYieldedState = state.copyWith(hasAnyFile: true, photos: photos);
        return;
      }
    }
    for(String videoFormat in _formatosVideos){
      if(mimeType.contains(videoFormat)){
        videos.add(item);
        _currentYieldedState = state.copyWith(hasAnyFile: true, videos: videos);
        return;
      }
    }
    //El nuevo item no cumple con los formatos de vídeo o imagen aceptados
    event.onFileFormatErr(fileName: fileName);
  }

  void _deleteMultimediaItem(DeleteMultimediaItem event){
    List<File> photos = state.photos;
    List<File> videos = state.videos;
    final String itemPath = event.itemPath;
    final String tipoFile = event.tipoFile;
    if(tipoFile == 'photo'){
      photos.forEach((File photo) {
        if(photo.path == itemPath){
          photos.remove(photo);
          _currentYieldedState = state.copyWith(photos: photos);
          return;
        }
      });
    }else{
      videos.forEach((File video){
        if(video.path == itemPath){
          videos.remove(video);
          _currentYieldedState = state.copyWith(videos: videos);
          return;        
        }
      });
    }  
  }
  
}
