class ApiService {
  static final bool _debug = false;

  // static final String _productionUrl =
  //     'https://netlcare-admin-api.regamicompass.com';

  static final String _productionUrl = 'https://api.ntelcare.com';
  static final String _testingUrl = 'http://35.87.46.41:5000/';

  static String domain = _debug ? _testingUrl : _productionUrl;
}
