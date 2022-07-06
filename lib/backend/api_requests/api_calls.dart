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
      returnBody: true,
    );
  }
}

class DeleteUserCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'DeleteUser',
      apiUrl: 'http://18.208.148.208:4000/delete/member/',
      callType: ApiCallType.DELETE,
      headers: {'Authorization': 'Bearer ${FFAppState().Token}'},
      params: {"member_id": FFAppState().MemberId},
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
      apiUrl: 'http://18.208.148.208:4000/get/members/member',
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
      params: {"m_acc_id": "6299517488b3bba4d3df12ce"},
      returnBody: true,
    );
  }
}

class GetProfile {
  static Future<dynamic> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'getProfile',
      apiUrl: 'http://18.208.148.208:4000/get/profile/member',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${FFAppState().Token}',
      },
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

class DashBoardStat {
  static Future<dynamic> call({
    String id = "",
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'DashBoardStat',
      apiUrl: 'http://18.208.148.208:4000/dashboard/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${FFAppState().Token}',
      },
      params: {},
      returnBody: true,
    );
  }
}

class GetHrate {
  static Future<dynamic> call({
    String id = "",
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'GetHrate',
      apiUrl:
          'http://18.208.148.208:4000/graph/health_status/?senior_id=6299544d88b3bba4d3df12d4',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${FFAppState().Token}',
      },
      params: {},
      returnBody: true,
    );
  }
}
