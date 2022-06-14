import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class LoginCall {
  static Future<ApiCallResponse> call({
    String mobile = "",
    String password = "",
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Login',
      apiUrl: 'http://18.208.148.208:4000/login/member',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: mobile,
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
          'http://ntelcare.com/MobiPortal/ForgotPassword.aspx?Email=${email}',
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

class MemberList {
  static Future<dynamic> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'MemberList',
      apiUrl: 'http://demo.ntelcare.com/MobiPortal/MemberList.aspx?',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${FFAppState().Token}',
      },
      params: {},
      returnBody: true,
    );
  }
}

class SeniorsList {
  static Future<dynamic> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'SeniorList',
      apiUrl: 'http://18.208.148.208:4000/get/seniors/member',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${FFAppState().Token}',
      },
      params: {},
      returnBody: true,
    );
  }
}

class CameraList {
  static Future<dynamic> call({
    String token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'CameraList',
      apiUrl:
          'http://demo.ntelcare.com/MobiPortal/Cameras.aspx?Token=${token}&OSType=I',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}
