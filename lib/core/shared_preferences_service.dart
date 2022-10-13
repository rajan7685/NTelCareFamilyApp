import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

//key constansts
enum AccountsKeys {
  AccessTokenKey,
  MasterAccountKey,
  FCMTokenKey,
  CurrentUserToken,
  Executive,
  ChatPermission,
  LivePermission,
  VideoPermission
}

Map<AccountsKeys, String> _map = {
  AccountsKeys.AccessTokenKey: "AccessToken",
  AccountsKeys.MasterAccountKey: "MasterToken",
  AccountsKeys.FCMTokenKey: "FCMToken",
  AccountsKeys.CurrentUserToken: "CurentUser",
  AccountsKeys.Executive: "executive",
  AccountsKeys.ChatPermission: "chat",
  AccountsKeys.LivePermission: "live_view",
  AccountsKeys.VideoPermission: "view_video",
};

class SharedPreferenceService {
  SharedPreferenceService._();

  static SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveString(
      {@required AccountsKeys key, @required String value}) async {
    return await _prefs.setString(_map[key], value);
  }

  static Future<bool> saveBool(
      {@required AccountsKeys key, @required bool value}) async {
    return await _prefs.setBool(_map[key], value);
  }

  static String loadString({@required AccountsKeys key}) {
    return _prefs.getString(_map[key]);
  }

  static bool loadBool({@required AccountsKeys key}) {
    return _prefs.getBool(_map[key]);
  }

  static Future<bool> clearAuthenticationData() async {
    return await _prefs.clear();
  }
}
