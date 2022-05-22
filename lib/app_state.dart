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

  String Heart = 'Missing';
  String Email = '';
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
