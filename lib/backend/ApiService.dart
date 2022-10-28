class ApiService {
  static final bool _debug = true;

  static final String _productionUrl = 'https://api.ntelcare.com';
  static final String _testingUrl = 'https://stgapi.ntelcare.com';

  static String domain = _debug ? _testingUrl : _productionUrl;
}
