import 'package:coco/services/basic_service.dart';

class UserService extends BasicService{
  final String _authUrl = BasicService.apiUrl + 'auth/';

  Future<Map<String, dynamic>> login(Map<String, dynamic> bodyData)async{
    final String requestUrl = _authUrl + 'login';
    await executeGeneralRequestWithoutHeaders(bodyData, requestUrl, RequestType.POST);
    return currentResponseBody;
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> bodyData)async{
    final String requestUrl = _authUrl + 'register';
    await executeGeneralRequestWithoutHeaders(bodyData, requestUrl, RequestType.POST);
    return currentResponseBody;
  }

  Future<Map<String, dynamic>> getUserInformation(Map<String, dynamic> bodyData)async{
    final String requestUrl = _authUrl + 'me';
    await executeGeneralRequestWithoutHeaders(bodyData, requestUrl, RequestType.POST);
    return currentResponseBody;
  }

  Future<Map<String, dynamic>> logout(Map<String, dynamic> bodyData)async{
    final String requestUrl = _authUrl + 'logout';
    await executeGeneralRequestWithoutHeaders(bodyData, requestUrl, RequestType.POST);
    return currentResponseBody;
  }

  Future<Map<String, dynamic>> refreshAccessToken(Map<String, dynamic> bodyData)async{
    final String requestUrl = _authUrl + 'refresh';
    await executeGeneralRequestWithoutHeaders(bodyData, requestUrl, RequestType.POST);
    return currentResponseBody;
  }
}

final UserService userService = UserService();