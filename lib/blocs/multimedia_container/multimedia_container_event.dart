part of 'multimedia_container_bloc.dart';

@immutable
abstract class MultimediaContainerEvent {}

class SetMultimediaItem extends MultimediaContainerEvent{
  final File item;
  final void Function({String fileName}) onFileFormatErr;
  SetMultimediaItem({
    @required this.item,
    @required this.onFileFormatErr
  });
}

class DeleteMultimediaItem extends MultimediaContainerEvent{
  final String itemPath;
  final String tipoFile;
  DeleteMultimediaItem({
    @required this.itemPath,
    @required this.tipoFile
  });
}
