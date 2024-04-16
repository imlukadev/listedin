// import 'dart:io';

import 'dart:io';

import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String url});
}

class HttpClient implements IHttpClient {
  final  client = http.Client();

  set badCertificateCallback(bool Function(X509Certificate cert, String host, int port) badCertificateCallback) {}

  @override
  Future get({required String url}) async {
    return await client.get(Uri.parse(url));
  }
}
