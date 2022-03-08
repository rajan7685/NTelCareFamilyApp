import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class LoginCall {
  static Future<ApiCallResponse> call({
    String username = '',
    String password = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Login',
      apiUrl:
          'https://ntelcare.com/MobiPortal/Signin.aspx?UserName=${username}&Password=${password}&OSType=I',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class DeleteUserCall {
  static Future<ApiCallResponse> call({
    String token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'DeleteUser',
      apiUrl: 'https://ntelcare.com/MobiPortal/UserDelete.aspx?Token=${token}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class CameraLIstCall {
  static Future<ApiCallResponse> call({
    String token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'CameraLIst',
      apiUrl:
          'https://ntelcare.com/MobiPortal/Cameras.aspx?Token=${token}&OSType=I',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class UserAddCall {
  static Future<ApiCallResponse> call({
    String token = '',
    String firstName = '',
    String lastName = '',
    String email = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'UserAdd',
      apiUrl:
          'https://ntelcare.com/MobiPortal/UserAdd.aspx?Token=${token}&FirstName=${firstName}&LastName=${lastName}&Email=${email}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}
