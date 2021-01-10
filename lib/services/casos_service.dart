import 'package:coco/services/basic_service.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class CasosService extends BasicService{
  final String _panelUrl = BasicService.apiUrl + 'panel/';

  Future<Map<String, dynamic>> loadCasos(Map<String, String> headers)async{
    final String requestUrl = _panelUrl + 'casos';
    final Map<String, Map<String, dynamic>> headersAndBody = createHeadersAndBodyForARequest(headers: headers);
    await executeGeneralEndOfRequest(headersAndBody: headersAndBody, requestUrl: requestUrl, requestType: RequestType.GET);
    return currentResponseBody;
  }

  Future<Map<String, dynamic>> createCaso(Map<String, dynamic> body)async{
    final String requestUrl = _panelUrl + 'casos';
    final Map<String, Map<String, dynamic>> headersAndBody = createHeadersAndBodyForARequest(body: body);
    await executeGeneralEndOfRequest(requestType: RequestType.POST, requestUrl: requestUrl, headersAndBody: headersAndBody);
    return currentResponseBody;
  }


  Future<Map<String, dynamic>> createTitulo(Map<String, dynamic> body)async{
    final String requestUrl = _panelUrl + 'titulos';
    final Map<String, Map<String, dynamic>> headersAndBody = createHeadersAndBodyForARequest(body: body);
    await executeGeneralEndOfRequest(requestType: RequestType.POST, requestUrl: requestUrl, headersAndBody: headersAndBody);   
    return currentResponseBody;
  }


  Future<Map<String, dynamic>> createDescripcion(Map<String, dynamic> body)async{
    final String requestUrl = _panelUrl + 'descripciones';
    final Map<String, Map<String, dynamic>> headersAndBody = createHeadersAndBodyForARequest(body: body);
    await executeGeneralEndOfRequest(requestType: RequestType.POST, requestUrl: requestUrl, headersAndBody: headersAndBody);
    return currentResponseBody;
  }


  Future<Map<String, dynamic>> createDireccion(Map<String, dynamic> body)async{
    final String requestUrl = _panelUrl + 'direcciones';
    final Map<String, Map<String, dynamic>> headersAndBody = createHeadersAndBodyForARequest(body: body);
    await executeGeneralEndOfRequest(requestType: RequestType.POST, requestUrl: requestUrl, headersAndBody: headersAndBody);
    return currentResponseBody;
  }

  Future<Map<String, dynamic>> createLatLong(Map<String, dynamic> body)async{
    final String requestUrl = _panelUrl + 'latlons';
    final Map<String, Map<String, dynamic>> headersAndBody = createHeadersAndBodyForARequest(body: body);
    await executeGeneralEndOfRequest(requestType: RequestType.POST, requestUrl: requestUrl, headersAndBody: headersAndBody);
    return currentResponseBody;
  }

  //TODO: Confirmar implementación y arreglo en el back

  Future<Map<String, dynamic>> createTipo(Map<String, dynamic> body)async{
    final String requestUrl = _panelUrl + 'tipos';
    final Map<String, Map<String, dynamic>> headersAndBody = createHeadersAndBodyForARequest(body: body);
    await executeGeneralEndOfRequest(requestType: RequestType.POST, requestUrl: requestUrl, headersAndBody: headersAndBody);
    return currentResponseBody;
  }

  Future<Map<String, dynamic>> createMultimedia(Map<String, String> headers, Map<String, String> fields, Map<String, List<File>> multimedia)async{
    final String requestUrl = _panelUrl + 'multimedias';
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(requestUrl)
    );
    request.headers.addAll(headers);
    request.fields.addAll(fields);
    request.files.addAll(
      _generateMultipartFilesGroup(multimedia['photos'], 'fotos[]'),
      
    );
    request.files.addAll(
      _generateMultipartFilesGroup(multimedia['videos'], 'videos[]'),
    );
    final http.StreamedResponse streamedResponse = await request.send();
    final http.Response serverResponse = await http.Response.fromStream(streamedResponse);
    evaluateServerResponse(serverResponse);
    return currentResponseBody;
  }

  Iterable<http.MultipartFile> _generateMultipartFilesGroup(List<File> files, String fieldName){
    final Iterable<http.MultipartFile> multipartGroup = files.map((File file){
      print(file);
      return http.MultipartFile(
        fieldName,
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: file.path.split('/').last
      );
    });
    return multipartGroup;
  }
}



final CasosService casosService = CasosService();