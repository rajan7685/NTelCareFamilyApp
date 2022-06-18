import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _Chattoggle2 = prefs.getBool('ff_Chattoggle2') ?? _Chattoggle2;
  }

  SharedPreferences prefs;

  String Steps = 'Data Not found';

  String hear;
  String AccessToken = '';
  String RefreshToken = '';
  String LoginMessage = '';
  String ForgotMessage = '';
  String VerificationMessage = '';
  String ResetMessage = '';
  String Heart = 'Missing';
  String Mobile = '';
  String First_Name = '';
  String Last_Name = '';
  String Profile_Picture = '';
  String IsUserLogin = '';
  String Error = '';
  String Token = '';
  String UserId = '';
  String AccountId = '';
  String RoleId = '';
  String IsLiveView = '';
  bool Chattoggle = false;

  bool _Chattoggle2 = false;
  bool get Chattoggle2 => _Chattoggle2;
  set Chattoggle2(bool _value) {
    _Chattoggle2 = _value;
    prefs.setBool('ff_Chattoggle2', _value);
  }

  bool _Chattoggle3 = false;
  bool get Chattoggle3 => _Chattoggle3;
  set Chattoggle3(bool _value) {
    _Chattoggle3 = _value;
    prefs.setBool('ff_Chattoggle3', _value);
  }

  bool _Chattoggle4 = false;
  bool get Chattoggle4 => _Chattoggle4;
  set Chattoggle4(bool _value) {
    _Chattoggle4 = _value;
    prefs.setBool('ff_Chattoggle4', _value);
  }

  bool _Chattoggle5 = false;
  bool get Chattoggle5 => _Chattoggle5;
  set Chattoggle5(bool _value) {
    _Chattoggle5 = _value;
    prefs.setBool('ff_Chattoggle4', _value);
  }
}

LatLng _latLngFromString(String val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
