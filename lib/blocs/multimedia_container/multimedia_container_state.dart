part of 'multimedia_container_bloc.dart';

@immutable
class MultimediaContainerState {
  final bool hasAnyFile;
  final List<File> photos;
  final List<File> videos;
  MultimediaContainerState({
    bool hasAnyFile,
    List<File> photos,
    List<File> videos
  }):
    this.hasAnyFile = hasAnyFile??false,
    this.photos = photos??[],
    this.videos = videos??[]
    ;

  MultimediaContainerState copyWith({
    bool hasAnyFile,
    List<File> photos,
    List<File> videos
  }) => MultimediaContainerState(
    hasAnyFile: hasAnyFile??this.hasAnyFile,
    photos: photos??this.photos,
    videos: videos??this.videos
  );

  MultimediaContainerState reset() => MultimediaContainerState();

  List<File> get items{
    List<File> items = photos;
    items.addAll(videos);
    return items;
  }
}

