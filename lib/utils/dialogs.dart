import 'dart:io';
import 'package:coco/blocs/multimedia_container/multimedia_container_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:coco/utils/size_utils.dart';

enum TypeOfFilePick{
  CargarImagen,
  TomarImagen,
  CargarVideo,
  GrabarVideo
}

final Map<TypeOfFilePick, String> _textsForFilePickButtons = {
  TypeOfFilePick.CargarImagen: 'Subir foto',
  TypeOfFilePick.TomarImagen: 'Tomar foto',
  TypeOfFilePick.CargarVideo: 'Subir video',
  TypeOfFilePick.GrabarVideo: 'Grabar video'
};
final ImagePicker _imagePicker = ImagePicker();
final SizeUtils _sizeUtils = SizeUtils();

Future<void> executeLoadFile(BuildContext context, Map<String, File> fileMap)async{
  try{
    await _showLoadFileDialog(context, fileMap);
  }catch(err){
    print(err);
  }
  
}

Future<void> _showLoadFileDialog(BuildContext context, Map<String, File> fileMap)async{
  File file;
  await showDialog(
    context: context,
     builder: (BuildContext buildContext){
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_sizeUtils.xasisSobreYasis * 0.025)
        ),
        child: Container(         
          padding: EdgeInsets.symmetric(vertical:0.0),
          height: _sizeUtils.xasisSobreYasis * 0.35,
          width: _sizeUtils.xasisSobreYasis * 0.48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.45),
            borderRadius: BorderRadius.circular(_sizeUtils.xasisSobreYasis * 0.025)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _createLoadFileButton(context, file, fileMap, TypeOfFilePick.CargarImagen),
              _createCargarImagenDialogSeparater(),
              _createLoadFileButton(context, file, fileMap, TypeOfFilePick.TomarImagen),
              _createCargarImagenDialogSeparater(),
              _createLoadFileButton(context, file, fileMap, TypeOfFilePick.CargarVideo),
              _createCargarImagenDialogSeparater(),
              _createLoadFileButton(context, file, fileMap, TypeOfFilePick.GrabarVideo),
            ],
          ),
        ),
      );
    }
  );
}

Widget _createCargarImagenDialogSeparater(){
  return Container(
    color: Colors.black.withOpacity(0.3),
    height: _sizeUtils.xasisSobreYasis * 0.00175,
  );
}

Widget _createLoadFileButton(BuildContext context, File file, Map<String, File> fileMap, TypeOfFilePick typeOfFilePick){
  return CupertinoButton(
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
    //color: Colors.blueGrey.withOpacity(0.35),
    child: Text(
      _textsForFilePickButtons[typeOfFilePick],
      style: TextStyle(
        color: Colors.black.withOpacity(0.45),
        fontSize: _sizeUtils.xasisSobreYasis * 0.027
      ),
    ),
    onPressed: ()async{
      file = await _procesarFile(context, typeOfFilePick);
      fileMap['file'] = file;
      Navigator.of(context).pop(file);
    }
  );
}

Future<File> _procesarFile(BuildContext context, TypeOfFilePick typeOfFilePick)async{
  PickedFile pickedFile;
  switch(typeOfFilePick){
    case TypeOfFilePick.CargarImagen:
      pickedFile = await _imagePicker.getImage(
        source: ImageSource.gallery
      );
      break;
    case TypeOfFilePick.TomarImagen:
      pickedFile = await _imagePicker.getImage(
        source: ImageSource.camera
      );
      break;      
    case TypeOfFilePick.CargarVideo:
      pickedFile = await _imagePicker.getVideo(
        source: ImageSource.gallery
      );
      break;
    case TypeOfFilePick.GrabarVideo:
      pickedFile = await _imagePicker.getVideo(
        source: ImageSource.camera
      );
      break;
  }
  File file = null;
  if(pickedFile != null)
    file = File(pickedFile.path);
  return file;    
}


void showVisualizableFileDialog(BuildContext context, Widget widget){
  showDialog(
    context: context,
    child: Dialog(
      child: widget,
    )
  );
}

void showDeleteFileDialog({BuildContext context, String filePath, FileType fileType}){
  showDialog(
    context: context,
    child: Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: _sizeUtils.xasisSobreYasis * 0.08),
      child: Container(
        color: Theme.of(context).secondaryHeaderColor.withOpacity(0.4),
        margin: EdgeInsets.symmetric(vertical: _sizeUtils.xasisSobreYasis * 0.01),
        height: _sizeUtils.xasisSobreYasis * 0.2,
        width: _sizeUtils.xasisSobreYasis * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Eliminar archivo',
              style: TextStyle(
                fontSize: _sizeUtils.subtitleSize
              ),
            ),
            _createAceptarCancelarButtons(context, filePath, fileType)
          ],
        )
      )
    )
  );
}

Widget _createAceptarCancelarButtons(BuildContext context, String filePath, FileType fileType){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      _createDialogMaterialButton('Aceptar', () => _removeMultimediaItem(context, filePath, fileType)),
      _createDialogMaterialButton('Cancelar', ()=>_popNavigator(context))
    ],
  );
}

Widget _createDialogMaterialButton(String text, Function onPressed){
  return MaterialButton(
    padding: EdgeInsets.symmetric(horizontal: _sizeUtils.xasisSobreYasis * 0.0475),
    child: Text(
      text
    ),
    onPressed: onPressed,
  );
}

void _removeMultimediaItem(BuildContext context, String filePath, FileType fileType){
  final MultimediaContainerBloc mcBloc = BlocProvider.of<MultimediaContainerBloc>(context);
  final DeleteMultimediaItem deleteMultItemEvent = DeleteMultimediaItem(itemPath: filePath, tipoFile: fileType);
  mcBloc.add(deleteMultItemEvent);
  _popNavigator(context);
}

void _popNavigator(BuildContext context){
  Navigator.of(context).pop();
}