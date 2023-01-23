import 'package:dio/dio.dart';

class HttpClient {
  String token = '';

  HttpClient();

  Dio dio = Dio(
    BaseOptions(
        baseUrl:
            'http://10.0.2.2:3001/api', //TODO pobierać url z configu a nie const
        headers: {
          'Content-Type': 'application/json',
        },
        contentType: 'application/json'),
  );

  void setToken(String token1) {
    token = token1;
  }

  Options get postOptions {
    return Options(headers: {'Authorization': 'Bearer $token'});
  }
}
