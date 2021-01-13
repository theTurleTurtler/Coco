import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
final SizeUtils sizeUtils = SizeUtils();

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
          borderRadius: BorderRadius.circular(sizeUtils.xasisSobreYasis * 0.025)
        ),
        child: Container(         
          padding: EdgeInsets.symmetric(vertical:0.0),
          height: sizeUtils.xasisSobreYasis * 0.35,
          width: sizeUtils.xasisSobreYasis * 0.48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.45),
            borderRadius: BorderRadius.circular(sizeUtils.xasisSobreYasis * 0.025)
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
    height: sizeUtils.xasisSobreYasis * 0.00175,
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
        fontSize: sizeUtils.xasisSobreYasis * 0.027
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

void showDeleteFileDialog({BuildContext context, String fileName, String fileType}){
  showDialog(
    context: context,
    child: Dialog(
      child: Container(
        height: sizeUtils.xasisSobreYasis * 0.35,
        width: sizeUtils.xasisSobreYasis * 0.45,
        child: Column(
          children: [
            Text('Eliminar archivo'),
            Row(
              children: [
                //Sí o no
                MaterialButton(),
                MaterialButton()
              ],
            )
          ],
        )
      )
    )
  );
}