class ApiService {
  static final bool _debug = true;

  // static final String _productionUrl =
  //     'https://netlcare-admin-api.regamicompass.com';

  static final String _productionUrl = 'https://api.ntelcare.com';
  // static final String _testingUrl = 'http://18.208.148.208:4000';
  static final String _testingUrl = 'https://5058-111-223-28-66.in.ngrok.io';

  static String domain = _debug ? _testingUrl : _productionUrl;
}
