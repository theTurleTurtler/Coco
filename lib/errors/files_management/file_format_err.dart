import 'package:meta/meta.dart';
import 'package:coco/errors/custom_error.dart';
import 'package:coco/errors/error_types.dart';

class FileFormatErr extends CustomError{
  final List<String> _formatosAdmitidos = ['jpg', 'jpeg', 'png', 'mp4'];
  
  FileFormatErr({
    @required String fileName,
    dynamic extraInformation
  }):super(type: ErrorTypes.FILEFORMAT, extraInformation: extraInformation){
    this.message = 'El archivo con nombre $fileName tiene un formato distinto al admitido. Solo se admiten archivos con formato:';
    for(int i = 0; i < _formatosAdmitidos.length; i++){
      final String formato = _formatosAdmitidos[i];
      if(i < _formatosAdmitidos.length - 1)
        this.message += ' $formato,';
      else
        this.message += ' y $formato.';
    }
  }
}