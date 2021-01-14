import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mime_type/mime_type.dart';

part 'multimedia_container_event.dart';
part 'multimedia_container_state.dart';

enum FileType{
  Photo,
  Video
}

class MultimediaContainerBloc extends Bloc<MultimediaContainerEvent, MultimediaContainerState> {
  final Map<FileType, List<String>> _formatsAcceptedForFileType = {
    FileType.Photo:['jpg', 'jpeg', 'png'],
    FileType.Video: ['mp4']
  };
  MultimediaContainerState _currentYieldedState;
  MultimediaContainerBloc() : super(MultimediaContainerState());

  @override
  Stream<MultimediaContainerState> mapEventToState(
    MultimediaContainerEvent event,
  ) async* {
    if(event is SetMultimediaItem){
      _setMultimediaToState(event);
      yield _currentYieldedState;
    }else if(event is DeleteMultimediaItem){
      _deleteMultimediaItem(event);
      yield _currentYieldedState; 
    }
    else if(event is ResetMultimedia){
      yield state.reset();
    }
    
  }

  void _setMultimediaToState(SetMultimediaItem event){
    _currentYieldedState = state.copyWith();
    List<File> photos = state.photos;
    List<File> videos = state.videos;
    final File item = event.item;
    final String fileName = item.path.split('\\').last;
    final mimeType = mime(item.path);
    for(String photoFormat in _formatsAcceptedForFileType[FileType.Photo]){
      if(mimeType.contains(photoFormat)){
        photos.add(item);
        _currentYieldedState = state.copyWith(hasAnyFile: true, photos: photos);
        return;
      }
    }
    for(String videoFormat in _formatsAcceptedForFileType[FileType.Video]){
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
    _currentYieldedState = state.copyWith();
    List<File> photos = state.photos;
    List<File> videos = state.videos;
    final String itemPath = event.itemPath;
    final FileType tipoFile = event.tipoFile;
    File itemToRemove;
    if(tipoFile == FileType.Photo){
      for(File photo in photos){
        if(photo.path == itemPath){
          itemToRemove = photo;
          _currentYieldedState = state.copyWith(photos: photos);
          break;
        }
      }
      photos.remove(itemToRemove);
    }else if(tipoFile == FileType.Video){
      for(File video in videos){
        if(video.path == itemPath){
          itemToRemove = video;
          _currentYieldedState = state.copyWith(videos: videos);
          break;        
        }
      }
      videos.remove(itemToRemove);
    }  
  }
  
}
