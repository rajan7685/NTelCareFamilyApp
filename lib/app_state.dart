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

  String ImgHeart = "assets/images/15-health_.png";
  String ImgSteps = "assets/images/8679613_footprint_line_icon_.png";
  String ImgBpm = "assets/images/01_.png";
  String ImgCalories = "assets/images/Group_689_.png";
  String ImgSleep = "assets/images/Layer_2_.png";
  String ImgBattery = "assets/images/65-battery_.png";

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
