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
          'http://demo.ntelcare.com/MobiPortal/Signin.aspx?UserName=${username}&Password=${password}&OSType=I',
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
      apiUrl:
          'http://demo.ntelcare.com/MobiPortal/UserDelete.aspx?Token=${token}',
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
          'http://demo.ntelcare.com/MobiPortal/Cameras.aspx?Token=${token}&OSType=I',
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
          'http://demo.ntelcare.com/MobiPortal/UserAdd.aspx?Token=${token}&FirstName=${firstName}&LastName=${lastName}&Email=${email}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class UserEditCall {
  static Future<ApiCallResponse> call({
    String token = '',
    String userId = '',
    String firstName = '',
    String lastName = '',
    String email = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'UserEdit',
      apiUrl:
          'http://demo.ntelcare.com/MobiPortal/UserEdit.aspx?Token=${token}&UserID=${userId}FirstName=${firstName}&LastName=${lastName}&Email=${email}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class ForgotPasswordCall {
  static Future<ApiCallResponse> call({
    String email = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'ForgotPassword',
      apiUrl:
          'http://demo.ntelcare.com/MobiPortal/ForgotPassword.aspx?Email=${email}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class UserList {
  static Future<dynamic> call({
    String token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'UserList',
      apiUrl:
          'http://demo.ntelcare.com/MobiPortal/UserList.aspx?Token=${token}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}
