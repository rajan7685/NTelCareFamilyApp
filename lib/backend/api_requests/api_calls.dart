import 'package:flutter/cupertino.dart';
import 'package:n_tel_care_family_app/backend/ApiService.dart';
import 'package:n_tel_care_family_app/core/shared_preferences_service.dart';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';
import 'package:http/http.dart' as http;

export 'api_manager.dart' show ApiCallResponse;

class LoginCall {
  static Future<ApiCallResponse> call({
    String mobile = "",
    String password = "",
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Login',
      apiUrl: '${ApiService.domain}/login/member',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class DeleteUserCall {
  static Future<ApiCallResponse> call({@required String memberId}) {
    return ApiManager.instance.makeApiCall(
      callName: 'DeleteUser',
      apiUrl: '${ApiService.domain}/delete/member/',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization':
            'Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}'
      },
      params: {"member_id": memberId},
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
          '${ApiService.domain}/MobiPortal/Cameras.aspx?Token=${token}&OSType=I',
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
          '${ApiService.domain}/MobiPortal/UserAdd.aspx?Token=${token}&FirstName=${firstName}&LastName=${lastName}&Email=${email}',
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
          '${ApiService.domain}/MobiPortal/UserEdit.aspx?Token=${token}&UserID=${userId}FirstName=${firstName}&LastName=${lastName}&Email=${email}',
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

class SeniorsList {
  static Future<dynamic> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'SeniorList',
      apiUrl: '${ApiService.domain}/get/seniors/member',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}',
      },
      params: {
        "m_acc_id":
            '${SharedPreferenceService.loadString(key: AccountsKeys.MasterAccountKey)}'
      },
      returnBody: true,
    );
  }
}

class GetProfile {
  static Future<dynamic> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'getProfile',
      apiUrl: '${ApiService.domain}/get/profile/member',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}',
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
      apiUrl: '${ApiService.domain}/dashboard/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}',
      },
      params: {},
      returnBody: true,
    );
  }
}

class GetHrate {
  Future<http.Response> get(String endpoint) async {
    var url = Uri.parse(endpoint);
    var response = await http.get(url, headers: {
      'Authorization':
          'Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}',
    });
    return response;
  }
}

class GetHeartWeek {
  static Future<dynamic> call({String id = '', String date = ''}) {
    return ApiManager.instance.makeApiCall(
      callName: 'getHeartWeekStatus',
      apiUrl:
          '${ApiService.domain}/graph/health_status/heart_rate/weekly?date=${date}&senior_id=${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}',
      },
      // params: {"senior_id": id, "date": date},
      returnBody: true,
    );
  }
}

class GetSteps {
  Future<http.Response> get(String endpoint) async {
    var url = Uri.parse(endpoint);
    var response = await http.get(url, headers: {
      'Authorization':
          'Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}',
    });
    return response;
  }
}

class GetCalories {
  Future<http.Response> get(String endpoint) async {
    var url = Uri.parse(endpoint);
    var response = await http.get(url, headers: {
      'Authorization':
          'Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}',
    });
    return response;
  }
}
