import 'package:coco/services/basic_service.dart';

class CasosService extends BasicService{
  final String _panelUrl = BasicService.apiUrl + 'panel/';

  Future<Map<String, dynamic>> loadCasos(Map<String, String> headers)async{
    final String requestUrl = _panelUrl + 'casos';
    final Map<String, Map<String, dynamic>> headersAndBody = createHeadersAndBodyForARequest(headers: headers);
    await executeGeneralEndOfRequest(headersAndBody: headersAndBody, requestUrl: requestUrl, requestType: RequestType.GET);
    return currentResponseBody;
  }

  Future<Map<String, dynamic>> createCaso()async{
    return currentResponseBody;
  }


  Future<Map<String, dynamic>> createTitulo()async{
    return currentResponseBody;
  }


  Future<Map<String, dynamic>> createDescripcion()async{
    return currentResponseBody;
  }


  Future<Map<String, dynamic>> createDireccion()async{
    return currentResponseBody;
  }

}

final CasosService casosService = CasosService();