class ApiService {
  static final bool _debug = true;

  // static final String _productionUrl =
  //     'https://netlcare-admin-api.regamicompass.com';

  static final String _productionUrl = 'https://api.ntelcare.com';
  static final String _testingUrl = 'https://b5e3-111-223-28-67.in.ngrok.io';

  static String domain = _debug ? _testingUrl : _productionUrl;
}
