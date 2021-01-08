import 'package:coco/services/basic_service.dart';

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

  Future<Map<String, dynamic>> createEstado(Map<String, dynamic> body)async{
    final String requestUrl = _panelUrl + 'casos';
    final Map<String, Map<String, dynamic>> headersAndBody = createHeadersAndBodyForARequest(body: body);
    await executeGeneralEndOfRequest(requestType: RequestType.POST, requestUrl: requestUrl, headersAndBody: headersAndBody);
    return currentResponseBody;
  }

  Future<Map<String, dynamic>> createMultimedia(Map<String, dynamic> body)async{
    final String requestUrl = _panelUrl + 'casos';
    final Map<String, Map<String, dynamic>> headersAndBody = createHeadersAndBodyForARequest(body: body);
    await executeGeneralEndOfRequest(requestType: RequestType.POST, requestUrl: requestUrl, headersAndBody: headersAndBody);
    return currentResponseBody;
  }

}

final CasosService casosService = CasosService();